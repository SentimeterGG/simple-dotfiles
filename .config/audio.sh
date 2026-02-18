#!/bin/sh

get_vol() {
  VOL=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | head -n1 | tr -d '%')
  MUTE=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
  if [ "$MUTE" = "yes" ]; then
    echo "0%   "
  else
    echo "${VOL}%  "
  fi
}

get_mic() {
  VOL=$(pactl get-source-volume @DEFAULT_SOURCE@ | awk '{print $5}' | head -n1 | tr -d '%')
  MUTE=$(pactl get-source-mute @DEFAULT_SOURCE@ | awk '{print $2}')
  if [ "$MUTE" = "yes" ]; then
    echo "0%   "
  else
    echo "${VOL}%  "
  fi
}

print_all() {
  printf "%s    %s\n" "$(get_vol)" "$(get_mic)"
}

# Print initial state
print_all

# Listen for changes
pactl subscribe | while read -r line; do
  case "$line" in
  *"sink"* | *"source"*)
    print_all
    ;;
  esac
done
