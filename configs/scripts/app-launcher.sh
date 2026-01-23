#!/bin/bash
# JumpDev OS App Launcher with click-outside-to-close

# Ensure Wayland environment is set
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
export WAYLAND_DISPLAY="${WAYLAND_DISPLAY:-wayland-1}"

# Ensure clean state - kill any existing instances
pkill -x slurp 2>/dev/null
sleep 0.05

# Toggle - if rofi is running, kill it
if pgrep -x rofi > /dev/null; then
    pkill -x rofi
    exit 0
fi

# Launch slurp fullscreen overlay in point-selection mode
# This creates an invisible layer that captures any click outside rofi
slurp -p -b 00000000 -c 00000000 -s 00000000 -B 00000000 > /dev/null 2>&1 &
SLURP_PID=$!

# Wait for slurp to establish its layer surface
sleep 0.1

# Verify slurp is running before launching rofi
if ! kill -0 $SLURP_PID 2>/dev/null; then
    echo "Error: slurp failed to start" >&2
    exit 1
fi

# Launch rofi (will appear above slurp on overlay layer)
rofi -show drun -hover-select -me-select-entry '' -me-accept-entry MousePrimary -p "" -theme ~/.config/rofi/config.rasi &
ROFI_PID=$!

# Wait for rofi to appear
sleep 0.1

# Monitor loop - efficient polling
while kill -0 $ROFI_PID 2>/dev/null && kill -0 $SLURP_PID 2>/dev/null; do
    sleep 0.05
done

# Determine what happened and cleanup
if ! kill -0 $SLURP_PID 2>/dev/null; then
    # Slurp died = user clicked outside rofi
    kill $ROFI_PID 2>/dev/null
fi

if ! kill -0 $ROFI_PID 2>/dev/null; then
    # Rofi died = user selected app or pressed escape
    kill $SLURP_PID 2>/dev/null
fi

# Wait for processes to fully exit
wait $ROFI_PID 2>/dev/null
wait $SLURP_PID 2>/dev/null
