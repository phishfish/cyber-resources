#!/bin/bash

# Declares command line args   
OPTION="$1"
FW_CHOICE="$2"
DIR="$3"

create_backup()
{
    if [ "${FW_CHOICE}" = "ufw" ]; then
        for file in /etc/ufw/; do
            filename=$(basename "$file")
            
            backup_filename="${filename%.*}_etc_backup.rules"
            
            # Copy the file to the backup directory
            sudo cp -r "$file" "$backup_dir$backup_filename"
            
            echo "Backed up $file to $backup_dir$backup_filename"
        done

        for file in /lib/ufw/; do
            filename=$(basename "$file")
            
            backup_filename="${filename%.*}_lib_backup.rules"
            
            # Copy the file to the backup directory
            sudo cp -r "$file" "$backup_dir$backup_filename"
            
            echo "Backed up $file to $backup_dir$backup_filename"
        done
    
    elif [ "${FW_CHOICE}" = "iptables" ]; then
        sudo iptables-save > "$FILE/iptables_backup.rules" 
    else 
        echo "Please enter ufw or iptable rules to back up"
        exit 1
    fi
    return $?
}

restore_backup()
{
    # Restore UFW rules from a backup file
    if [ "${FW_CHOICE}" = "ufw" ]; then
        for backup_file in "$DIR"/ufw_etc_backup.rules; do
            if [ -f "$backup_file" ]; then
                # Extract the original filename from the backup filename
                original_filename=$(basename "$backup_file" | sed 's/_etc_backup_.*\.rules/.rules')
                # Restore the file to /etc/ufw/
                sudo cp -r "$backup_file" "/etc/ufw/$original_filename"

                echo "Restored $backup_file to /etc/ufw/$original_filename"
            fi
        done

        for backup_file in "$DIR"/ufw_lib_backup.rules; do
            if [ -f "$backup_file" ]; then
                # Extract the original filename from the backup filename
                original_filename=$(basename "$backup_file" | sed 's/_lib_backup_.*\.rules/.rules')

                # Restore the file to /lib/ufw/
                sudo cp -r "$backup_file" "/lib/ufw/$original_filename"

                echo "Restored $backup_file to /lib/ufw/$original_filename"
            fi
        done
    elif [ "${FW_CHOICE}" = "iptables" ]; then
        result=$(find "${DIR}" -name "iptables_backup_*.rules")
        sudo iptables-restore "$filename"
    else
        echo "Please choose to restore ufw or iptable rules" 
        exit 1
    fi

    return $?
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
        echo "Improper usage (please run in "./firewall_backup.sh \<backup/restore\> \<ufw or iptables\> \<directory storing backups\>" format)"
        exit 1
    fi

    echo "Program has finished"
} 

main