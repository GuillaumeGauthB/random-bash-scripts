#
#		Script that creates two audio sinks: one that is null and another that is a combination of your chosen sink and the null one
#
#		Makes streaming easier, stream the combination, put the null sink on sounds you want the viewers to hear but not you and put
#		your original sink the sounds you want only you to hear  
#

pactl list sinks short
read -p "Input the name of the audio sink you are using: " sinkInUse
pactl load-module module-null-sink sink_name=Null
pactl load-module module-combine-sink sink_name=Combined slaves=Null,$sinkInUse



