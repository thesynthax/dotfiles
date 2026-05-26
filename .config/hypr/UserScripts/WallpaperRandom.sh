#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Script for Random Wallpaper ( CTRL ALT W)

wallDIR="$HOME/.wallpaper"
scriptsDir="$HOME/.config/hypr/scripts"

focused_monitor=$(hyprctl monitors | awk '/^Monitor/{name=$2} /focused: yes/{print name}')

PICS=($(find ${wallDIR} -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" \)))
RANDOMPICS=${PICS[$RANDOM % ${#PICS[@]}]}

ln -sf "$RANDOMPICS" "$HOME/.config/rofi/.current_wallpaper"
cp -r "$RANDOMPICS" "$HOME/.config/hypr/wallpaper_effects/.wallpaper_current"

# Check waydeeper state, use appropriate backend
if [ -f "$HOME/.cache/waydeeper/state" ] && [ "$(cat "$HOME/.cache/waydeeper/state")" = "on" ]; then
  waydeeper set "$RANDOMPICS" -m "$focused_monitor"
else
  # Track per-monitor wallpaper for seamless toggle
  MONITORS_FILE="$HOME/.cache/waydeeper/monitors.json"
  python3 -c "
import json
f = '$MONITORS_FILE'
try:
    m = json.load(open(f))
except:
    m = {}
m['$focused_monitor'] = '$RANDOMPICS'
json.dump(m, open(f, 'w'))
" 2>/dev/null

  awww query || awww-daemon --format xrgb
  awww img -o "$focused_monitor" "$RANDOMPICS" --transition-fps 60 --transition-type random --transition-duration 1
fi

${scriptsDir}/WallustSwww.sh
sleep 1
${scriptsDir}/Refresh.sh
sleep 0.2
${scriptsDir}/walogram.sh
