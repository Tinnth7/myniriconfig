#!/bin/sh
# Wallpaper script: https://github.com/tinnth7/myniriconfig
# File at /home/lituz/.wp.sh to autostart
pgrep -x awww-daemon >/dev/null || awww-daemon &
for i in 1 2 3 4 5 6 7 8 9 10; do
    awww query >/dev/null 2>&1 && break
    sleep 0.5
done
awww img /home/lituz/Desktop/w.jpg
