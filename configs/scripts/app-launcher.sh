#!/bin/bash
# JumpDev OS App Launcher with click-outside-to-close

# Ensure Wayland environment is set
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
export WAYLAND_DISPLAY="${WAYLAND_DISPLAY:-wayland-1}"

# Ensure clean state
pkill -x slurp 2>/dev/null

# Toggle - if rofi is running, kill it
if pgrep -x rofi > /dev/null; then
    pkill -x rofi
    exit 0
fi

# Launch rofi FIRST so it gets keyboard focus
rofi -show drun -hover-select -me-select-entry '' -me-accept-entry MousePrimary -p "" -theme ~/.config/rofi/config.rasi &
ROFI_PID=$!

# Brief pause for rofi to grab focus
sleep 0.15

# Now launch slurp overlay (won't steal focus from rofi)
slurp -p -b 00000000 -c 00000000 -s 00000000 -B 00000000 > /dev/null 2>&1 &
SLURP_PID=$!

# Monitor loop
while kill -0 $ROFI_PID 2>/dev/null && kill -0 $SLURP_PID 2>/dev/null; do
    sleep 0.05
done

# Cleanup
if ! kill -0 $SLURP_PID 2>/dev/null; then
    kill $ROFI_PID 2>/dev/null
fi
if ! kill -0 $ROFI_PID 2>/dev/null; then
    kill $SLURP_PID 2>/dev/null
fi

wait $ROFI_PID 2>/dev/null
wait $SLURP_PID 2>/dev/null
