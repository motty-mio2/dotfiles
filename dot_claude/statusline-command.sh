#!/usr/bin/env bash
# Claude Code statusLine command
# Minimal: current directory  git branch  model name

input=$(cat)

# --- Data extraction ---
cwd=$(echo "$input" | jq -r '.cwd // .workspace.current_dir // ""')
model=$(echo "$input" | jq -r '.model.display_name // ""')
branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null || true)

# --- Colors (foreground only, no background) ---
reset="\033[0m"
fg_dim="\033[38;2;134;134;134m"   # separator / dim text
fg_cyan="\033[36m"
fg_green="\033[32m"

# --- Directory: show repo-relative path when in git, else full cwd ---
short_dir="$cwd"
if [ -n "$branch" ]; then
    git_root=$(git -C "$cwd" --no-optional-locks rev-parse --show-toplevel 2>/dev/null || true)
    if [ -n "$git_root" ]; then
        rel="${cwd#"$git_root"}"
        repo_base=$(basename "$git_root")
        short_dir="${repo_base}${rel}"
    fi
fi

# --- Assemble line ---
parts="${short_dir}"

if [ -n "$branch" ]; then
    parts="${parts}${fg_dim} | ${fg_cyan}${branch}${reset}"
fi

if [ -n "$model" ]; then
    parts="${parts}${fg_dim} | ${fg_green}${model}${reset}"
fi

printf "${parts}${reset}"
