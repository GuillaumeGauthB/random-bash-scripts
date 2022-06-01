#!/bin/sh
xrandr --output DVI-D-0 --mode 1280x1024 --pos 0x518 --rotate normal --output HDMI-0 --primary --mode 1920x1080 --pos 1280x0 --rotate normal --output DP-0 --off --output DP-1 --mode 1920x1080 --pos 3200x0 --rotate normal --output DP-2 --off --output DP-3 --off --output DP-4 --off --output DP-5 --off
# xrandr --output HDMI-0 --primary --output DP-5 --right-of HDMI-0 --output DVI-D-0 --left-of HDMI-0
# xrandr --output HDMI-0 --auto --primary --output DVI-D-0 --auto --left-of HDMI-0 --output DP-5 --auto --right-of HDMI-0
# xrandr --output DVI-D-0 --primary --left-of HDMI-0
# xrandr --output HDMI-0 --primary --output DP-5 --right-of HDMI-0
