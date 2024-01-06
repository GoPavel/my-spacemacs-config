#!/bin/sh

set -x

F=../my-spacemacs-config/.spacemacs # to prevent running script in another folder
cp  ~/.spacemacs .spacemacs -i
sed 's/.*CENSORED.*$//' $F -i
sed 's/\(org-gcal-client-id \)"[^"]*"/\1"CENSORED_CONTENT"/g' $F -i
sed 's/\(org-gcal-client-secret \)"[^"]*"/\1"CENSORED_CONTENT"/g' $F -i
sed 's/"[^"]*\/my-workspace\/[^"]*"/"CENSORED_PATH"/g' $F -i

