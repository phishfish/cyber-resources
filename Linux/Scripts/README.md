# How to Use Each File
audih.sh audits all users and each group (including the current person) to an output file. Simply run "./audit.sh <output-file>" and the users + group will be printed to stdout and to the out file (the users will be printed first and a space seperates the group).

password_reset.sh resets the passwords of users from a file given at command line. Run the script as "./password_reset.sh <files-of-usernames>" and the randomized password will be echoed to stdout. Additionally, the length of the password can be changed (it is currently set to 14).

account_control.sh creates, deletes, and disables users from three files given at command line. Run the script as "./account_control.sh <users-to-be-created> <users-to-be-deleted> <users-to-be-disabled>". For the file containing users to be created, seperate the username from the password with a ':' (example: Mr.Cat:meow).

firewall_backup.sh takes 3 command line arguments to restore and backup fire wall rules in /lib/ufw/, /etc/ufw/, and iptables