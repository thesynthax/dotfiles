#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Wallust Colors for current wallpaper

wallpaper_path=""
rofi_wallpaper="$HOME/.config/rofi/.current_wallpaper"

# Try swww cache first
cache_dir="$HOME/.cache/awww/"
actual_cache_dir=$(find "$cache_dir" -type d -name '[0-9]*.[0-9]*.[0-9]*' 2>/dev/null | head -n 1)
if [ -z "$actual_cache_dir" ]; then
  actual_cache_dir="$cache_dir"
fi

current_monitor=$(hyprctl monitors | awk '/^Monitor/{name=$2} /focused: yes/{print name}')
cache_file="$actual_cache_dir/$current_monitor"

if [ -f "$cache_file" ]; then
  wallpaper_path=$(tr '\0' '\n' < "$cache_file" | tail -n 1)
fi

# Fallback to rofi symlink (set by waydeeper)
if [ -z "$wallpaper_path" ] && [ -L "$rofi_wallpaper" ]; then
  wallpaper_path=$(readlink -f "$rofi_wallpaper")
fi

if [ -n "$wallpaper_path" ] && [ -f "$wallpaper_path" ]; then
  ln -sf "$wallpaper_path" "$rofi_wallpaper"
  cp -r "$wallpaper_path" "$HOME/.config/hypr/wallpaper_effects/.wallpaper_current"

  wallust run "$wallpaper_path" -s

  if pidof kitty >/dev/null; then
    kill -SIGUSR1 $(pidof kitty) 2>/dev/null
  fi
fi
