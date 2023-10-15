#!/bin/bash

USER_FILE="$1"
passwd_len=14

make_password()
{
    passwd_chars="A-Za-z0-9!@#$%^&*()_-+=[]{}:;,.<>?"
    password=$(tr -cd "$passwd_chars" < /dev/urandom | head -c "$passwd_length")
}

reset_password()
{
    user="$1"
    random_password=$(generate_random_password)
    echo "Resetting password for $user to: $random_password"
}

main()
{
    while IFS= read -r user
    do
        reset_password "$user"
    done < "$USER_FILE" 

    echo "Password reset for all specified users"
}

main