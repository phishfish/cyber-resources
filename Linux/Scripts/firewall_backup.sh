#!/bin/bash

# create_copy()
# {

# }

main()
{
    result=$(sudo ufw status)
    if [ "${result}" = "Status: active\n" ]; then
        echo "ufw not enabled (have you run "sudo ufw enable?")"
        exit 1
    fi

    echo "Printing current rules..."
    
} 

main