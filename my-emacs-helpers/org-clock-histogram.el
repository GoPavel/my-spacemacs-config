;;; org-clock-histogram.el --- Org dynamic block clock histogram -*- lexical-binding: t; -*-

;;; Commentary:
;; Dynamic block for showing clocked hours by day/week from `org-agenda-files`.
;;
;; Example usage:
;;
;; #+BEGIN: clock-histogram :bucket day :scope this-week
;; #+END:
;;
;; #+BEGIN: clock-histogram :bucket day :scope this-month
;; #+END:
;;
;; #+BEGIN: clock-histogram :bucket week :scope last-30-days
;; #+END:
;;
;; Supported buckets:
;; - day
;; - week
;;
;; Supported scopes:
;; - all
;; - this-week
;; - this-month
;; - last-30-days
;;
;; Notes:
;; - Clock entries are read from `org-agenda-files`.
;; - Empty days are included for day buckets when scope is not `all`.
;; - For `this-month`, the displayed range is expanded to full weeks:
;;   Monday before/at the first day of the month through Sunday after/at
;;   the last day of the month.
;; - Each histogram square means 30 minutes.
;; - Clock entries that overlap the selected scope are included as whole entries.

;;; Code:

(require 'org)
(require 'org-element)
(require 'cl-lib)

(defun my/org-clock--bucket (bucket)
  "Normalize BUCKET to a symbol."
  (cond
   ((symbolp bucket) bucket)
   ((stringp bucket) (intern bucket))
   ((null bucket) 'day)
   (t 'day)))

(defun my/org-clock--scope (scope)
  "Normalize SCOPE to a symbol."
  (cond
   ((symbolp scope) scope)
   ((stringp scope) (intern scope))
   ((null scope) 'all)
   (t 'all)))

(defun my/org-clock--start-of-day (time)
  "Return TIME normalized to 00:00:00."
  (let ((d (decode-time time)))
    (encode-time 0 0 0
                 (decoded-time-day d)
                 (decoded-time-month d)
                 (decoded-time-year d))))

(defun my/org-clock--end-of-month (time)
  "Return the last day of TIME's month at 00:00:00."
  (let* ((d (decode-time time))
         (month (decoded-time-month d))
         (year (decoded-time-year d))
         (next-month (if (= month 12) 1 (1+ month)))
         (next-year (if (= month 12) (1+ year) year)))
    (time-subtract
     (encode-time 0 0 0 1 next-month next-year)
     (days-to-time 1))))

(defun my/org-clock--monday-of-week (time)
  "Return Monday of TIME's week at 00:00:00."
  (let* ((start (my/org-clock--start-of-day time))
         (dow (string-to-number (format-time-string "%u" start)))) ; 1..7
    (time-subtract start (days-to-time (1- dow)))))

(defun my/org-clock--sunday-of-week (time)
  "Return Sunday of TIME's week at 00:00:00."
  (let* ((start (my/org-clock--start-of-day time))
         (dow (string-to-number (format-time-string "%u" start)))) ; 1..7
    (time-add start (days-to-time (- 7 dow)))))

(defun my/org-clock--scope-range (scope)
  "Return time range for SCOPE as (FROM TO), where TO is exclusive.
Return nil for `all`."
  (let* ((now (current-time))
         (today (decode-time now)))
    (pcase (my/org-clock--scope scope)
      ('all nil)

      ('last-30-days
       (list (time-subtract now (days-to-time 30)) now))

      ('this-week
       (list (my/org-clock--monday-of-week now)
             now))

      ('this-month
       ;; Full calendar weeks: Monday before/at the 1st,
       ;; through Sunday after/at the last day. TO is exclusive.
       (let* ((month-start
               (encode-time 0 0 0
                            1
                            (decoded-time-month today)
                            (decoded-time-year today)))
              (month-end
               (my/org-clock--end-of-month now)))
         (list (my/org-clock--monday-of-week month-start)
               (time-add (my/org-clock--sunday-of-week month-end)
                         (days-to-time 1)))))

      ('this-year
        (let* ((year (decoded-time-year today))
                (year-start (encode-time 0 0 0 1 1 year))
                (year-end (encode-time 0 0 0 1 1 (1+ year))))
          (list year-start year-end)))

      (_
       (error "Unknown scope: %s" scope)))))

(defun my/org-clock--format-day (time)
  "Format TIME as an org-style inactive timestamp."
  (format-time-string "[%Y-%m-%d %a]" time))

(defun my/org-clock--bucket-key (time bucket)
  ;; day starts at 05:00
  (let ((shifted (time-subtract time (seconds-to-time (* 60 60 5)))))
    (pcase bucket
      ('day
       (my/org-clock--format-day shifted))

      ('week
       (format-time-string "%G-W%V" shifted))

      (_
       (error "Unknown bucket: %s" bucket)))))

;; (defun my/org-clock--bucket-key (time bucket)
;;   "Return bucket key for TIME and BUCKET."
;;   (pcase (my/org-clock--bucket bucket)
;;     ('day
;;      (my/org-clock--format-day time))

;;     ('week
;;      (format-time-string "%G-W%V" time))

;;     (_
;;      (error "Unknown bucket: %s" bucket))))

(defun my/org-clock--in-scope-p (start end scope)
  "Return non-nil if clock START..END overlaps SCOPE."
  (let ((range (my/org-clock--scope-range scope)))
    (or (null range)
        (let ((from (car range))
              (to (cadr range)))
          ;; Include entries overlapping the range.
          (and (time-less-p start to)
               (time-less-p from end))))))

(defun my/org-clock--collect-from-buffer (scope)
  "Collect clock entries from current buffer within SCOPE.
Return list of (START END MINUTES)."
  (let (items)
    (org-element-map (org-element-parse-buffer) 'clock
      (lambda (clock)
        (let* ((value (org-element-property :value clock))
               (start-ts (org-timestamp-split-range value))
               (end-ts (org-timestamp-split-range value t)))
          (when end-ts
            (let* ((start (org-timestamp-to-time start-ts))
                   (end (org-timestamp-to-time end-ts))
                   (minutes (/ (float-time (time-subtract end start)) 60.0)))
              (when (my/org-clock--in-scope-p start end scope)
                (push (list start end minutes) items)))))))
    items))

(defun my/org-clock--agenda-files ()
  "Return readable files from `org-agenda-files`."
  (cl-remove-if-not
   #'file-readable-p
   (org-agenda-files t)))

(defun my/org-clock--collect-from-agenda-files (scope)
  "Collect clock entries from `org-agenda-files` within SCOPE."
  (let (items)
    (dolist (file (my/org-clock--agenda-files))
      (with-current-buffer (find-file-noselect file)
        (org-with-wide-buffer
         (setq items
               (append (my/org-clock--collect-from-buffer scope) items)))))
    items))

(defun my/org-clock--each-day-key (from to)
  "Return org-style day keys from FROM to TO inclusive.
Both FROM and TO are normalized to dates."
  (let ((current (my/org-clock--start-of-day from))
        (last (my/org-clock--start-of-day to))
        keys)
    (while (not (time-less-p last current))
      (push (my/org-clock--format-day current) keys)
      (setq current (time-add current (days-to-time 1))))
    (nreverse keys)))

(defun my/org-clock--fill-empty-buckets (rows bucket scope)
  "Add zero-hour rows for empty days in ROWS for BUCKET and SCOPE."
  (let ((range (my/org-clock--scope-range scope)))
    (if (or (null range)
            (not (eq (my/org-clock--bucket bucket) 'day)))
        rows
      (let* ((from (car range))
             ;; Range TO is exclusive, so display through previous day.
             (to (time-subtract (cadr range) (days-to-time 1)))
             (existing (make-hash-table :test 'equal))
             filled)
        (dolist (row rows)
          (puthash (car row) (cdr row) existing))
        (dolist (key (my/org-clock--each-day-key from to))
          (push (cons key (gethash key existing 0.0)) filled))
        (nreverse filled)))))

(defun my/org-clock-histogram (bucket scope)
  "Return histogram rows for BUCKET and SCOPE.
Each row is (PERIOD . HOURS)."
  (let ((table (make-hash-table :test 'equal))
        (bucket (my/org-clock--bucket bucket)))
    (dolist (entry (my/org-clock--collect-from-agenda-files scope))
      (pcase-let ((`(,start _end ,minutes) entry))
        (let ((key (my/org-clock--bucket-key start bucket)))
          (puthash key (+ minutes (gethash key table 0)) table))))
    (let (rows)
      (maphash
       (lambda (key minutes)
         (push (cons key (/ minutes 60.0)) rows))
       table)
      (setq rows (sort rows (lambda (a b) (string< (car a) (car b)))))
      (my/org-clock--fill-empty-buckets rows bucket scope))))

(defun my/org-clock--day-key-sunday-p (key)
  "Return non-nil if org-style day KEY is Sunday."
  (when (string-match "\\[\\([0-9]\\{4\\}\\)-\\([0-9]\\{2\\}\\)-\\([0-9]\\{2\\}\\)" key)
    (let* ((year (string-to-number (match-string 1 key)))
           (month (string-to-number (match-string 2 key)))
           (day (string-to-number (match-string 3 key)))
           (time (encode-time 0 0 0 day month year)))
      (= 7 (string-to-number (format-time-string "%u" time))))))

;;;###autoload
(defun org-dblock-write:clock-histogram (params)
  "Dynamic block for clock histogram from `org-agenda-files`.

PARAMS supports:
- :bucket day|week
- :scope all|this-week|this-month|last-30-days

Each block in the histogram equals 30 minutes."
  (let* ((bucket (plist-get params :bucket))
         (scope (plist-get params :scope))
         (rows (my/org-clock-histogram bucket scope))
         (week-total 0.0))
    (insert "| Period | Hours | Histogram |\n")
    (insert "|-\n")

    (dolist (row rows)
      (let* ((period (car row))
             (hours (cdr row))
             ;; 1 square = 30 minutes.
             (bars (round (* 2 hours))))
        (setq week-total (+ week-total hours))

        (insert
         (format "| %s | %4.1f | %s |\n"
                 period
                 hours
                 (make-string bars ?█)))

        ;; Weekly total after Sunday.
        (when (and (eq (my/org-clock--bucket bucket) 'day)
                   (my/org-clock--day-key-sunday-p period))
          (insert
           (format "| Итого за неделю | %4.1f | %s |\n"
                   week-total
                   (make-string (round (* 2 week-total)) ?█)))
          (insert "|-\n")
          (setq week-total 0.0))))

    ;; If the range ends before Sunday, still show partial week total.
    (when (and (eq (my/org-clock--bucket bucket) 'day)
               (> week-total 0.0))
      (insert
       (format "| Итого за неделю | %4.1f | %s |\n"
               week-total
               (make-string (round (* 2 week-total)) ?█))))))

(provide 'org-clock-histogram)

;;; org-clock-histogram.el ends here
