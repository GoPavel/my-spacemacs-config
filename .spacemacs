;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     ;; < Utilities >
     systemd
     helm
     (unicode-fonts :variables
                    unicode-fonts-enable-ligatures t
                    unicode-fonts-ligature-modes '(text-mode))
     ;; auto-completion ;; use pure company-mode instead
     git
     nixos
     (org :variables
          org-enable-roam-support t
          org-enable-roam-ui t
          org-enable-roam-protocol t)
     spell-checking
     syntax-checking
     version-control
     (emacs-lisp :variables
                 emacs-lisp-format-on-save nil)
     (neotree :variables
              neo-window-width 28
              neo-vc-integration '(face)
              neo-theme 'icons
              neo-hidden-regexp-list '("^\\." "\\.pyc$" "~$" "^#.*#$" "\\.elc$" "\\.o$" "\\.vo$" "\\.glob$" "\\.vok$" "\\.vos$" "^Makefile.coq$" "^Makefile.coq.conf$" "\\.aux$" "\\.bbl$" "\\.bcf$" "\\.blg$" "\\.run.xml$" "\\.fls$" "\\.tdo$" "\\.log$" "\\.out$" "\\.synctex.gz$" "\\.fdb_latexmk$")
              neo-autorefresh t
              neo-smart-open t)
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom)
     reverse-input-method ;; https://github.com/avkorablev/reverse-input-method-layer.git
     pdf ;; `pdf-tools' layer instead of doc-view-mode

     ;; < Language layers >
     ocaml
     python
     markdown
     sql
     html
     idris
     octave
     yaml
     docker
     c-c++
     rust
     (latex :variables
            ;; latex-build-command 'LaTeXMk
            latex-enable-folding t)
     bibtex
     php
     csv
     vimscript
     lua
     typescript
     json
     java
     (elm :variables
          company-idle-delay nil)

     lsp

     ;; Theorem provers
     ;; lean
     ;; fstar
     coq
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '(
    ;; Meta packages
    ssh-agency
    dashboard
    pinentry ;; for git ssh
    exec-path-from-shell ;; ensure env as in shell

    ;; Fancy stuff
    all-the-icons

    ;; Org-mode stuff
    (org-super-links :location (recipe :fetcher github :repo "toshism/org-super-links" :commit "develop"))
    ;; https://github.com/mickeynp/ligature.el (WAIT emacs 28)
    org-gcal ;; sync org-mode with gcalendar
    org-pomodoro ;; to structure your time
    (pomidor :variables ;; to softly keep work/rest balance
             pomidor-break-seconds 300
             pomidor-seconds 1500
             pomidor-sound-tick "nil"
             pomidor-sound-tack "nil")
    org-fancy-priorities
    (olivetti :variables ;; easy reading org files (with margin)
              olivetti-lighter "⌨"
              olivetti-body-width 0.8) ;; TODO doesn't work
    org-analyzer ;; browser UI for time records
                 ;; TODO: support list of files
                 ;; TODO: support color palette for tags
    org-mru-clock ;; show most recent task for quick timetracking
    (clocktable-by-tag
     :location (recipe :fetcher github :repo "cashpw/clocktable-by-tag"
                       :branch "main"))
    (clocktable-by-category
     :location (recipe :fetcher github :repo "cashpw/clocktable-by-category"
                       :branch "main"))
    org-ql
    helm-org-ql

    ;; Languages supplement
    (lsp-mode
     :variables lsp-idle-delay 1
     )

    ;; LSP testing
    ert-runner

    cdlatex
    ;; magic-latex-buffer

    lsp-haskell
    haskell-mode ;; avoid using haskell layer since it's conflicting with lsp-mode

    flycheck-posframe ;; to show diagnostic in tooltip
    flycheck-pos-tip  ;; for console mode

    ;; (ligo-mode :location local) ;; for debug
    ;; ligo-mode

    ;; repo is dead: https://github.com/jcsalomon/smarttabs
    ;; smart-tabs-mode
    (smart-tabs-mode :location (recipe :fetcher github
                                       :repo "miketz/smarttabs"
                                       :branch "master"))
    )
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and uninstall any
   ;; unused packages as well as their unused dependencies.
   ;; `used-but-keep-unused' installs only the used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'emacs
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 15
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers nil
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.

 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."

  (setq-default
   dotspacemacs-scroll-bar-while-scrolling nil)

  ;; TODO: move the all to the user-config

  (add-hook 'coq-mode-hook #'column-enforce-mode)
  (setq-default dotspacemacs-configuration-layers
    '(syntax-checking :variables syntax-checking-enable-by-default nil))
  (add-hook 'LaTeX-mode-hook (lambda () (set-fill-column 103))) ;; half monitor width
  (add-hook 'LaTeX-mode-hook (lambda () (TeX-engine-set "xetex")))
  ;; (add-hook 'LaTeX-mode-hook 'magic-latex-buffer)

  (add-hook 'bibtex-mode-hook (lambda () (set-fill-column 100)))

  (add-hook 'org-mode-hook (lambda () (set-fill-column 103)))
  (add-hook 'org-mode-hook #'turn-on-auto-fill)
  (add-hook 'org-clock-out-hook #'save-buffer) ;; save before writing log note :/
  (add-hook 'org-clock-in-hook #'save-buffer)

  ;; olivetti-mode
  (setq olivetti-body-width 120)
  (add-hook 'org-mode-hook 'olivetti-mode)
  (add-hook 'LaTeX-mode-hook 'olivetti-mode)
  (add-hook 'pdf-view-mode-hook 'olivetti-mode)

  ;; (add-hook 'tuareg-mode-hook (lambda () (merlin-xref-backend)))

  (setq lsp-use-plists t) ;; see https://emacs-lsp.github.io/lsp-mode/page/performance/#use-plists-for-deserialization
  (add-hook 'lsp-after-open-hook #'lsp-origami-try-enable)

  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."
  (defconst lisp--prettify-symbols-alist
    '(("lambda"  . ?λ)))

  ;;; Keybindings
  (global-set-key (kbd "M-p") 'company-complete)
  (global-set-key (kbd "C-S-t") 'tab-new)
  (global-set-key (kbd "M-m C-/") 'helm-do-grep-ag)
  (global-set-key (kbd "C-c C-<tab>") 'org-force-cycle-archived)
  ;; (global-set-key (kbd "M-<return> /") 'helm-org-ql) conflict with M-RET
  (global-set-key (kbd "M-m f j") 'neotree-find)

  ;; enable unicode emoji
  (set-fontset-font t 'unicode "Noto Color Emoji" nil 'prepend)

  (evil-leader/set-key "/" 'spacemacs/helm-project-do-ag)

  (pinentry-start) ;; for ssh (e.g. sign commit)

  (reverse-input-method 'russian-computer)

  ;; (require 'lsp-mode) ;; required for ligo-setup-lsp
  ;; (quelpa '(ligo-mode :fetcher file
  ;;                     :path "CENSORED_PATH"))
  ;; (ligo-setup-lsp)
  ;; (add-hook 'ligo-caml-mode-hook #'lsp)

  (require 'org-protocol)
  ;; (require 'org-gcal) ;; TODO: try to replace with use-package
  ;; (setq org-gcal-client-id "CENSORED_CONTENT"
  ;;       org-gcal-client-secret "CENSORED_CONTENT")

  (use-package dashboard
    :ensure t
    :custom
    (dashboard-center-content t)
    (dashboard-footer-messages
      (with-temp-buffer
        (insert-file-contents "CENSORED_PATH")
        (split-string
         (buffer-string)
         "
" t)))
    (dashboard-items '((recents . 3) (bookmarks . 17) (projects . 3)))
    (dashboard-set-file-icons t)
    (dashboard-set-heading-icons t)
    (dashboard-set-navigator nil)
    (dashboard-startup-banner 'logo)
    (dashboard-week-agenda nil)
    :config
    (defun dashboard-setup ()
      (dashboard-insert-startupify-lists)
      (when (< (length command-line-args) 2 )
        (switch-to-buffer dashboard-buffer-name)
        (goto-char (point-min))
        (redisplay)))
    (dashboard-setup)
    )

  (global-prettify-symbols-mode +1)

  ;;; Org-mode
  (with-eval-after-load 'org
      (setq org-tag-faces '(("grammar" . "magenta3")
                            ("listening" . "green4")
                            ("reading" . "firebrick")
                            ("vocab" . "DodgerBlue3")
                            ("arzamas" . "Gray")
                            ("reread" :foreground "White" :slant italic)
                            ("relation" . "Red")
                            ("refl" . "PowderBlue")
                            ("communication" . "DeepSkyBlue")


                            ("health" . "Chartreuse")
                            ("work" . "DarkOrange")
                            ("issue" . "red")))
      (setq  org-todo-keyword-faces '(("DRAFT" . "#7d3c98")
                                      ("WORK" . "#ec7063")
                                      ("CLEAR" . "green")
                                      ("OPEN" . "#f1c40f")
                                      ("FOG" . "#D1CBCB")
                                      ("INPROGRESS" . "#0098DD")
                                      ("PROG" . "#0098DD")
                                      ("SUSPEND" . "#9F7EFE")
                                      ("STOP" . "#9F7EFE")
                                      ("DONE" . "#50A14F")
                                      ("WANT" . "salmon")
                                      ("LONGTERM" . "DeepPink1")
                                      ("WAIT" . "#00bfff")
                                      ("ACTIVE" . "red1")
                                      ("REGULAR" . "yellow1")
                                      ("MAYBE" . "orchid")
                                      ("FAIL" . "brown")
                                      ("POSTPONED" . "Gold")
                                      ("COLLECTION" . "#0098DD")
                                      ("INFRA" . "Gold")
                                      ("NOTES" . "YellowGreen")
                                      ("THINK" . "NavajoWhite")
                                      ("EXPLORE" . "MediumPurple")
                                      ("ASK" . "DarkOrchid")
                                      ("RUST" . "Sienna")
                                      ("HYP" . "RosyBrown"))
             )
      (setq  org-duration-format '(("h") ("min")))
    )

  (use-package org-fancy-priorities
    :ensure t
    :hook
    (org-mode . org-fancy-priorities-mode)
    :config
    ;;(setq org-fancy-priorities-list '("λ" "λ" "λ"))
    ;;(setq org-fancy-priorities-list '("λλλ" "λλ" "λ"))
    (setq org-fancy-priorities-list '("∰" "∯" "∮"))
    )
  (require 'org-id) ;; for automatic ID
  (setq org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id)
  (use-package org-super-links
    :bind (("C-c s l" . org-super-links-link)
           ("C-c s s" . org-super-links-store-link)
           ("C-c s i" . org-super-links-insert-link)
           ("C-c s d" . org-super-links-delete-link)))
  (defun prompt-org-file (dir-path)
    `(lambda ()
       "Prompt file name"
       (interactive)
       (let ((name (read-string "Filename: ")))
         (expand-file-name (format "%s.org" name) ',dir-path))))

  ;; doc: https://github.com/unhammer/org-mru-clock
  (use-package org-mru-clock
    :ensure t
    :custom
       (org-mru-clock-how-many 40)
    :bind* (("M-m a o C m" . org-mru-clock-in)
            ("M-m a o C s" . org-mru-clock-select-recent-task))
    :commands org-mru-clock--completing-read ;; for org-clock-in-past
    :autoload (org-mru-clock-to-history)
    )
  (use-package clocktable-by-tag
    :after org) ;; TODO spread it
  (use-package clocktable-by-category
    :after org)

  (defun prompt-link ()
    "Prompt link"
    (interactive)
    (read-string "Link: ")
  )

  (defun prompt-heading ()
    ;; TODO
    ;; possible realizations:
    ;; https://stackoverflow.com/questions/9005843
    ;; https://emacs.stackexchange.com/questions/71093
    )

  (setq org-capture-templates
        `(
          ;; ("t" "Thoughts" plain
          ;;  (file ,(prompt-org-file "CENSORED_PATH"))
          ;;  ,(concat
          ;;    "#+SEQ_TODO: FOG(f) DRAFT(d) OPEN(o!) WORK(w!) CLEAR(c!)\n"
          ;;    "#+SEQ_TODO: NOTE(n)\n"
          ;;    "#+CATEGORY: tho\n"
          ;;    "\n"
          ;;    "* DRAFT %? %^G\n")
          ;;  )
          ("p" "Protocol" plain (file "CENSORED_PATH")
           "* %? [[%:link][%:description]] %^G\nCaptured On: %U\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
          ("L" "Protocol Link" plain (file "CENSORED_PATH")
           "* %? [[%:link][%:description]] %^G\nCaptured On: %U")
          ("b" "Bookmark (Interest)" plain
           (file "CENSORED_PATH")
           "* TOREAD [[%(call-interactively #'prompt-link)][%?] %^G\n")
          ("s" "Bookmark (Science)" plain
           (file "CENSORED_PATH")
            "* TODO [[%(call-interactively #'prompt-link)][%^{PROMPT}] %^G\n%^{AUTHOR}p")
          ("n" "Bookmark (News)" plain
           (file "CENSORED_PATH")
           "* TODO [[%(call-interactively #'prompt-link)][%?]]\n")
          ("o" "Book" entry
           (file+headline "CENSORED_PATH" prompt-heading)
           "\n** TODO %?\n") ;; TODO
          ;; ("todo" "TODO" entry))
          )
  )
  (add-hook 'org-capture-prepare-finalize-hook #'org-id-get-create)

  ;; Org-clocking
  (defun org-clock-in-past ()
    "Insert clock record from the past"
    (interactive "")
    (org-mru-clock-to-history nil) ;; load mru state
    (let* ((marker (cdr (org-mru-clock--completing-read)))
           (start (org-read-date t t nil "Start: "))
           (duration (read-string "Duration (m): "))
           (seconds  (* 60 (org-duration-to-minutes duration))))
      ;; inspired by org-mru-clock--clock-in-on-marker
      (with-current-buffer (org-base-buffer (marker-buffer marker))
        (org-with-wide-buffer
         (goto-char (marker-position marker))
         (org-clock-in nil start)))
      (org-clock-out nil nil (time-add start (seconds-to-time seconds)))
      )
     ;; resume interrupted task (workaround: namely reopen it)
     (when (marker-buffer org-clock-interrupted-task)
       (with-current-buffer (org-base-buffer (marker-buffer org-clock-interrupted-task))
         (org-with-wide-buffer
          (goto-char (marker-position org-clock-interrupted-task))
          (org-clock-in))))
     )
  (global-set-key (kbd "M-m a o C p") 'org-clock-in-past)

  ;; Org-roam
  ;; Check:
  ;; https://github.com/syl20bnr/spacemacs/issues/14477 (SOLVED)
  ;; https://github.com/org-roam/org-roam-ui/issues/236 (WORKAROUND)
  (setq  org-roam-directory "CENSORED_PATH"
         org-roam-db-location "CENSORED_PATH")
  (defun org-roam-switch (i)
    "Switch to another roam profile"
    (interactive "nProfile (1 - tho, 2 - research, 3 - book): ")
    (cond ((equal i 1) (setq org-roam-directory "CENSORED_PATH"
                             org-roam-db-location "CENSORED_PATH"))
          ((equal i 2) (setq org-roam-directory "CENSORED_PATH"
                             org-roam-db-location "CENSORED_PATH"))
          ((equal i 3) (setq org-roam-directory "CENSORED_PATH"
                             org-roam-db-location "CENSORED_PATH"))
          (t (message "Wrong argument")))
    (org-roam-db-sync)
  )
  (global-set-key (kbd "M-RET r s") 'org-roam-switch)


  ;; Helm-bibtex
  ;; TODO: add action to download pdf and store in the folder + insert `File = {}' field
  (setq bibtex-completion-bibliography '("CENSORED_PATH")
        bibtex-completion-library-path '("CENSORED_PATH")
        bibtex-completion-pdf-field "File"
        bibtex-completion-find-additional-pdfs t
        bibtex-completion-additional-search-fields '(tags ids)
        bibtex-completion-pdf-open-function 'helm-open-file-with-default-tool
        )
  (global-set-key (kbd "M-m b f") 'helm-bibtex)
  (with-eval-after-load "helm-bibtex"
    (defun my-bibtex-completion-open-url-or-doi (keys)
      "Copy of from helm-bibtex"
      (dolist (key keys)
        (let* ((entry (bibtex-completion-get-entry key))
               (url   (bibtex-completion-get-value "url" entry))
               (pdf (bibtex-completion-get-value "pdf" entry))
               (doi (bibtex-completion-get-value "doi" entry))
               (browse-url-browser-function
                (or bibtex-completion-browser-function
                    browse-url-browser-function)))
          (cond
           (pdf
            (cond ((string-match-p "dl.acm.org" pdf)
                   (let* (;; (cookies (f-read-text "~/.emacs.d/private/local/acm_cookies.txt"))
                          (file (concat "CENSORED_PATH" "temp.pdf")))
                     (with-temp-buffer
                     ;; (shell-command (concat "curl '" pdf "' " cookies " --output '" file "'"));)
                       (shell-command (concat "docker run --rm lwthiker/curl-impersonate:0.6-chrome curl_chrome110 " pdf " > " file) t))
                     (start-process "Okular" "*okular" "okular" file))
                   )
                  (t (let* ((browse-url-browser-function (lambda (url _) (start-process "Okular" "*okular" "okular" url))))
                       (browse-url url)))))
           (url (browse-url url))
           (doi (browse-url (s-concat "http://dx.doi.org/" doi)))
           (t (message "No URL or DOI found for this entry: %s" key))))))

    (defun my-bibtex-completion-open-any (keys)
      "Copy of from helm-bibtex"
      (bibtex-completion-open-pdf keys 'my-bibtex-completion-open-url-or-doi))
    (helm-bibtex-helmify-action my-bibtex-completion-open-any my-helm-bibtex-open-any)
    (helm-delete-action-from-source "Open PDF, URL or DOI" helm-source-bibtex)
    (helm-add-action-to-source "Open PDF File, PDF URL, URL or DOI" 'my-helm-bibtex-open-any helm-source-bibtex 0)
    )

  ;; spell checking
  (with-eval-after-load "ispell"
    (setq ispell-program-name "hunspell")
    (ispell-set-spellchecker-params)
    (ispell-hunspell-add-multi-dic "en_US,ru_RU")
    (setq ispell-dictionary "en_US,ru_RU"))

  ;; (add-hook 'ocaml-mode-hook #'lsp)
  ;; (add-hook 'tuareg-mode-hook #'tuareg-opam-update-env)
  (add-hook 'tuareg-mode-hook #'lsp)
  (add-hook 'elm-mode-hook #'lsp)

  ;; (require 'lsp-haskell)
  (add-hook 'haskell-mode-hook #'lsp)
  (add-hook 'haskell-literate-mode-hook #'lsp)

  ;;; Ocaml and Coq IDE
  (add-hook 'tuareg-mode-hook 'column-enforce-mode)
  (add-hook 'tuareg-mode-hook (lambda() (setq mode-name "🐪")))
  (add-hook 'coq-mode-hook    (lambda() (setq mode-name "🐓")))
  (add-hook 'tuareg-mode-hook (lambda() (electric-indent-mode 0)))

  (use-package flycheck-posframe
    :ensure t
    :after flycheck
    :config (add-hook 'flycheck-mode-hook #'flycheck-posframe-mode)
    :custom
      (flycheck-posframe-position 'window-top-right-corner)
      (flycheck-posframe-border-width 5)
      (flycheck-posframe-warning-prefix "\u26a0 ")
      (flycheck-posframe-error-prefix "\u274c ")
    :custom-face
      (flycheck-posframe-error-face ((t (:inherit flycheck-error-list-error))))
      (flycheck-posframe-warning-face ((t (:inherit flycheck-error-list-warning))))
      (flycheck-posframe-info-face ((t (:inherit flycheck-error-list-info))))
      (flycheck-posframe-border-face ((t (:inherit vertical-border))))
    )

  ;; TODO: doesn't work, restart flycheck-pos-tip-mode works
  (with-eval-after-load 'flycheck
    (add-hook 'flycheck-mode-hook
              (lambda ()
                (unless (display-graphic-p) flycheck-pos-tip-mode))))


  (smart-tabs-insinuate 'c)
)

;; TODO: move stable configurations into :variables
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-command-BibTeX "BibTeX")
 '(TeX-command-Biber "biber")
 '(TeX-view-program-list
   '(("Okular"
      ("okular --noraise --unique %o"
       (mode-io-correlate "#src:%n%a"))
      "okular")))
 '(TeX-view-program-selection
   '(((output-dvi has-no-display-manager)
      "dvi2tty")
     ((output-dvi style-pstricks)
      "dvips and gv")
     (output-dvi "xdvi")
     (output-pdf "PDF Tools")
     (output-html "xdg-open")))
 '(ansi-color-names-vector
   ["#0a0814" "#f2241f" "#67b11d" "#b1951d" "#4f97d7" "#a31db1" "#28def0" "#b2b2b2"])
 '(bibtex-align-at-equal-sign t)
 '(bibtex-entry-format
   '(opts-or-alts required-fields numerical-fields realign unify-case sort-fields))
 '(bibtex-generate-url-list
   '((("url" . ".*:.*"))
     (("doi" . "10\\.[0-9]+/.+") "http://dx.doi.org/%s" ("doi" ".*" 0))
     (("pdf" . ".*:.*"))))
 '(debugger-batch-max-lines 40)
 '(desktop-path '("~/.emacs.d/.cache/desktop" "~/.emacs.d/" "~"))
 '(doc-view-resolution 300)
 '(epg-pinentry-mode 'loopback)
 '(evil-want-Y-yank-to-eol nil)
 '(flycheck-display-errors-delay 1.7)
 '(flycheck-python-flake8-executable "python3")
 '(flycheck-python-pycompile-executable "python3")
 '(flycheck-python-pylint-executable "python3")
 '(global-hl-todo-mode t)
 '(grep-find-ignored-directories
   '("SCCS" "RCS" "CVS" "MCVS" ".src" ".svn" ".git" ".hg" ".bzr" "_MTN" "_darcs"
     "{arch}"))
 '(haskell-font-lock-symbols t)
 '(haskell-font-lock-symbols-alist
   '(("\\" . "λ") ("undefined" . "⊥")
     ("." "∘" haskell-font-lock-dot-is-not-composition)))
 '(haskell-process-type 'stack-ghci)
 '(helm-ag-base-command "rg --no-heading --line-number --color never")
 '(helm-ag-success-exit-status '(0 2))
 '(helm-completion-style 'emacs)
 '(helm-mode t)
 '(hindent-style nil)
 '(hl-todo-keyword-faces
   '(("REVIEW" . "#7cb8bb") ("HOLD" . "#d0bf8f") ("TODO" . "#cc9393")
     ("NEXT" . "#dca3a3") ("THEM" . "#dc8cc3") ("PROG" . "#7cb8bb")
     ("OKAY" . "#7cb8bb") ("DONT" . "#5f7f5f") ("FAIL" . "#8c5353")
     ("DONE" . "#afd8af") ("NOTE" . "#d0bf8f") ("KLUDGE" . "#d0bf8f")
     ("HACK" . "#d0bf8f") ("TEMP" . "#d0bf8f") ("FIXME" . "orange2")
     ("XXX+" . "#cc9393") ("\\?\\?\\?+" . "#cc9393") ("ASK" . "cyan2")
     ("MAYBE" . "orchid") ("BUG" . "red2") ("CHECK" . "#cdcd00")
     ("FEATURE" . "wheat") ("DEBUG" . "grey") ("EASY" . "dark orange")
     ("HARD" . "red2")))
 '(js-indent-level 2)
 '(json-reformat:indent-width 2)
 '(lsp-client-packages
   '(ccls lsp-ada lsp-angular lsp-bash lsp-clangd lsp-clojure lsp-cmake lsp-crystal
          lsp-csharp lsp-css lsp-dart lsp-dhall lsp-dockerfile lsp-elm
          lsp-elixir lsp-erlang lsp-eslint lsp-fortran lsp-fsharp lsp-gdscript
          lsp-go lsp-hack lsp-groovy lsp-haskell lsp-haxe lsp-java
          lsp-javascript lsp-json lsp-kotlin lsp-lua lsp-nim lsp-nix lsp-metals
          lsp-ocaml lsp-perl lsp-php lsp-pwsh lsp-pyls lsp-python-ms
          lsp-purescript lsp-r lsp-rf lsp-rust lsp-solargraph lsp-sorbet lsp-tex
          lsp-terraform lsp-vala lsp-verilog lsp-vetur lsp-vhdl lsp-vimscript
          lsp-xml lsp-yaml lsp-sqls lsp-svelte))
 '(lsp-latex-build-executable "xelatex")
 '(magit-no-confirm nil)
 '(org-agenda-category-icon-alist
   '(("serokell" "~/.emacs.d/private/icons/serokell.png" nil nil :ascent center)
     ("task" "~/.emacs.d/private/icons/checked.png" nil nil :ascent center)
     ("science" "~/.emacs.d/private/icons/science.png" nil nil :ascent center)
     ("tho" "~/.emacs.d/private/icons/bulb.png" nil nil :ascent center)))
 '(org-agenda-current-time-string "ᐊ---------------")
 '(org-agenda-files
   '("CENSORED_PATH"
     "CENSORED_PATH"
     "CENSORED_PATH"
     "CENSORED_PATH"
     "CENSORED_PATH"
     "CENSORED_PATH"
     "CENSORED_PATH"
     "CENSORED_PATH"
     "CENSORED_PATH"
     "CENSORED_PATH"))
 '(org-agenda-prefix-format
   '((agenda . " %-3i %-12:c%?-12t% s") (todo . " %-3i %-12:c")
     (tags . " %-3i %-12:c") (search . " %-3i %-12:c")))
 '(org-agenda-sorting-strategy
   '((agenda habit-down time-up priority-down category-keep)
     (todo priority-down category-keep alpha-up)
     (tags priority-down category-keep timestamp-down alpha-up)
     (search category-keep timestamp-down alpha-up)))
 '(org-agenda-start-with-log-mode '(closed))
 '(org-archive-location "::* Archive")
 '(org-clock-idle-time 10)
 '(org-columns-default-format "%25ITEM %TODO %6Effort %6CLOCKSUM %TAGS")
 '(org-export-date-timestamp-format nil)
 '(org-file-apps
   '((auto-mode . emacs) (directory . emacs) ("\\.mm\\'" . default)
     ("\\.x?html?\\'" . default) ("\\.pdf\\'" . default)))
 '(org-fold-show-context-detail
   '((agenda . local) (bookmark-jump . lineage) (isearch . lineage)
     (default . ancestors) (tags-tree . local)))
 '(org-format-latex-options
   '(:foreground default :background default :scale 1.5 :html-foreground "Black"
                 :html-background "Transparent" :html-scale 1.0 :matchers
                 ("begin" "$1" "$" "$$" "\\(" "\\[")))
 '(org-gcal-fetch-file-alist
   '(("pavel.golovin@serokell.io" . "CENSORED_PATH")
     ("upf1ho0lmijqrt0gnfa0vhhs4c@group.calendar.google.com" . "CENSORED_PATH")
     ("gopavel0@gmail.com" . "CENSORED_PATH")))
 '(org-gcal-recurring-events-mode 'top-level)
 '(org-image-actual-width '(400))
 '(org-latex-pdf-process
   '("latexmk -interaction=nonstopmode -pdf -output-directory=%o %f"))
 '(org-latex-remove-logfiles t)
 '(org-log-into-drawer t)
 '(org-log-note-clock-out t)
 '(org-pomodoro-length 25)
 '(org-priority-faces '((65 . "red") (66 . "orange") (67 . "cyan")))
 '(org-priority-lowest 68)
 '(org-return-follows-link t)
 '(org-startup-truncated nil)
 '(org-super-agenda-groups nil)
 '(origami-show-fold-header t)
 '(package-archives
   '(("melpa" . "https://melpa.org/packages/")
     ("melpa-stable" . "https://stable.melpa.org/packages/")
     ("org" . "https://orgmode.org/elpa/")
     ("gnu" . "https://elpa.gnu.org/packages/")
     ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
 '(package-check-signature nil)
 '(package-directory-list
   '("/usr/share/emacs/26.2/site-lisp/elpa" "/usr/share/emacs/site-lisp/elpa"))
 '(package-selected-packages
   '(org-mru-clock olivetti org-analyzer org-roam-ui ssh-agency web-beautify livid-mode skewer-mode simple-httpd json-mode json-snatcher json-reformat js2-refactor multiple-cursors js2-mode js-doc coffee-mode org-ref pdf-tools key-chord ivy tablist helm-bibtex bibtex-completion parsebib biblio biblio-core company-lsp lsp-mode ht lsp-haskell memoize all-the-icons org-fancy-priorities company-emacs-eclim eclim auctex-lua company-auctex auctex-latexmk sql-indent auctex cdlatex proof-general company-coq company-math math-symbol-lists flymd web-mode tagedit slim-mode scss-mode sass-mode pug-mode helm-css-scss haml-mode emmet-mode company-web web-completion-data idris-mode prop-menu flycheck-haskell hlint-refactor hindent helm-hoogle helm-company helm-c-yasnippet haskell-snippets fuzzy company-statistics company-ghci company-ghc ghc company-cabal company-c-headers company-anaconda cmm-mode auto-yasnippet yasnippet ac-ispell auto-complete yaml-mode org-projectile org-category-capture org-present org-pomodoro alert log4e gntp org-mime org-download htmlize gnuplot flycheck-pos-tip pos-tip flyspell-correct-helm flyspell-correct auto-dictionary disaster cmake-mode clang-format smeargle orgit magit-gitflow magit-popup helm-gitignore gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe+ git-gutter-fringe fringe-helper git-gutter+ git-gutter evil-magit magit transient git-commit with-editor diff-hl yapfify xterm-color shell-pop pyvenv pytest pyenv-mode py-isort pip-requirements multi-term mmm-mode markdown-toc markdown-mode live-py-mode intero haskell-mode company flycheck hy-mode dash-functional helm-pydoc gh-md eshell-z eshell-prompt-extras esh-help cython-mode anaconda-mode pythonic ws-butler winum which-key volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spaceline powerline restart-emacs request rainbow-delimiters popwin persp-mode pcre2el paradox spinner org-bullets open-junk-file neotree move-text macrostep lorem-ipsum linum-relative link-hint indent-guide hydra lv hungry-delete hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation helm-themes helm-swoop helm-projectile projectile pkg-info epl helm-mode-manager helm-make helm-flx helm-descbinds helm-ag google-translate golden-ratio flx-ido flx fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist highlight evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state smartparens evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-ediff evil-args evil-anzu anzu evil goto-chg undo-tree eval-sexp-fu elisp-slime-nav dumb-jump f dash s diminish define-word column-enforce-mode clean-aindent-mode bind-map bind-key auto-highlight-symbol auto-compile packed aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line helm avy helm-core popup async))
 '(paradox-github-token t)
 '(pdf-view-continuous t)
 '(pdf-view-midnight-colors '("#b2b2b2" . "#292b2e"))
 '(prettify-symbols-unprettify-at-point t)
 '(python-shell-interpreter "python")
 '(safe-local-variable-values
   '((TeX-Master . "../main") (TeX-Master . "main")
     (eval progn (setenv "TEXINPUTS" (format ".:../styles//:../sav-science//:"))
           (setenv "BSTINPUTS" (format ".:../styles//:")))
     (eval progn (setenv "TEXINPUTS" (format ".:../styles//:../sav-science//:"))
           (setenv "BSTINPUTS" (format ".:../styles//:%s" (getenv "BSTINPUTS"))))
     (eval progn
           (setenv "TEXINPUTS"
                   (format ".:../styles//:../sav-science//:%s"
                           (getenv "TEXINPUTS")))
           (setenv "BSTINPUTS" (format ".:../styles//:%s" (getenv "BSTINPUTS"))))
     (eval setenv "TEXINPUTS"
           (format ".:../styles//:../sav-science//:%s" (getenv "TEXINPUTS")))
     (Tex-master . "notes") (typescript-backend . tide)
     (typescript-backend . lsp) (javascript-backend . tide)
     (javascript-backend . tern) (javascript-backend . lsp)))
 '(sh-basic-offset 2)
 '(spacemacs-yank-indent-threshold 0)
 '(tab-bar-mode t)
 '(tab-width 2)
 '(tex-bibtex-command "biber")
 '(tooltip-hide-delay 20)
 '(tuareg-default-indent 4)
 '(tuareg-opam-insinuate t)
 '(warning-suppress-log-types
     '((comp) (comp) (comp) (comp) (comp) (comp) (comp) (comp) (comp)))
 '(warning-suppress-types
     '((comp) (comp) (comp) (comp) (comp) (comp) (comp) (comp) (comp)))
   '(word-wrap t)
   '(yas-global-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(highlight-parentheses-highlight ((nil (:weight ultra-bold))) t)
 '(neo-vc-ignored-face ((t (:foreground "dim gray"))))
 '(neo-vc-unregistered-face ((t (:foreground "sienna"))) t)
 '(proof-eager-annotation-face ((t (:background "medium blue"))))
 '(proof-error-face ((t (:background "dark red"))))
 '(proof-warning-face ((t (:background "indianred3"))))
 '(tuareg-font-lock-extension-node-face ((t (:inherit tuareg-font-lock-infix-extension-node-face)))))
)
