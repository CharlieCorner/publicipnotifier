#!/bin/bash

# Define messages and configuration variables
IFCONFIGME_URL="ifconfig.me/ip"
PUBLICIPNOTIF_LOCATION="~/.publicipnotifier"
OLD_IP=""
NEW_IP=""
DEST_EMAIL="localhost@localhost"
SUBJECT="Your IP address in your Linux box has changed"
MESSAGE="The public address for ${HOSTNAME} has changed: "
echo "$MESSAGE"

# Check if curl is present on the system
command -v curl > /dev/null 2>&1 || { echo >&2 "curl is needed to execute the script, please install it and try again. Aborting."; exit 1; }

# Check if the .publicipnotifier file is present
# If it is present, read it and store the old IP in a variable
if [ -f "$PUBLICIPNOTIF_LOCATION" ]; then
    OLD_IP = `cat $PUBLICIPNOTIF_LOCATION`
    echo $OLD_IP
fi

# Retrieve the Public IP from ifconfig.me and store it in a new variable
NEW_IP = $(curl "$IFCONFIGME_URL")
echo "$NEW_IP"

# Compare if the new IP is different from the old one, and if it is,
#  notify over email, otherwise do nothing

# Store the new IP in the ~/.publicipnotifier file

