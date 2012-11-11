#!/bin/sh

layout=`setxkbmap -query | tail -1 | grep layout | cut -d' ' -f 6`

echo $layout
