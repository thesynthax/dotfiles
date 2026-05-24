#!/bin/bash
# Rofi menu for Quick Edit/View of Settings (SUPER E)

# Define preferred text editor and terminal
edit=${EDITOR:-nvim}
tty=kitty

# Paths to configuration directories
configs="$HOME/.config/hypr/configs"
UserConfigs="$HOME/.config/hypr/UserConfigs"

# Function to display the menu options
menu() {
    cat <<EOF
1. Edit Env-variables
2. Edit Window-Rules
3. Edit Startup_Apps
4. Edit User-Keybinds
5. Edit Monitors
6. Edit Laptop-Keybinds
7. Edit User-Settings
8. Edit Workspace-Rules
9. Edit Default-Settings
10. Edit Default-Keybinds
EOF
}

# Main function to handle menu selection
main() {
    choice=$(menu | rofi -i -dmenu -config ~/.config/rofi/config-compact.rasi | cut -d. -f1)
    
    # Map choices to corresponding files
    case $choice in
        1) file="$UserConfigs/ENVariables.lua" ;;
        2) file="$UserConfigs/WindowRules.lua" ;;
        3) file="$UserConfigs/Startup_Apps.lua" ;;
        4) file="$UserConfigs/UserKeybinds.lua" ;;
        5) file="$UserConfigs/Monitors.lua" ;;
        6) file="$UserConfigs/Laptops.lua" ;;
        7) file="$UserConfigs/UserSettings.lua" ;;
        8) file="$UserConfigs/WorkspaceRules.lua" ;;
        9) file="$configs/Settings.lua" ;;
        10) file="$configs/Keybinds.lua" ;;
        *) return ;;  # Do nothing for invalid choices
    esac

    # Open the selected file in the terminal with the text editor
    $tty -e $edit "$file"
}

main
