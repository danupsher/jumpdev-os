#!/bin/bash
# JumpDev OS Power Menu with click-outside-to-close

# Toggle - if rofi is running, kill it
if pgrep -x rofi > /dev/null; then
    pkill -x rofi
    pkill -x slurp
    exit 0
fi

# Power menu options
options="Lock\nLogout\nRestart\nShutdown"

# Launch transparent slurp overlay in background
slurp -b 00000000 -c 00000000 -s 00000000 -B 00000000 -d > /dev/null 2>&1 &
SLURP_PID=$!

sleep 0.05

# Launch rofi in background, capture output via temp file
TMPFILE=$(mktemp)
echo -e "$options" | rofi -dmenu -hover-select -me-select-entry '' -me-accept-entry MousePrimary \
    -theme ~/.config/rofi/power-menu.rasi \
    -p "" > "$TMPFILE" &
ROFI_PID=$!

# Wait for either process to exit
while kill -0 $SLURP_PID 2>/dev/null && kill -0 $ROFI_PID 2>/dev/null; do
    sleep 0.1
done

# Kill both
kill $SLURP_PID 2>/dev/null
kill $ROFI_PID 2>/dev/null

# Read selection
selected=$(cat "$TMPFILE")
rm -f "$TMPFILE"

case "$selected" in
    "Lock")
        swaylock -f -c 1e1e2e
        ;;
    "Logout")
        hyprctl dispatch exit
        ;;
    "Restart")
        systemctl reboot
        ;;
    "Shutdown")
        systemctl poweroff
        ;;
esac
