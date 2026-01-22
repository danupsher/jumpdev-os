#!/bin/bash
# JumpDev OS Power Menu - Small dropdown via wofi

options="  Lock\n  Logout\n  Restart\n  Shutdown"

selected=$(echo -e "$options" | wofi --dmenu --prompt "Power" --width 200 --height 200 --cache-file /dev/null)

case "$selected" in
    *"Lock")
        swaylock -f -c 1e1e2e
        ;;
    *"Logout")
        hyprctl dispatch exit
        ;;
    *"Restart")
        systemctl reboot
        ;;
    *"Shutdown")
        systemctl poweroff
        ;;
esac
