#!/bin/bash
# JumpDev OS App Launcher - Toggle

if pgrep -x wofi > /dev/null; then
    pkill -x wofi
else
    wofi --show drun --prompt 'Launch'
fi
