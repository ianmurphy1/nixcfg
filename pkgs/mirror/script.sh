#!/usr/bin/env bash

download="${1}"
dest="/home/ian/${2:-audiobooks}/"

lftp -c "open -u ${SEEDHOST_USER}, sftp://${SEEDHOST_URL}; mirror --parallel=5 --use-pget=5 '""${download}""' \"${dest}\" &; exit bg;"
