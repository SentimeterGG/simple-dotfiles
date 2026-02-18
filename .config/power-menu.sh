#!/bin/bash

# Define your menu options
options="Shutdown\nReboot\nLogout\nSuspend\nLock"

# Show menu in Rofi
choice=$(echo -e "$options" | rofi -dmenu -i -p "" -location 3 -yoffset 65 -xoffset -14 -theme-str 'inputbar { enabled: false; } listview { lines: 5; } window {width: 150px;}')

# Execute corresponding command
case "$choice" in
Shutdown)
  systemctl poweroff
  ;;
Reboot)
  systemctl reboot
  ;;
Logout)
  i3-msg exit
  ;;
Suspend)
  systemctl suspend
  ;;
Lock)
  # If you use swaylock, i3lock, or similar
  i3lock
  ;;
esac
