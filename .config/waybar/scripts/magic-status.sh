#!/bin/sh
# Reports active/default state for a Hyprland special workspace, as JSON for a waybar custom module.
# Usage: magic-status.sh <special-workspace-name> <default-icon> <active-icon>

name="$1"
default_icon="$2"
active_icon="$3"

active=$(hyprctl monitors -j | jq -r --arg name "special:$name" '[.[] | select(.specialWorkspace.name == $name)] | length')

if [ "$active" -gt 0 ]; then
  echo "{\"text\":\"$active_icon\",\"class\":\"active\",\"tooltip\":\"$name (active)\"}"
else
  echo "{\"text\":\"$default_icon\",\"class\":\"default\",\"tooltip\":\"$name\"}"
fi
