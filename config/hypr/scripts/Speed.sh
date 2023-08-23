#!/bin/bash

# Set the appropriate interface (e.g., eth0, wlan0) based on your network connection
INTERFACE="wlan0"

# Run speedtest-cli and extract download and upload speeds
SPEEDS=$(speedtest-cli --json)
DOWNLOAD=$(echo "$SPEEDS" | jq -r '.download / 1000000') # Convert to Mbps
UPLOAD=$(echo "$SPEEDS" | jq -r '.upload / 1000000')     # Convert to Mbps

# Format the speeds with two decimal places
DOWNLOAD_FORMATTED=$(printf "%.2f" "$DOWNLOAD")
UPLOAD_FORMATTED=$(printf "%.2f" "$UPLOAD")

# Remove trailing ",00" if no decimals
DOWNLOAD_FORMATTED=$(echo "$DOWNLOAD_FORMATTED" | sed 's/\,00//')
UPLOAD_FORMATTED=$(echo "$UPLOAD_FORMATTED" | sed 's/\,00//')

# Output the formatted data for Waybar
echo "↓ ${DOWNLOAD_FORMATTED} Mbps ↑ ${UPLOAD_FORMATTED} Mbps"
