#!/bin/bash
# Test script to automatically pull every git folder in a certain location
# at something like every monday or something
# might have to modify the .xinitrc file at ~

# Input folder
cd "$HOME/git/to-pull"
ls
for f in *; do
    cd $f
    if [ "$(ls | grep nopull)" == "" ]; then
        git pull
    fi
    cd ..
done