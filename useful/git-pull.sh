#!/bin/bash
# Test script to automatically pull every git folder in a certain location

# Input folder
cd "$HOME/git"
for f in *; do
    cd $f
    if [ "$(ls | grep nopull)" == "" ]; then
        git pull
    fi
    cd ..
done