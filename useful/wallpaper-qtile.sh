#!/bin/bash
tree -laL 2 ~/Pictures
echo
read -p "Select path to picture: " Path;
echo
ls ~/Pictures/$Path
testForNow=$($HOME/Pictures/$Path/*)
echo $testForNow
echo
read -p "Which picture do you wanna select: " PicSelection;
if [[ "${PicSelection,,}" == "$(ls ~/Pictures/$Path | grep $PicSelection)" ]]; then
    xrandr --listmonitors
    echo
    read -p "Choose which monitor to change: " Monitor;
    hardlink="currentImage$Monitor"
    rm -rfv ~/Pictures/currentwp/$hardlink
    ln ~/Pictures/$Path/$PicSelection ~/Pictures/currentwp/$hardlink
else
    echo learn to write correctly
fi
