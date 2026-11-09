#!/bin/sh
states=$(nmcli -t -f TYPE,STATE device)
wifi=$(echo "$states" | grep -c '^wifi:connected')
eth=$(echo "$states" | grep -c '^ethernet:connected')

if [ "$wifi" -gt 0 ] && [ "$eth" -gt 0 ]; then
    echo "󰖩 Connected : WiFi + Ethernet"
elif [ "$wifi" -gt 0 ]; then
    echo "󰖩 Connected : WiFi"
elif [ "$eth" -gt 0 ]; then
    echo "󰈀 Connected : Ethernet"
else
    echo "󰖪 Disconnected"
fi
