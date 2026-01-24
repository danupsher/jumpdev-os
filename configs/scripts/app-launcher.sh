#!/bin/bash
# JumpDev OS App Launcher with click-outside-to-close

# Ensure Wayland environment is set
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
export WAYLAND_DISPLAY="${WAYLAND_DISPLAY:-wayland-1}"

# Ensure clean state
pkill -x slurp 2>/dev/null
sleep 0.05

# Toggle - if rofi is running, kill it
if pgrep -x rofi > /dev/null; then
    pkill -x rofi
    exit 0
fi

# Launch slurp fullscreen overlay FIRST (same as power menu)
slurp -p -b 00000000 -c 00000000 -s 00000000 -B 00000000 > /dev/null 2>&1 &
SLURP_PID=$!

sleep 0.1

# Verify slurp is running
if ! kill -0 $SLURP_PID 2>/dev/null; then
    echo "Error: slurp failed to start" >&2
    exit 1
fi

# Launch rofi (will appear above slurp)
rofi -show drun -hover-select -me-select-entry '' -me-accept-entry MousePrimary -p "" -theme ~/.config/rofi/config.rasi &
ROFI_PID=$!

sleep 0.1

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
