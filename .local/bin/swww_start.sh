#!/bin/bash
# swww-daemon
# LOGFILE="$HOME/.cache/swww-daemon.log"
# echo "" > "$LOGFILE"

# try_restore_swww() {
#   while true; do
#     restore_output=$(swww restore 2>&1)
#     restore_status=$?

#     if [ $restore_status -eq 0 ]; then
#       echo "swww restore succeeded at $(date)" >> "$LOGFILE"
#       # Optionally save the output too:
#       echo "$restore_output" >> "$LOGFILE"
#       break
#     else
#       echo "swww restore failed at $(date), restarting daemon and retrying in 1s..." >> "$LOGFILE"
#       echo "$restore_output" >> "$LOGFILE"
#       pkill -f swww-daemon
#       sleep 1
#       echo "Restarting swww-daemon at $(date)" >> "$LOGFILE"
#       swww-daemon >> "$LOGFILE" 2>&1 &
#       sleep 1
#     fi
#   done
# }

# echo "Launching swww-daemon at $(date)" >> "$LOGFILE"
# swww-daemon >> "$LOGFILE" 2>&1 &
# sleep 1

# try_restore_swww
while true; do
  # echo "Starting swww-daemon at $(date)" >> "$LOGFILE"
  swww-daemon #>> "$LOGFILE" 2>&1

  # echo "swww-daemon exited at $(date), restarting in 1s..." >> "$LOGFILE"
  sleep 1
done