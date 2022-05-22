#!/bin/bash
#
#		Script that creates two audio sinks: one that is null and another that is a combination of your chosen sink and the null one
#
#		Useful when streaming. 
#   
#   Null sink is used for sounds you want the audience to hear but not you
#   Original sink is used for sounds you want to hear but not the audience
#   Mix is used for sounds you want everyone to hear
# 
#   Some changes need to be made to your OBS sound sinks for this to work

# Function to make things more readable for the user
reading () {
  echo
  echo "__________________________________"
  echo
}

# Function to manually choose which sink to use
manualChoice () {
  echo "Listing sinks :"
  reading
  pactl list sinks short
  reading
  read -p "Input the name of the audio sink you are using: " sinkInUse
  if [[ "${sinkInUse,,}" == "$(pactl list sinks short | grep ${sinkInUse,,})" ]]; then
    pactl load-module module-null-sink sink_name=Null
    pactl load-module module-combine-sink sink_name=Combined slaves=Null,$sinkInUse
  else
    echo "Didn't write it correctly ya dummy"
  fi
}

# Ask user whether or not they want the merge to be automatic
read -p "Make sink automatically? (Y/n)": theChoice

# if the user answers with y or answers with nothing, then do it automatically
if [[ "$theChoice" == "" || "${theChoice,,}" == "y" ]]; then
  
  # Print all sinks to allSinks, then sort allSinks to only get the sinks that are running
  allSinks="$(pactl list sinks short)"
  running=$(awk -F " " '/RUNNING/ {print $2}' <<< "$allSinks")

  # If there is only one running sink, make the merge automatically
  if [[  $(echo "$running" | wc -l) == 1  && $(echo "$running") != ""  ]]; then
  
    pactl load-module module-null-sink sink_name=Null
    pactl load-module module-combine-sink sink_name=Combined slaves=Null,$running
  
  else
    # otherwise, make the user choose manually
    echo "Cannot automatically make the sink"
    reading
    manualChoice
  fi

elif [[ "${theChoice,,}" == "n" ]]; then
  # if the user says no, make the user choose manually
  echo "Making manual merge"
  reading
  manualChoice
else
  # otherwise, error
  echo "Answer does not make sense"
  echo "Exitting..."
fi