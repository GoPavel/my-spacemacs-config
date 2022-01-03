#!/bin/sh

set -x

cp ../.spacemacs .spacemacs -i
F=../spacemacs-settings/.spacemacs # to prevent running script in another folder
sed 's/.*CENSORED.*$//' $F -i
sed 's/\(org-gcal-client-id \)"[^"]*"/\1"CENSORED_CONTENT"/g' $F -i
sed 's/\(org-gcal-client-secret \)"[^"]*"/\1"CENSORED_CONTENT"/g' $F -i
sed 's/"[^"]*\/my-workspace\/[^"]*"/"CENSORED_PATH"/g' $F -i
