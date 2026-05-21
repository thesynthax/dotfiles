#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Wallust Colors for current wallpaper

# Define the path to the swww cache directory
cache_dir="$HOME/.cache/awww/"

# Find the actual cache subdirectory (may contain version subdir)
actual_cache_dir=$(find "$cache_dir" -type d -name '[0-9]*.[0-9]*.[0-9]*' 2>/dev/null | head -n 1)
if [ -z "$actual_cache_dir" ]; then
  actual_cache_dir="$cache_dir"
fi

# Initialize a flag to determine if the ln command was executed
ln_success=false

# Get current focused monitor
current_monitor=$(hyprctl monitors | awk '/^Monitor/{name=$2} /focused: yes/{print name}')
echo $current_monitor
# Construct the full path to the cache file
cache_file="$actual_cache_dir/$current_monitor"
echo $cache_file
# Check if the cache file exists for the current monitor output
if [ -f "$cache_file" ]; then
  # Get the wallpaper path from the null-delimited cache file
  wallpaper_path=$(tr '\0' '\n' < "$cache_file" | tail -n 1)
  echo $wallpaper_path
  # symlink the wallpaper to the location Rofi can access
  if ln -sf "$wallpaper_path" "$HOME/.config/rofi/.current_wallpaper"; then
    ln_success=true # Set the flag to true upon successful execution
  fi
  # copy the wallpaper for wallpaper effects
  cp -r "$wallpaper_path" "$HOME/.config/hypr/wallpaper_effects/.wallpaper_current"
fi

# Check the flag before executing further commands
if [ "$ln_success" = true ]; then
  # execute wallust
  echo 'about to execute wallust'
  # execute wallust skipping tty and terminal changes
  wallust run "$wallpaper_path" -s

  # reload kitty colors in running terminals
  if pidof kitty >/dev/null; then
    kill -SIGUSR1 $(pidof kitty) 2>/dev/null
  fi

fi
