#!/bin/bash
# JumpDev OS App Launcher

# Toggle - if rofi is running, kill it
if pgrep -x rofi > /dev/null; then
    pkill -x rofi
    exit 0
fi

rofi -show drun -click-to-exit -me-accept-entry "MousePrimary" -p "" -theme ~/.config/rofi/config.rasi
