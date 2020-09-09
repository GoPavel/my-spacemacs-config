# spacemacs-settings

My drawer with spacemacs settings, scripts, notes and history of updating.

## Setup neotree

- install fonts `M-x all-the-icons-install-fonts`
- added hook in `user-conifg` for sustaining state of variables `neo-vs-integration` (maybe it'll redundant in future)

## TODOs

- [ ] try develop branch
- [ ] setting up haskell layer
- [ ] review setting up GPG key
- [ ] research about emacs server
- [X] fix rewrite `neo-vs-integration` [issue](https://github.com/syl20bnr/spacemacs/issues/10504)

## Emacs-server
    - set `dotspacemacs-persistent-server` to `t` (maybe redundant) 
    - `systemctl --user enable emacs`
    - `systemctl --user start emacs`
    - add to .zshrc `alias em="emacsclient --tty"`
    - add `emacsclient --create-frame %f` to `/usr/share/application/emacs.desktop`
    - setup initical-choice-buffer
