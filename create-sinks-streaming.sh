#!bin/bash
#		Script that creates two audio sinks: one that is null and another that is a combination of your chosen sink and the null one
#
#		Makes streaming easier, stream the combination, put the null sink on sounds you want the viewers to hear but not you and put
#		your original sink the sounds you want only you to hear  
#


# check if pulse is on the computer
location="$(ls /opt/bin | grep pulseaudio)"
if [[ "${location,,}" == *"pulseaudio"* ]]; then
    ls 
    pactl list sinks short
    echo ---------------------------------------------
    echo;
    read -p "Input the name of the audio sink you are using: " sinkInUse
    pactl load-module module-null-sink sink_name=Null
    pactl load-module module-combine-sink sink_name=Combined slaves=Null,$sinkInUse
else
    echo You do not have pulseaudio, the script will not work
    echo Download it with sudo pacman -S pulseaudio if on arch or your variant for your distro
fi



