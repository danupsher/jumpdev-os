#!/bin/bash
# JumpDev OS Power Menu - Small dropdown via wofi

# Toggle - if wofi is running, kill it
if pgrep -x wofi > /dev/null; then
    pkill wofi
    exit 0
fi

options="  Lock\n  Logout\n  Restart\n  Shutdown"

selected=$(echo -e "$options" | wofi --dmenu \
    --width 150 \
    --height 176 \
    --location top-right \
    --xoffset -10 \
    --yoffset 44 \
    --hide-search \
    --cache-file /dev/null \
    --normal-window)

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
