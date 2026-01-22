# Auto-start Hyprland on TTY1
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
  exec uwsm start hyprland-uwsm.desktop 2>/dev/null || exec Hyprland
fi
