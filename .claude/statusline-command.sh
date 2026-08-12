#!/usr/bin/env bash
# Claude Code status line — two-line worktree dashboard
# Line 1: model/effort, context %, session cost (session-level facts)
# Line 2: worktree, branch, lines changed (where-am-I facts)
# Receives JSON on stdin from Claude Code.

input=$(cat)

# Debug: dump raw JSON to file so we can see what fields are available
echo "$input" > /tmp/claude-statusline-debug.json

cwd=$(echo "$input" | jq -r '.cwd // empty')

# Abbreviate home directory (tilde must be quoted or bash re-expands it to $HOME)
short_cwd="${cwd/#$HOME/'~'}"

# Get branch and worktree info via git
git_branch=""
is_linked_worktree=false

if [ -n "$cwd" ] && [ -d "$cwd" ]; then
    git_branch=$(git -C "$cwd" -c gc.auto=0 branch --show-current 2>/dev/null)
    # A linked worktree has .git as a file (not a directory)
    if [ -f "$cwd/.git" ]; then
        is_linked_worktree=true
    else
        git_dir=$(git -C "$cwd" -c gc.auto=0 rev-parse --git-dir 2>/dev/null)
        if [ -n "$git_dir" ] && echo "$git_dir" | grep -q '/worktrees/'; then
            is_linked_worktree=true
        fi
    fi
fi

truncate() {
    local s="$1" max="$2"
    if [ "${#s}" -gt "$max" ]; then
        printf '%s...' "${s:0:$((max - 3))}"
    else
        printf '%s' "$s"
    fi
}

# ---- Line 1: model, effort, context %, cost ----

model_name=$(echo "$input" | jq -r '.model.display_name // empty')
effort=$(echo "$input" | jq -r '.effort.level // empty')
ctx_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
cost_usd=$(echo "$input" | jq -r '.cost.total_cost_usd // empty')

line1_parts=()

if [ -n "$model_name" ]; then
    if [ -n "$effort" ]; then
        line1_parts+=("🤖 ${model_name}·${effort}")
    else
        line1_parts+=("🤖 ${model_name}")
    fi
fi

if [ -n "$ctx_pct" ]; then
    line1_parts+=("🧠 ${ctx_pct}%")
fi

if [ -n "$cost_usd" ]; then
    cost_fmt=$(awk -v n="$cost_usd" 'BEGIN{printf "%.2f", n}')
    line1_parts+=("💰 \$${cost_fmt}")
fi

line1=""
for i in "${!line1_parts[@]}"; do
    if [ "$i" -eq 0 ]; then
        line1="${line1_parts[$i]}"
    else
        line1="$line1  ${line1_parts[$i]}"
    fi
done

# ---- Line 2: worktree, branch, lines changed (fallback to cwd if no git) ----

lines_added=$(echo "$input" | jq -r '.cost.total_lines_added // 0')
lines_removed=$(echo "$input" | jq -r '.cost.total_lines_removed // 0')

line2_parts=()

if [ "$is_linked_worktree" = true ]; then
    line2_parts+=("🌳 $(basename "$cwd")")
fi

if [ -n "$git_branch" ]; then
    line2_parts+=("🌿 $(truncate "$git_branch" 40)")
fi

if [ "$lines_added" != "0" ] || [ "$lines_removed" != "0" ]; then
    line2_parts+=("+${lines_added}/-${lines_removed}")
fi

line2_parts+=("📁 $short_cwd")

line2=""
for i in "${!line2_parts[@]}"; do
    if [ "$i" -eq 0 ]; then
        line2="${line2_parts[$i]}"
    else
        line2="$line2  ${line2_parts[$i]}"
    fi
done

if [ -n "$line1" ] && [ -n "$line2" ]; then
    printf "%s\n%s" "$line1" "$line2"
elif [ -n "$line1" ]; then
    printf "%s" "$line1"
else
    printf "%s" "$line2"
fi
