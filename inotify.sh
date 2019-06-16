#!/bin/sh

/usr/bin/inotifywait -mrq --format '%w%f' -e create,close_write,delete,move,move_self /data |\
while read file
 do
    [ ! -e "$file" ] && continue
    rsync -az --delete $file rsync_backup@172.16.1.41::data --password-file=/etc/rsync.password > /dev/null 2>&1
done
