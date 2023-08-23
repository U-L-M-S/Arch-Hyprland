#!/bin/bash

LEFT_DIR=$HOME/Mega/wallpapers/vertical/
RIGHT_DIR=$HOME/Mega/wallpapers/horizontal/

LEFT_PICS=($(find "${LEFT_DIR}" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" \)))
LEFT_RANDOM_PIC=${LEFT_PICS[$RANDOM % ${#LEFT_PICS[@]}]}

RIGHT_PICS=($(find "${RIGHT_DIR}" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" \)))
RIGHT_RANDOM_PIC=${RIGHT_PICS[$RANDOM % ${#RIGHT_PICS[@]}]}

change_swaybg() {
	pkill swww
	pkill swaybg
	swaybg -m fill -i "${LEFT_RANDOM_PIC}" : "${RIGHT_RANDOM_PIC}"
}

change_swww() {
	pkill swaybg
	swww query || swww init
	swww img -o HDMI-A-1 "${LEFT_RANDOM_PIC}" --transition-fps 30 --transition-type any --transition-duration 6 --filter Nearest &&
		swww img -o DP-1 "${RIGHT_RANDOM_PIC}" --transition-fps 30 --transition-type any --transition-duration 6 --filter Nearest
	# swww img -o HDMI-A-1 --no-resize "${LEFT_RANDOM_PIC}" --transition-fps 30 --transition-type any --transition-duration 6 --filter Nearest &&
	# swww img -o DP-1 --no-resize "${RIGHT_RANDOM_PIC}" --transition-fps 30 --transition-type any --transition-duration 6 --filter Nearest
}

change_current() {
	if pidof swaybg >/dev/null; then
		change_swaybg
	else
		change_swww
	fi
}

switch() {
	if pidof swaybg >/dev/null; then
		change_swww
	else
		change_swaybg
	fi
}

change_current
