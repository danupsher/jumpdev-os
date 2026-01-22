#!/bin/bash
# JumpDev OS - VM Interaction Script
# Run commands inside the VM, take screenshots

SSH_PORT="${SSH_PORT:-2222}"
SSH_CMD="ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p $SSH_PORT jump@localhost"
SCREENSHOT_DIR="/home/dan/projects/jumpdev-os/test-screenshots"

mkdir -p "$SCREENSHOT_DIR"

# Wait for VM to be ready
wait_for_vm() {
    echo "Waiting for VM to be ready..."
    for i in {1..60}; do
        if $SSH_CMD "echo ready" 2>/dev/null; then
            echo "VM is ready!"
            return 0
        fi
        sleep 2
    done
    echo "Timeout waiting for VM"
    return 1
}

# Take a screenshot and save it
screenshot() {
    local name="${1:-screenshot}"
    local timestamp=$(date +%Y%m%d-%H%M%S)
    local filename="${SCREENSHOT_DIR}/${name}-${timestamp}.png"

    $SSH_CMD "grim -" > "$filename" 2>/dev/null

    if [ -f "$filename" ] && [ -s "$filename" ]; then
        echo "Screenshot saved: $filename"
        echo "$filename"
    else
        echo "Failed to take screenshot"
        rm -f "$filename"
        return 1
    fi
}

# Click at coordinates
click() {
    local x="$1"
    local y="$2"
    echo "Clicking at ($x, $y)"
    $SSH_CMD "ydotool mousemove -a $x $y && ydotool click 0xC0"
}

# Type text
type_text() {
    local text="$1"
    echo "Typing: $text"
    $SSH_CMD "ydotool type '$text'"
}

# Press key
press_key() {
    local key="$1"
    echo "Pressing: $key"
    $SSH_CMD "ydotool key $key"
}

# Run a command in the VM
run_cmd() {
    $SSH_CMD "$@"
}

# Get screen resolution
get_resolution() {
    $SSH_CMD "hyprctl monitors -j | jq -r '.[0] | \"\(.width)x\(.height)\"'"
}

# Test the Apps button (top-left area of waybar)
test_apps_button() {
    echo "=== Testing Apps Button ==="
    screenshot "before-apps"
    click 30 17  # Apps button position (approximate)
    sleep 1
    screenshot "after-apps-click"
    press_key "escape"  # Close menu
    sleep 0.5
    screenshot "after-escape"
}

# Test the Power button (top-right area of waybar)
test_power_button() {
    echo "=== Testing Power Button ==="
    local res=$(get_resolution)
    local width=$(echo $res | cut -dx -f1)
    local power_x=$((width - 30))

    screenshot "before-power"
    click $power_x 17  # Power button position
    sleep 1
    screenshot "after-power-click"
    press_key "escape"
    sleep 0.5
    screenshot "after-power-escape"
}

# Main
case "$1" in
    wait)
        wait_for_vm
        ;;
    screenshot)
        screenshot "${2:-manual}"
        ;;
    click)
        click "$2" "$3"
        ;;
    type)
        type_text "$2"
        ;;
    key)
        press_key "$2"
        ;;
    cmd)
        shift
        run_cmd "$@"
        ;;
    resolution)
        get_resolution
        ;;
    test-apps)
        test_apps_button
        ;;
    test-power)
        test_power_button
        ;;
    test-all)
        wait_for_vm
        sleep 5  # Wait for Hyprland to fully start
        test_apps_button
        test_power_button
        ;;
    *)
        echo "Usage: $0 {wait|screenshot|click|type|key|cmd|resolution|test-apps|test-power|test-all}"
        echo ""
        echo "Commands:"
        echo "  wait              - Wait for VM to be SSH-ready"
        echo "  screenshot [name] - Take a screenshot"
        echo "  click X Y         - Click at coordinates"
        echo "  type 'text'       - Type text"
        echo "  key KEYCODE       - Press a key"
        echo "  cmd COMMAND       - Run a command in the VM"
        echo "  resolution        - Get screen resolution"
        echo "  test-apps         - Test the Apps button"
        echo "  test-power        - Test the Power button"
        echo "  test-all          - Run all tests"
        ;;
esac
