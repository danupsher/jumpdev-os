#!/bin/bash
# JumpDev OS App Launcher with click-outside-to-close

# Toggle - if rofi is running, kill it
if pgrep -x rofi > /dev/null; then
    pkill -x rofi
    pkill -x slurp
    exit 0
fi

# Launch transparent slurp overlay in background
# When user clicks outside rofi, slurp captures it and exits
slurp -b 00000000 -c 00000000 -s 00000000 -B 00000000 -d > /dev/null 2>&1 &
SLURP_PID=$!

# Small delay to ensure slurp is ready
sleep 0.05

# Launch rofi in background
rofi -show drun -hover-select -me-select-entry '' -me-accept-entry MousePrimary -p "" -theme ~/.config/rofi/config.rasi &
ROFI_PID=$!

# Wait for either process to exit
while kill -0 $SLURP_PID 2>/dev/null && kill -0 $ROFI_PID 2>/dev/null; do
    sleep 0.1
done

# Kill both (whichever is still running)
kill $SLURP_PID 2>/dev/null
kill $ROFI_PID 2>/dev/null
