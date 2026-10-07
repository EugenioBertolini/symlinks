#!/bin/sh

class=$(playerctl metadata --player=spotify --format '{{lc(status)}}')
icon=""

if [[ $class == "playing" ]]; then
  info=$(playerctl metadata --player=spotify --format '{{artist}} - {{title}}')
  if [[ ${#info} -gt 25 ]]; then
    info=$(echo $info | cut -c1-25)"..."
  fi
  text=$info" "$icon
elif [[ $class == "paused" ]]; then
  text=$icon
elif [[ $class == "stopped" ]]; then
  text=""
fi

echo -e "{\"text\":\""$text"\", \"class\":\""$class"\"}"
