#!/usr/bin/env bash

TARGETIP=10.25.22.95
SETUP='lcd .. \n cd backup/linux \n'

BACKUPDIRS="Desktop Downloads Documents work"
BACKUPDIRSTRING=""

for DIR in $BACKUPDIRS; do
    BACKUPDIRSTRING="$BACKUPDIRSTRING put -pr colton/$DIR . \n"
done

# echo "sftp $TARGETIP <<< $'$SETUP$BACKUPDIRSTRING'"
echo "sftp $TARGETIP <<< $'$SETUP$BACKUPDIRSTRING'" | bash
