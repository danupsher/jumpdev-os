#!/bin/bash
# JumpDev OS App Launcher - Click outside to close

# Toggle - if wofi is running, kill it and slurp
if pgrep -x wofi > /dev/null; then
    pkill -x wofi
    pkill -x slurp
    exit 0
fi

# Kill any lingering slurp
pkill -x slurp 2>/dev/null

# Launch slurp as click-catcher in background (semi-transparent overlay)
# When clicked anywhere, slurp exits and kills wofi
(slurp -b '#00000066' -c '#00000000' -s '#00000000' -w 0 > /dev/null 2>&1; pkill -x wofi) &

# Small delay to ensure slurp starts first
sleep 0.05

# Launch wofi (blocks until closed)
wofi --show drun --prompt 'Launch'

# Cleanup slurp when wofi closes
pkill -x slurp 2>/dev/null
