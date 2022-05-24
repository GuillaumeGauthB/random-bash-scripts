#!/bin/bash
# Test script to automatically pull every git folder in a certain location
# Directories that you don't want to pull need a nopull file inside of them, which can be empty

# Input folder
cd "$HOME/git"
for f in *; do
    cd $f
    if [ "$(ls | grep nopull)" == "" ]; then
        git pull
    fi
    cd ..
done