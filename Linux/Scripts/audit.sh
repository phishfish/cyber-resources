#!/bin/bash

OUT_FILE=$1
CURR_USER=$(whoami)

main()
{
	echo "Auditing users: "
	system_accounts=$(cut -d: -f1,3 /etc/passwd | awk -F: '$2 < 1000 {print $1}')
	echo $CURR_USER
	echo "$system_accounts"
	echo $CURR_USER >> $OUT_FILE
	echo "$system_accounts" >> $OUT_FILE

	printf "\nAuditing groups:\n"
	system_groups=$(cut -d: -f1,3 /etc/group | awk -F: '$2 < 1000 {print $1}')
	echo "$system_groups"
	printf "\n" >> $OUT_FILE
	echo "$system_groups" >> $OUT_FILE
		
}

main
