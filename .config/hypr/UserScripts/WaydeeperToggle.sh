#!/bin/bash
# Toggle waydeeper depth effect wallpapers on/off
# Preserves per-monitor wallpaper assignments across toggles

CACHE_DIR="$HOME/.cache/waydeeper"
STATE_FILE="$CACHE_DIR/state"
MONITORS_FILE="$CACHE_DIR/monitors.json"
WAYDEEPER_CONFIG="$HOME/.config/waydeeper/config.json"
ROFI_WALLPAPER="$HOME/.config/rofi/.current_wallpaper"
WALLPAPER_EFFECTS="$HOME/.config/hypr/wallpaper_effects/.wallpaper_current"

mkdir -p "$CACHE_DIR"

if [ -f "$STATE_FILE" ] && [ "$(cat "$STATE_FILE")" = "on" ]; then
  # === Turn OFF ===
  # Read per-monitor wallpapers from waydeeper config
  python3 -c "
import json
c = json.load(open('$WAYDEEPER_CONFIG'))
monitors = c.get('monitors', {})
out = {m: v.get('wallpaper_path', '') for m, v in monitors.items()}
json.dump(out, open('$MONITORS_FILE', 'w'))
" 2>/dev/null

  # Start awww once, then set per-monitor wallpapers
  awww query || awww-daemon --format xrgb

  # Set wallpaper on each monitor, then stop waydeeper
  python3 -c "
import json
monitors = json.load(open('$MONITORS_FILE'))
for monitor, wp in monitors.items():
    if wp and __import__('os').path.isfile(wp):
        print(f'{monitor}:{wp}')
" 2>/dev/null | while IFS=: read -r mon wp; do
    awww img -o "$mon" "$wp" --transition-fps 60 --transition-type any --transition-duration 0
  done

  # Update focused monitor's symlinks
  focused_monitor=$(hyprctl monitors | awk '/^Monitor/{name=$2} /focused: yes/{print name}')
  python3 -c "
import json
monitors = json.load(open('$MONITORS_FILE'))
wp = monitors.get('$focused_monitor', '')
if wp:
    print(wp)
" 2>/dev/null | while read -r wp; do
    if [ -n "$wp" ] && [ -f "$wp" ]; then
      ln -sf "$wp" "$ROFI_WALLPAPER"
      cp -r "$wp" "$WALLPAPER_EFFECTS"
    fi
  done

  waydeeper stop
  echo "off" > "$STATE_FILE"
  notify-send -e -u low "waydeeper OFF"
else
  # === Turn ON ===
  # Restore per-monitor wallpapers from saved state
  if [ -f "$MONITORS_FILE" ]; then
    python3 -c "
import json
monitors = json.load(open('$MONITORS_FILE'))
for monitor, wp in monitors.items():
    if wp and __import__('os').path.isfile(wp):
        print(f'{monitor}:{wp}')
" 2>/dev/null | while IFS=: read -r mon wp; do
      waydeeper set "$wp" -m "$mon"
    done
  else
    # Fallback: focused monitor only
    focused_monitor=$(hyprctl monitors | awk '/^Monitor/{name=$2} /focused: yes/{print name}')
    wp=$(readlink -f "$ROFI_WALLPAPER" 2>/dev/null)
    if [ -n "$wp" ] && [ -f "$wp" ]; then
      waydeeper set "$wp" -m "$focused_monitor"
    else
      notify-send -e -u critical "waydeeper: no wallpaper found"
      exit 1
    fi
  fi

  echo "on" > "$STATE_FILE"
  notify-send -e -u low "waydeeper ON"
fi
