#!/bin/sh

pos=`xrandr 2> /dev/null | grep connected | cut -d' ' -f 4`

if [ $pos == "(normal" ]
then
    killall conky
    xrandr -o left
    env DISPLAY=:0.2 conky -c $HOME/.conky/conkyrc_grey > /dev/null 2> /dev/null &
    sleep 4
    env DISPLAY=:0.2 feh --bg-scale $HOME/.config/awesome/themes/wallpaper/planet-earth-1050x1680.jpg
else
    killall conky
    xrandr -o normal
    env DISPLAY=:0.2 conky -c $HOME/.conky/conkyrc_grey > /dev/null 2> /dev/null &
    sleep 4
    env DISPLAY=:0.2 feh --bg-scale $HOME/.config/awesome/themes/wallpaper/planet-earth-1680x1050-wallpaper-4465.jpg
fi
