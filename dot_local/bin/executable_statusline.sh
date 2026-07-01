#!/usr/bin/env bash
# Unified statusLine script for Claude Code and Antigravity CLI
# Usage: statusline.sh <claude|antigravity>

tool="${1:-claude}"
input=$(cat)

# Extract fields based on the selected tool to minimize TUI rendering latency
if [ "$tool" = "antigravity" ]; then
    {
        read -r cwd
        read -r model
        read -r effort
        read -r ctx
        read -r five_h
        read -r seven_d
    } <<< "$(echo "$input" | jq -r '
      (.cwd // .workspace.current_dir // ""),
      (.model.display_name // ""),
      (.effort.level // ""),
      (.context_window.used_percentage // 0),
      (.quota | to_entries | map(select(.key | contains("5h"))) | map(.value.remaining_fraction) | min | if . != null then (1 - .) * 100 else "" end),
      (.quota | to_entries | map(select(.key | contains("weekly") or contains("7d") or contains("seven"))) | map(.value.remaining_fraction) | min | if . != null then (1 - .) * 100 else "" end)
    ')"
else # default to claude
    {
        read -r cwd
        read -r model
        read -r effort
        read -r ctx
        read -r five_h
        read -r seven_d
    } <<< "$(echo "$input" | jq -r '
      (.cwd // .workspace.current_dir // ""),
      (.model.display_name // ""),
      (.effort.level // ""),
      (.context_window.used_percentage // 0),
      (.rate_limits.five_hour.used_percentage // ""),
      (.rate_limits.seven_day.used_percentage // "")
    ')"
fi

# --- ANSI colors ---
R=$(printf '\033[0m')
DIM=$(printf '\033[38;2;134;134;134m')
CYN=$(printf '\033[36m')
GRN=$(printf '\033[32m')
YLW=$(printf '\033[33m')
RED=$(printf '\033[31m')

# --- render_bar <pct> → 15-char block string (no color) ---
render_bar() {
    local pct; pct=$(printf '%.0f' "${1:-0}")
    local total=15
    local filled=$(( pct * total / 100 ))
    [ "$filled" -gt "$total" ] && filled=$total
    [ "$filled" -lt 0 ]       && filled=0
    local empty=$(( total - filled ))
    local bar=""
    [ "$filled" -gt 0 ] && { printf -v _f "%${filled}s"; bar="${_f// /█}"; }
    [ "$empty"  -gt 0 ] && { printf -v _e "%${empty}s";  bar="${bar}${_e// /░}"; }
    printf '%s' "$bar"
}

# --- bar_color <pct> → ANSI green/yellow/red ---
bar_color() {
    local pct; pct=$(printf '%.0f' "${1:-0}")
    if   [ "$pct" -ge 90 ]; then printf '%s' "$RED"
    elif [ "$pct" -ge 70 ]; then printf '%s' "$YLW"
    else printf '%s' "$GRN"; fi
}

# ── Line 1: 📂 path │ 🌿 branch +N -N ─────────────────────────────────────
if [[ "$cwd" == "$HOME"* ]]; then
    disp="~${cwd#$HOME}"
else
    disp="$cwd"
fi

branch=$(GIT_OPTIONAL_LOCKS=0 git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null || true)

git_part=""
if [ -n "$branch" ]; then
    diff_unstaged=$(GIT_OPTIONAL_LOCKS=0 git -C "$cwd" diff --numstat 2>/dev/null)
    diff_staged=$(GIT_OPTIONAL_LOCKS=0 git -C "$cwd" diff --cached --numstat 2>/dev/null)
    added=$(printf '%s\n%s\n' "$diff_unstaged" "$diff_staged" \
            | awk '$1~/^[0-9]+$/{a+=$1} END{print a+0}')
    removed=$(printf '%s\n%s\n' "$diff_unstaged" "$diff_staged" \
              | awk '$2~/^[0-9]+$/{r+=$2} END{print r+0}')

    diff_str=""
    [ "${added:-0}"   -gt 0 ] && diff_str="${diff_str} ${GRN}+${added}${R}"
    [ "${removed:-0}" -gt 0 ] && diff_str="${diff_str} ${RED}-${removed}${R}"

    git_part=" ${DIM}│${R} 🌿 ${GRN}${branch}${R}${diff_str}"
fi

line1="📂 ${CYN}${disp}${R}${git_part}"

# ── Line 2: 🧠 ctx_bar% │ ✨/💪 model (effort) ──────────────────────────────
ctx_int=$(printf '%.0f' "${ctx:-0}")
ctx_col=$(bar_color "$ctx_int")
ctx_bar=$(render_bar "$ctx_int")

effort_str=""
[ -n "$effort" ] && effort_str=" (${effort})"

# Use appropriate icon depending on the tool
if [ "$tool" = "antigravity" ]; then
    model_icon="✨"
else
    model_icon="💪"
fi

line2="🧠 ${ctx_col}${ctx_bar}${R} ${ctx_int}%"
[ -n "$model" ] && line2="${line2} ${DIM}│${R} ${model_icon} ${YLW}${model}${effort_str}${R}"

# ── Line 3: 🕐 5h_bar% │ 📅 7d_bar%  (absent if no rate_limits/quota data) ─
line3=""
if [ -n "$five_h" ] || [ -n "$seven_d" ]; then
    five_int=$(printf '%.0f' "${five_h:-0}")
    five_col=$(bar_color "$five_int")
    five_bar=$(render_bar "$five_int")

    seven_int=$(printf '%.0f' "${seven_d:-0}")
    seven_col=$(bar_color "$seven_int")
    seven_bar=$(render_bar "$seven_int")

    line3="🕐 ${five_col}${five_bar}${R} ${five_int}% ${DIM}│${R} 📅 ${seven_col}${seven_bar}${R} ${seven_int}%"
fi

# ── Output ──────────────────────────────────────────────────────────────────
printf '%s\n' "$line1"
printf '%s\n' "$line2"
[ -n "$line3" ] && printf '%s\n' "$line3"
exit 0
