#!/bin/bash

LEFT_MONITOR_DIR=/home/silcniu/Mega/wallpapers/vertical
RIGHT_MONITOR_DIR=/home/silcniu/Mega/wallpapers/horizontal

change_swaybg() {
	pkill swww
	pkill swaybg
	swaybg -m fill -i "${LEFT_MONITOR_WALLPAPER}"
}

change_swww() {
	pkill swaybg
	swww query || swww init
	SWWW_MONITOR=HDMI-A-1 swww img "${LEFT_MONITOR_WALLPAPER}" --transition-fps 30 --transition-type any --transition-duration 3
	SWWW_MONITOR=DP-1 swww img "${RIGHT_MONITOR_WALLPAPER}" --transition-fps 30 --transition-type any --transition-duration 3
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

# Randomly select wallpapers for left and right monitors
LEFT_WALLPAPERS=("${LEFT_MONITOR_DIR}"/*.jpg "${LEFT_MONITOR_DIR}"/*.jpeg "${LEFT_MONITOR_DIR}"/*.png "${LEFT_MONITOR_DIR}"/*.gif)
RIGHT_WALLPAPERS=("${RIGHT_MONITOR_DIR}"/*.jpg "${RIGHT_MONITOR_DIR}"/*.jpeg "${RIGHT_MONITOR_DIR}"/*.png "${RIGHT_MONITOR_DIR}"/*.gif)

LEFT_MONITOR_WALLPAPER=${LEFT_WALLPAPERS[RANDOM % ${#LEFT_WALLPAPERS[@]}]}
RIGHT_MONITOR_WALLPAPER=${RIGHT_WALLPAPERS[RANDOM % ${#RIGHT_WALLPAPERS[@]}]}

case "$1" in
"swaybg")
	change_swaybg
	;;
"swww")
	change_swww
	;;
"s")
	switch
	;;
*)
	change_current
	;;
esac
