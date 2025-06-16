#!/bin/bash
# Launch nvim in kitty, suppressing any errors
# FILE_OWNER=$(stat -c %U "$1")

# # Check if the current user is the owner of the file
# if [[ "$FILE_OWNER" == "$(whoami)" ]]; then
#   # If the file is owned by the current user, open it with nvim in kitty without needing root
#   kitty nvim "$@"  2>&1
# else
#   # If the file is owned by someone else (e.g., root), use pkexec to get root privileges
#   kitty nvim "$@" 2>&1
# fi
kitty nvim $@ 2>&1