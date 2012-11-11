#!/bin/sh

layout=`setxkbmap -query | grep layout | cut -d' ' -f 6`

if [ "$layout" = "us" ]; then
    setxkbmap fr
elif [ "$layout" = "fr" ]; then
    setxkbmap us
fi
