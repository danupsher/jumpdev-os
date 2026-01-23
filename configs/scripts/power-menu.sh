#!/bin/bash
# JumpDev OS Power Menu

# Toggle - if rofi is running, kill it
if pgrep -x rofi > /dev/null; then
    pkill -x rofi
    exit 0
fi

# Power menu options
options="Lock\nLogout\nRestart\nShutdown"

selected=$(echo -e "$options" | rofi -dmenu -click-to-exit \
    -theme ~/.config/rofi/power-menu.rasi \
    -p "Power")

case "$selected" in
    "Lock")
        swaylock -f -c 1e1e2e
        ;;
    "Logout")
        hyprctl dispatch exit
        ;;
    "Restart")
        systemctl reboot
        ;;
    "Shutdown")
        systemctl poweroff
        ;;
esac
