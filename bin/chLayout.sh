#!/bin/sh

layout=`setxkbmap -query | grep layout | tail -1 | cut -d' ' -f 6`

echo "$layout"
if [ "$layout" = "us" ]; then
    setxkbmap fr
elif [ "$layout" = "fr" ]; then
    setxkbmap us
fi
