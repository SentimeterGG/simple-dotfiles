#!/bin/sh
# Updates Eww WORKSPACE variable with the current workspace

# Print current workspace once at startup
CURRENT=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).name')
eww update WORKSPACE="$CURRENT"

# Listen for workspace focus changes
i3-msg -t subscribe -m '["workspace"]' |
  while read -r line; do
    WS=$(echo "$line" | jq -r 'select(.change=="focus") | .current.name')
    if [ -n "$WS" ]; then
      eww update WORKSPACE="$WS"
    fi
  done
