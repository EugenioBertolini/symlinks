#!/bin/env bash

SELECTION=$(echo -e "Shutdown\nReboot" | fuzzel -d -p " " -w 25 -l 2)

case $SELECTION in
"Shutdown")
  systemctl poweroff
  ;;
"Reboot")
  systemctl reboot
  ;;
*) ;;
esac
