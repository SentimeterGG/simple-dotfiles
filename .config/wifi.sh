#!/bin/sh

# Get the active WiFi using nmcli
SSID=$(nmcli -t -f active,ssid,signal dev wifi | grep '^yes' | awk -F: '{print $2 " (" $3 "%)"}')

# If empty, fallback to Disconnected
if [ -z "$SSID" ]; then
  echo "Disconnected  "
else
  echo "$SSID  "
fi
