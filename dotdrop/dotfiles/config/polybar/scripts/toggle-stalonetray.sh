#!/bin/bash
curr_state=$(xwininfo -name stalonetray | grep 'Map State' | awk '{print $3}')
if [ $curr_state == "IsUnMapped" ]; then
   xdotool windowmap "$(xdotool search --class stalonetray)"
else
   xdotool windowunmap "$(xdotool search --class stalonetray)"
fi
