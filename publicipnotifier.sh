#!/bin/bash

# Define messages and configuration variables
COMMAND_TO_EXECUTE="dig +short myip.opendns.com @resolver1.opendns.com"
PUBLICIPNOTIF_LOCATION="$HOME/.publicipnotifier"
OLD_IP=""
NEW_IP=""
DEST_EMAIL="localhost@localhost"
SUBJECT="Your IP address in your Linux box has changed"
MESSAGE="The public address for ${HOSTNAME} has changed: "

# Check if dig is present on the system
command -v dig > /dev/null 2>&1 || { echo >&2 "dig is needed to execute the script, please install it and try again. Aborting."; exit 1; }

# Check if the .publicipnotifier file is present
# If it is present, read it and store the old IP in a variable
if [ -f $PUBLICIPNOTIF_LOCATION ]; then
    OLD_IP=`cat $PUBLICIPNOTIF_LOCATION`
fi

# Retrieve the Public IP from ifconfig.me and store it in a new variable
NEW_IP=`$COMMAND_TO_EXECUTE`

# Compare if the new IP is different from the old one, and if it is,
#  notify over email, otherwise do nothing
# Store the new IP in the ~/.publicipnotifier file
if [[ $NEW_IP != $OLD_IP ]]; then
    echo "$MESSAGE $NEW_IP"
    echo $NEW_IP > $PUBLICIPNOTIF_LOCATION
fi


