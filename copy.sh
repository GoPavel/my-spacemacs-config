#!/bin/sh

set -x

F=../my-spacemacs-config/.spacemacs # to prevent running script in another folder
cp  ~/.spacemacs .spacemacs -i
sed 's/.*CENSORED_LINE.*$//' $F -i
sed 's/\(org-gcal-client-id \)"[^"]*"/\1"CENSORED_CONTENT"/g' $F -i
sed 's/\(org-gcal-client-secret \)"[^"]*"/\1"CENSORED_CONTENT"/g' $F -i
sed 's/"[^"]*\/my-workspace\/[^"]*"/"CENSORED_PATH"/g' $F -i

# copy sources

cp -f ~/.local/share/applications/org-protocol.desktop ./sources/
cp -rf ~/.emacs.d/private/icons/ ./sources/
