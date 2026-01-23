#!/bin/bash
# JumpDev OS Volume Popup - Click outside to close

# Toggle - if wofi is running, kill it
if pgrep -x wofi > /dev/null; then
    pkill -x wofi
    pkill -x slurp
    exit 0
fi

# Kill any lingering slurp
pkill -x slurp 2>/dev/null

# Get current volume
current=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -1 | tr -d '%')
muted=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -q 'yes' && echo "yes" || echo "no")

# Build options with current indicator
options=""
for vol in 100 75 50 25 0; do
    if [ "$vol" -eq "$current" ] && [ "$muted" = "no" ]; then
        mark="●"
    else
        mark=" "
    fi

    if [ "$vol" -eq 0 ]; then
        options+="$mark   Mute\n"
    elif [ "$vol" -lt 50 ]; then
        options+="$mark   $vol%\n"
    else
        options+="$mark   $vol%\n"
    fi
done

# Add unmute option if muted
if [ "$muted" = "yes" ]; then
    options="●   Muted\n$options"
fi

# Launch slurp as click-catcher
(slurp -b '#00000066' -c '#00000000' -s '#00000000' -w 0 > /dev/null 2>&1; pkill -x wofi) &

sleep 0.05

# Show wofi
selected=$(echo -e "$options" | wofi --dmenu \
    --width 140 \
    --lines 6 \
    --location top_right \
    --xoffset -10 \
    --yoffset 44 \
    --hide-search \
    --cache-file /dev/null)

# Cleanup slurp
pkill -x slurp 2>/dev/null

# Apply selection
case "$selected" in
    *"100%"*)
        pactl set-sink-mute @DEFAULT_SINK@ 0
        pactl set-sink-volume @DEFAULT_SINK@ 100%
        ;;
    *"75%"*)
        pactl set-sink-mute @DEFAULT_SINK@ 0
        pactl set-sink-volume @DEFAULT_SINK@ 75%
        ;;
    *"50%"*)
        pactl set-sink-mute @DEFAULT_SINK@ 0
        pactl set-sink-volume @DEFAULT_SINK@ 50%
        ;;
    *"25%"*)
        pactl set-sink-mute @DEFAULT_SINK@ 0
        pactl set-sink-volume @DEFAULT_SINK@ 25%
        ;;
    *"Mute"*|*"Muted"*)
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        ;;
esac
