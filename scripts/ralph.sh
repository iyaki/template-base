#!/usr/bin/env bash

# agentic-loop.sh wrapper

# Bash strict mode - https://olivergondza.github.io/2019/10/01/bash-strict-mode.html
set -euo pipefail
# shellcheck disable=SC2154
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$SCRIPT_DIR/.."

branch_name="$(git symbolic-ref HEAD 2>/dev/null)"
branch_name=${branch_name##refs/heads/}

printf "\n --------------------- %s ---------------------\n" "$(date)" >> "$PROJECT_ROOT/logs/ralph_$branch_name.log"

"$SCRIPT_DIR/agentic-loop.sh" $@ | tee -a "$PROJECT_ROOT/logs/ralph_$branch_name.log"
