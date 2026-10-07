#!/usr/bin/env bash
# Claude Code context / usage for a waybar custom module (data cached by ~/.claude/tmux-statusline.sh).
# Usage: claude-status.sh ctx|5h|7d
# ctx = most recently updated live Claude session; 5h / 7d = account rate limits.
# Emits JSON with class low / medium / high (>=50 / >=80) or "none" when there is no data.
dir="${XDG_CACHE_HOME:-$HOME/.cache}/claude-tmux"
what="$1"
now=$(date +%s)
pct=""

case "$what" in
  ctx)
    for f in $(ls -t "$dir"/pane-*.json 2>/dev/null); do
      pid=$(jq -r '.pid // empty' "$f" 2>/dev/null)
      if [ -n "$pid" ] && [ "$(cat "/proc/$pid/comm" 2>/dev/null)" = claude ]; then
        pct=$(jq -r '.ctx // empty' "$f" 2>/dev/null)
        break
      fi
    done
    icon=$'\U000f09d1' ;;  # nf-md-brain
  5h|7d)
    key=five_hour; icon=$'\U000f051f'  # nf-md-timer_sand
    [ "$what" = 7d ] && { key=seven_day; icon=$'\U000f00ed'; }  # nf-md-calendar
    # a window whose reset time has passed is back to 0%
    [ -r "$dir/usage.json" ] && pct=$(jq -r --arg k "$key" --argjson now "$now" '
      .[$k] | if . == null then empty elif .resets_at != null and .resets_at < $now then 0 else .used_percentage // empty end' \
      "$dir/usage.json" 2>/dev/null) ;;
  *) exit 1 ;;
esac

if [ -z "$pct" ]; then
  printf '{"text":"%s --","class":"none","tooltip":false}\n' "$icon"
  exit 0
fi
pct=$(printf '%.0f' "$pct")
class=low
[ "$pct" -ge 50 ] && class=medium
[ "$pct" -ge 80 ] && class=high
printf '{"text":"%s %s%%","class":"%s","tooltip":false}\n' "$icon" "$pct" "$class"
