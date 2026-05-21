#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Scripts for volume controls for audio and mic 

iDIR="$HOME/.config/swaync/icons"
sDIR="$HOME/.config/hypr/scripts"

# Get Volume
get_volume() {
    volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '/Volume:/ {print $5}' | sed 's/%//')
    if [[ -z "$volume" || "$volume" -eq 0 ]]; then
        mute=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
        if [[ "$mute" == "yes" ]]; then
            echo "Muted"
        else
            echo "0%"
        fi
    else
        echo "$volume%"
    fi
}

# Get icons
get_icon() {
    current=$(get_volume)
    if [[ "$current" == "Muted" ]]; then
        echo "$iDIR/volume-mute.png"
    elif [[ "${current%\%}" -le 30 ]]; then
        echo "$iDIR/volume-low.png"
    elif [[ "${current%\%}" -le 60 ]]; then
        echo "$iDIR/volume-mid.png"
    else
        echo "$iDIR/volume-high.png"
    fi
}

# Notify
notify_user() {
    if [[ "$(get_volume)" == "Muted" ]]; then
        notify-send -e -h string:x-canonical-private-synchronous:volume_notif -u low -i "$(get_icon)" "Volume: Muted"
    else
        notify-send -e -h int:value:"$(get_volume | sed 's/%//')" -h string:x-canonical-private-synchronous:volume_notif -u low -i "$(get_icon)" "VOLUME: $(get_volume)"
        "$sDIR/Sounds.sh" --volume
    fi
}

# Increase Volume
inc_volume() {
    if [ "$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')" == "yes" ]; then
        toggle_mute
    else
        pactl set-sink-volume @DEFAULT_SINK@ +5% && notify_user
    fi
}

# Decrease Volume
dec_volume() {
    if [ "$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')" == "yes" ]; then
        toggle_mute
    else
        pactl set-sink-volume @DEFAULT_SINK@ -5% && notify_user
    fi
}

# Toggle Mute
toggle_mute() {
	if [ "$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')" == "no" ]; then
		pactl set-sink-mute @DEFAULT_SINK@ 1 && notify-send -e -u low -i "$iDIR/volume-mute.png" "Volume Switched OFF"
	elif [ "$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')" == "yes" ]; then
		pactl set-sink-mute @DEFAULT_SINK@ 0 && notify-send -e -u low -i "$(get_icon)" "VOLUME Switched ON"
	fi
}

# Toggle Mic
toggle_mic() {
	if [ "$(pactl get-source-mute @DEFAULT_SOURCE@ | awk '{print $2}')" == "no" ]; then
		pactl set-source-mute @DEFAULT_SOURCE@ 1 && notify-send -e -u low -i "$iDIR/microphone-mute.png" "Microphone Switched OFF"
	elif [ "$(pactl get-source-mute @DEFAULT_SOURCE@ | awk '{print $2}')" == "yes" ]; then
		pactl set-source-mute @DEFAULT_SOURCE@ 0 && notify-send -e -u low -i "$iDIR/microphone.png" "Microphone Switched ON"
	fi
}
# Get Mic Icon
get_mic_icon() {
    current=$(pactl get-source-volume @DEFAULT_SOURCE@ | awk '/Volume:/ {print $5}' | sed 's/%//')
    if [[ -z "$current" || "$current" -eq "0" ]]; then
        echo "$iDIR/microphone-mute.png"
    else
        echo "$iDIR/microphone.png"
    fi
}

# Get Microphone Volume
get_mic_volume() {
    volume=$(pactl get-source-volume @DEFAULT_SOURCE@ | awk '/Volume:/ {print $5}' | sed 's/%//')
    if [[ -z "$volume" || "$volume" -eq "0" ]]; then
        echo "Muted"
    else
        echo "$volume%"
    fi
}

# Notify for Microphone
notify_mic_user() {
    volume=$(get_mic_volume)
    icon=$(get_mic_icon)
    notify-send -e -h int:value:"$volume" -h "string:x-canonical-private-synchronous:volume_notif" -u low -i "$icon" "Mic-Level: $volume"
}

# Increase MIC Volume
inc_mic_volume() {
    if [ "$(pactl get-source-mute @DEFAULT_SOURCE@ | awk '{print $2}')" == "yes" ]; then
        toggle_mic
    else
        pactl set-source-volume @DEFAULT_SOURCE@ +5% && notify_mic_user
    fi
}

# Decrease MIC Volume
dec_mic_volume() {
    if [ "$(pactl get-source-mute @DEFAULT_SOURCE@ | awk '{print $2}')" == "yes" ]; then
        toggle_mic
    else
        pactl set-source-volume @DEFAULT_SOURCE@ -5% && notify_mic_user
    fi
}

# Execute accordingly
if [[ "$1" == "--get" ]]; then
	get_volume
elif [[ "$1" == "--inc" ]]; then
	inc_volume
elif [[ "$1" == "--dec" ]]; then
	dec_volume
elif [[ "$1" == "--toggle" ]]; then
	toggle_mute
elif [[ "$1" == "--toggle-mic" ]]; then
	toggle_mic
elif [[ "$1" == "--get-icon" ]]; then
	get_icon
elif [[ "$1" == "--get-mic-icon" ]]; then
	get_mic_icon
elif [[ "$1" == "--mic-inc" ]]; then
	inc_mic_volume
elif [[ "$1" == "--mic-dec" ]]; then
	dec_mic_volume
else
	get_volume
fi
