#!/usr/bin/env bash
# Claude window switcher — lists every window across every session with its
# state (🔴 working / 🟡 waiting-on-you / 🟢 idle) and last-message summary,
# fuzzy-pick to jump.
#
# State/summary are read from plain files under /tmp/claude-tmux-state,
# written by Claude Code hooks — NOT from tmux user options. Writing a tmux
# option forces a status-bar redraw every time, which collides with Claude
# Code's own spinner line-overwrites and produces duplicated output. Files
# carry the same info with zero tmux redraws; this popup is the only place
# that ever reads them, on demand.

state_dir=/tmp/claude-tmux-state
mkdir -p "$state_dir"

icon_for() {
    case "$1" in
        working) printf '🔴' ;;
        waiting) printf '🟡' ;;
        idle)    printf '🟢' ;;
        *)       printf '·' ;;
    esac
}

rows=""
while IFS=$'\t' read -r target pane_id winname bell; do
    state=$(cat "$state_dir/${pane_id}.state" 2>/dev/null)
    summary=$(cat "$state_dir/${pane_id}.summary" 2>/dev/null)
    icon=$(icon_for "$state")
    rows+=$(printf '%-20s %s%s  %-14s %s\n' "$target" "$icon" "$bell" "$winname" "$summary")
    rows+=$'\n'
done < <(tmux list-windows -a -F '#{session_name}:#{window_index}	#{pane_id}	#{window_name}	#{?@claude_bell,🔔,}')

selected=$(printf '%s' "$rows" | fzf --header 'Jump to a Claude window  (Enter=switch, Esc=cancel)' --no-preview)

[ -n "$selected" ] || exit 0

target=$(echo "$selected" | awk '{print $1}')
tmux switch-client -t "$target"

# prune state/summary files for panes that no longer exist
live_panes=$(tmux list-panes -a -F '#{pane_id}' 2>/dev/null)
for f in "$state_dir"/*; do
    [ -e "$f" ] || continue
    base=$(basename "$f")
    pane="${base%.*}"
    echo "$live_panes" | grep -qx "$pane" || rm -f "$f"
done
