#!/bin/bash
# JumpDev OS Power Menu - Click outside to close

# Toggle - if wofi is running, kill it and slurp
if pgrep -x wofi > /dev/null; then
    pkill -x wofi
    pkill -x slurp
    exit 0
fi

# Kill any lingering slurp
pkill -x slurp 2>/dev/null

# Launch slurp as click-catcher in background (semi-transparent overlay)
(slurp -b '#00000066' -c '#00000000' -s '#00000000' -w 0 > /dev/null 2>&1; pkill -x wofi) &

# Small delay to ensure slurp starts first
sleep 0.05

# Power menu options
options="  Lock\n  Logout\n  Restart\n  Shutdown"

selected=$(echo -e "$options" | wofi --dmenu \
    --width 150 \
    --lines 4 \
    --location top_right \
    --xoffset -10 \
    --yoffset 44 \
    --hide-search \
    --cache-file /dev/null)

# Cleanup slurp
pkill -x slurp 2>/dev/null

# Execute selected action
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
