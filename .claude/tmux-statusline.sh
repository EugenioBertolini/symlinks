#!/usr/bin/env bash
# Claude Code statusLine command: caches session context + account usage for tmux.
# Reads the statusLine JSON on stdin and writes to ~/.cache/claude-tmux/:
#   pane-<id>.json  context usage of the Claude session running in this tmux pane
#   usage.json      account rate limits (5h / 7d), shared by all sessions
# Prints nothing, so the Claude Code status line itself stays empty.
dir="${XDG_CACHE_HOME:-$HOME/.cache}/claude-tmux"
mkdir -p "$dir"
input=$(cat)

# Find the claude process we are running under (tmux side uses it to drop dead sessions).
pid=$PPID
p=$PPID
for _ in 1 2 3 4 5 6; do
  [ "$p" -gt 1 ] 2>/dev/null || break
  if [ "$(cat "/proc/$p/comm" 2>/dev/null)" = claude ]; then pid=$p; break; fi
  p=$(awk '{print $4}' "/proc/$p/stat" 2>/dev/null)
done

write() { # write <file> <jq filter>
  local out
  out=$(jq -c "$2" <<<"$input" 2>/dev/null) || return
  [ -n "$out" ] && printf '%s' "$out" > "$1.$$" && mv "$1.$$" "$1"
}

if [ -n "$TMUX_PANE" ]; then
  write "$dir/pane-${TMUX_PANE#%}.json" \
    "{pid: $pid, session: .session_id, ctx: .context_window.used_percentage, size: .context_window.context_window_size}"
fi
write "$dir/usage.json" \
  'select(.rate_limits != null) | .rate_limits | {five_hour: .five_hour, seven_day: .seven_day, ts: now|floor}'
exit 0
