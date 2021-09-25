# spacemacs-settings

My drawer with spacemacs settings, scripts, notes and history of updating.

## Setup neotree

- install fonts `M-x all-the-icons-install-fonts`
- added hook in `user-conifg` for sustaining state of variables `neo-vs-integration` (maybe it'll redundant in future)

## Layers

### Lean
  - [Follow install instruction from REAME](https://github.com/robkorn/spacemacs-lean-layer)

## TODOs

### General
  - [ ] Add shortcut for neotree
  - [ ] setting up haskell layer
  - [ ] review setting up GPG key
    - add `pinentry-start`
  - [X] fix rewrite `neo-vs-integration` [issue](https://github.com/syl20bnr/spacemacs/issues/10504)
  - [ ] ~~uniqueness of neotree in emacs-server~~

### Ocaml
  - [ ] add hook for `tuareg-update && restart-lsp-server`


## Emacs-server
    - (not recommended) set `dotspacemacs-persistent-server` to `t` (maybe redundant) 
    - `systemctl --user enable emacs`
    - `systemctl --user start emacs`
    - add to .zshrc `alias em="emacsclient --tty"`
    - (not recommended) add `emacsclient --create-frame %f` to `/usr/share/application/emacs.desktop`
    - setup initial-choice-buffer (TODO: doesn't work in `master`)
### Pros and Cons
  - (+) Fast opening 
  - (-) Problem with neotree, coq-mode
  - (-) Sole and persistent batch of buffers isn't convenient since it becomes necessary to close buffers manually
  - (-) Accidentally closed server must be reopen by =systemctl=
