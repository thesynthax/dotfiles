#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Keyhints. Idea got from Garuda Hyprland

# GDK BACKEND. Change to either wayland or x11 if having issues
BACKEND=wayland

# Detect monitor resolution and scale
x_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .width')
y_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .height')
hypr_scale=$(hyprctl -j monitors | jq '.[] | select (.focused == true) | .scale' | sed 's/\.//')

# Calculate width and height based on percentages and monitor resolution
width=$((x_mon * hypr_scale / 100))
height=$((y_mon * hypr_scale / 100))

# Set maximum width and height
max_width=1200
max_height=1000

# Set percentage of screen size for dynamic adjustment
percentage_width=70
percentage_height=70

# Calculate dynamic width and height
dynamic_width=$((width * percentage_width / 100))
dynamic_height=$((height * percentage_height / 100))

# Limit width and height to maximum values
dynamic_width=$(($dynamic_width > $max_width ? $max_width : $dynamic_width))
dynamic_height=$(($dynamic_height > $max_height ? $max_height : $dynamic_height))

# Launch yad with calculated width and height
GDK_BACKEND=$BACKEND yad --width=$dynamic_width --height=$dynamic_height \
    --center \
    --title="Keybindings" \
    --no-buttons \
    --list \
    --column=Key: \
    --column=Description: \
    --column=Command: \
    --timeout-indicator=bottom \
"ESC" "close this app" "" "=" "SUPER KEY (Windows Key)" "(SUPER KEY)" \
" enter" "Terminal" "(kitty)" \
" SHIFT enter" "DropDown Terminal" "(kitty-pyprland)" \
" A" "Desktop Overview" "(AGS Overview)" \
" D" "App Launcher" "(rofi-wayland)" \
" SHIFT D" "Command Runner" "(rofi-wayland)" \
" SHIFT P" "Power Menu" "(powermenu)" \
" CTRL P" "Pass menu" "(passmenu)" \
" S" "Google Search" "(rofi)" \
" Q" "close active window" "(not kill)" \
" Shift Q " "kills an active window" "(kill)" \
" Z" "Desktop Zoom" "(pyprland)" \
" W" "Open Browser" "(brave)" \
" SHIFT E" "Open File Manager" "(thunar)" \
" Alt V" "Clipboard Manager" "(cliphist)" \
" CTRL W" "Choose wallpaper" "(waydeeper depth effect)" \
" SHIFT W" "Choose wallpaper effects" "(imagemagick + swww)" \
"CTRL ALT W" "Random wallpaper" "(waydeeper depth effect)" \
" ALT W" "Toggle depth effect" "(waydeeper on/off)" \
" B" "Hide/UnHide Waybar" "waybar" \
" CTRL B" "Choose waybar styles" "(waybar styles)" \
" ALT B" "Choose waybar layout" "(waybar layout)" \
" ALT R" "Reload Waybar swaync Rofi" "CHECK NOTIFICATION FIRST!!!" \
" SHIFT N" "Launch Notification Panel" "swaync Notification Center" \
" Print" "screenshot" "(grim)" \
" Shift Print" "screenshot region" "(grim + slurp)" \
" Shift S" "screenshot region" "(swappy)" \
" CTRL Print" "screenshot timer 5 secs " "(grim)" \
" CTRL SHIFT Print" "screenshot timer 10 secs " "(grim)" \
" CTRL SHIFT S" "OCR " "(grim + tesseract)" \
"ALT Print" "Screenshot active window" "active window only" \
" C" "screen lock" "(hyprlock)" \
"CTRL ALT Del" "Hyprland Exit" "(SAVE YOUR WORK!!!)" \
" F" "Fullscreen" "Toggles to full screen" \
" ALT L" "Toggle Dwindle | Master Layout" "Hyprland Layout" \
" Shift F" "Toggle float" "single window" \
" ALT F" "Toggle all windows to float" "all windows" \
" Shift B" "Toggle Blur" "normal or less blur" \
" SHIFT G" "Gamemode! All animations OFF or ON" "toggle" \
" ALT E" "Rofi Emoticons" "Emoticon" \
" ALT V" "Clipboard Manager" "cliphist" \
" H" "Launch this app" "" \
" E" "View or EDIT Keybinds, Settings, Monitor" "" \
