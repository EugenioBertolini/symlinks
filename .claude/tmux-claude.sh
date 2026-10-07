#!/usr/bin/env bash
# tmux status-right segment: Claude Code context (active pane) + 5h / 7d usage.
# Usage: #(~/.claude/tmux-claude.sh #{pane_id})
# Colours follow the tmux-cpu convention: low / medium / high by percentage.
# Override with: set -g @claude_medium_thresh 50 / @claude_high_thresh 80
#                set -g @claude_{low,medium,high}_fg_color "#[fg=...]"
pane="${1#%}"
dir="${XDG_CACHE_HOME:-$HOME/.cache}/claude-tmux"
now=$(date +%s)

opt() { local v; v=$(tmux show-option -gqv "$1" 2>/dev/null); echo "${v:-$2}"; }
med=$(opt @claude_medium_thresh 50)
high=$(opt @claude_high_thresh 80)
low_c=$(opt @claude_low_fg_color "#[fg=white]")
med_c=$(opt @claude_medium_fg_color "#[fg=yellow]")
high_c=$(opt @claude_high_fg_color "#[fg=red]")
sep="#[fg=brightblack]| "

color() { # color <pct>
  awk -v p="$1" -v m="$med" -v h="$high" -v l="$low_c" -v M="$med_c" -v H="$high_c" \
    'BEGIN { print (p >= h ? H : p >= m ? M : l) }'
}
seg() { # seg <icon-colour> <icon> <pct|"">
  local pct=$3
  if [ -z "$pct" ]; then
    printf '#[fg=%s]%s #[fg=brightblack]--' "$1" "$2"
  else
    printf '#[fg=%s]%s %s%.0f%%' "$1" "$2" "$(color "$pct")" "$pct"
  fi
}

# Context of the Claude session in the active pane (empty if none / process gone)
ctx=""
f="$dir/pane-$pane.json"
if [ -r "$f" ]; then
  pid=$(jq -r '.pid // empty' "$f" 2>/dev/null)
  if [ -n "$pid" ] && [ "$(cat "/proc/$pid/comm" 2>/dev/null)" = claude ]; then
    ctx=$(jq -r '.ctx // empty' "$f" 2>/dev/null)
  fi
fi

# Account usage; a window whose reset time has passed is back to 0%
h5="" d7=""
if [ -r "$dir/usage.json" ]; then
  read -r h5 d7 < <(jq -r --argjson now "$now" '
    def pct: if . == null then "-" elif .resets_at != null and .resets_at < $now then "0" else .used_percentage // "-" end;
    "\(.five_hour | pct) \(.seven_day | pct)"' "$dir/usage.json" 2>/dev/null)
  [ "$h5" = "-" ] && h5=""
  [ "$d7" = "-" ] && d7=""
fi

ic_ctx=$'\U000f09d1'  # nf-md-brain
ic_5h=$'\U000f051f'   # nf-md-timer_sand
ic_7d=$'\U000f00ed'   # nf-md-calendar

printf '%s %s%s %s%s ' \
  "$(seg green "$ic_ctx" "$ctx")" "$sep" \
  "$(seg yellow "$ic_5h" "$h5")" "$sep" \
  "$(seg cyan "$ic_7d" "$d7")"
