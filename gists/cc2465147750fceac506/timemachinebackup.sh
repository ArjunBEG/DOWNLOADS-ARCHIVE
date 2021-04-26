#!/bin/sh

# ------------------------------------------------------
# A small script to mount a volume, make a TimeMachine
# backup, wait for it to finish and unmount
# the volume again. Please adjust to your needs.
# ------------------------------------------------------

# Mount the backup volume, adjust to your needs
#diskutil mount …

# Start a TimeMachine backup
tmutil startbackup

# Now wait for the backup to finish
PID=$(ps aux | grep backupd$ | awk '{print $2}')

# wait a few seconds and check if backupd is not running
# sleep 5
if [ "$PID" == "" ]
then
    # Backup not running
    exit
fi

ps -p$PID 2>&1 > /dev/null
BACKUPDRUNNING=$?

while [ "$BACKUPDRUNNING" == "0" ]
do
    ps -p$PID 2>&1 > /dev/null
    BACKUPDRUNNING=$?
    sleep 60 #wait for one minute until next poll
done

# Wait another 30 seconds for drive to spin down
sleep 30

# Ummount
#diskutil unmount …
