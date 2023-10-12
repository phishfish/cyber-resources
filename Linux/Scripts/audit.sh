#!/bin/bash

main()
{
	echo "Beginning to audit users"
	sudo cat /etc/passwd

	echo "Beginning to audit groups"
	sudo cat /etc/group
		
}

main
