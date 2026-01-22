#!/bin/bash
# JumpDev OS App Launcher - Click outside to close

# Kill any existing instances
pkill -x wofi 2>/dev/null && exit 0
pkill -x slurp 2>/dev/null

# Get screen dimensions
SCREEN=$(hyprctl monitors -j | jq -r '.[0] | "\(.width)x\(.height)"')

# Launch slurp as invisible click-catcher in background
# When clicked, it exits and we kill wofi
(slurp -b 00000066 -c 00000000 -w 0 -f "%x %y" <<< "0,0 $SCREEN" > /dev/null 2>&1; pkill -x wofi) &
SLURP_PID=$!

# Launch wofi
wofi --show drun --prompt 'Launch'

# Cleanup slurp when wofi closes
kill $SLURP_PID 2>/dev/null
