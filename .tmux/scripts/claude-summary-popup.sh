#!/usr/bin/env bash
# Claude window switcher — lists every window across every session with its
# state (🔴 working / 🟡 waiting-on-you / 🟢 idle), 🔔 attention flag, and
# last-message summary, fuzzy-pick to jump.

state_fmt='#{?#{==:#{@claude_state},working},🔴,#{?#{==:#{@claude_state},waiting},🟡,#{?#{==:#{@claude_state},idle},🟢,·}}}'
rows=$(tmux list-windows -a -F "#{session_name}:#{window_index}	${state_fmt}#{?@claude_bell,🔔,}	#{window_name}	#{@claude_summary}")

selected=$(echo "$rows" | awk -F'\t' '{printf "%-20s %s  %-14s %s\n", $1, $2, $3, $4}' \
    | fzf --header 'Jump to a Claude window  (Enter=switch, Esc=cancel)' --no-preview)

[ -n "$selected" ] || exit 0

target=$(echo "$selected" | awk '{print $1}')
tmux switch-client -t "$target"
