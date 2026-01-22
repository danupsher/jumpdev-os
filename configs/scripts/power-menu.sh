#!/bin/bash
# JumpDev OS Power Menu - Click outside to close

# Kill any existing instances
pkill -x wofi 2>/dev/null && exit 0
pkill -x slurp 2>/dev/null

# Get screen dimensions
SCREEN=$(hyprctl monitors -j | jq -r '.[0] | "\(.width)x\(.height)"')

# Launch slurp as invisible click-catcher in background
(slurp -b 00000066 -c 00000000 -w 0 -f "%x %y" <<< "0,0 $SCREEN" > /dev/null 2>&1; pkill -x wofi) &
SLURP_PID=$!

# Power menu options
options="  Lock\n  Logout\n  Restart\n  Shutdown"

selected=$(echo -e "$options" | wofi --dmenu \
    --width 150 \
    --height 176 \
    --location top-right \
    --xoffset -10 \
    --yoffset 44 \
    --hide-search \
    --cache-file /dev/null)

# Cleanup slurp
kill $SLURP_PID 2>/dev/null

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
