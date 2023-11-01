#!/bin/bash

OPTION="$1"
FILE="$2"

create_backup()
{
    return 0
}

restore_backup()
{
    return 0
}

main()
{
    result=$(sudo ufw status)
    if [ "${result}" = "Status: active\n" ]; then
        echo "ufw not enabled (have you run \"sudo ufw enable?\")"
        exit 1
    fi

    if [ "${OPTION}" = "backup" ]; then
        echo "Backing up current rules..."
        create_backup
        if [ "$?" -eq 0 ]; then
            echo "Backup completed"
        else
            echo "Backup failed"
        fi
    elif [ "${OPTION}" = "restore" ]; then
        echo "Restoring to previous backup..."
        if [ "$?" -eq 0 ]; then
            echo "Backup restored"
        else
            echo "Restoration failed"
        fi
    else
        echo "Improper usage (please run in "./firewall_backup.sh \<backup/restore\> \<directory storing backups\>" format)"
        exit 1
    fi

} 

main