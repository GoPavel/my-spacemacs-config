#!/bin/sh

set -x

cp .spacemacs .spacemacs.copy
F=../spacemacs-settings/.spacemacs.copy # to prevent running script in another folder
# sed 's/.*CENSORED.*$//' $F -i
sed 's/\(org-gcal-client-id \)"[^"]*"/\1"CENSORED_CONTENT"/g' $F -i
sed 's/\(org-gcal-client-secret \)"[^"]*"/\1"CENSORED_CONTENT"/g' $F -i
sed 's/"[^"]*\/my-workspace\/[^"]*"/"CENSORED_PATH"/g' $F -i

diff .spacemacs .spacemacs.copy
