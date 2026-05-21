#!/bin/bash
# Switch/move workspace with per-monitor offset
# Usage: switch-workspace.sh focus|move|movesilent <num>

focused_monitor=$(hyprctl monitors | awk '/^Monitor/{name=$2} /focused: yes/{print name}')

num=$2
if [ "$focused_monitor" = "HDMI-A-2" ]; then
  num=$((num + 10))
fi

case "$1" in
  focus)
    hyprctl dispatch "hl.dsp.focus({ workspace = $num })"
    ;;
  move)
    hyprctl dispatch "hl.dsp.window.move({ workspace = $num })"
    ;;
  movesilent)
    hyprctl dispatch "hl.dsp.window.move({ workspace = $num, silent = true })"
    ;;
esac
