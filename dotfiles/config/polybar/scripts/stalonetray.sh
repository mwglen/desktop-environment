#!/bin/bash
Resolution=$(xrandr --current | grep '*' | uniq | awk '{print $1}')
Xaxis=$(echo $Resolution | cut -d 'x' -f1)
Yaxis=$(echo $Resolution | cut -d 'x' -f2)
stalonetray --grow-gravity SE --geometry 1x1+$((Xaxis-65))+$((Yaxis-130)) --icon-size 32 --icon-gravity SE --window-strut none --slot-size 50 -bg "#161616" &
sleep 1
xdotool windowunmap "$(xdotool search --class stalonetray)"
