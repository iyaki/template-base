#!/usr/bin/env bash

# System predefined prompts: build|plan
# Scope param only (and mandatory) for plan prompt, ignored in all other prompts
# Usage: ./ralph.sh [prompt] [scope]

# Bash strict mode - https://olivergondza.github.io/2019/10/01/bash-strict-mode.html
set -euo pipefail
# shellcheck disable=SC2154
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

MAX_ITERATIONS=${RALPH_MAX_ITERATIONS:-50}
# shellcheck disable=SC2034
OPENCODE_EXPERIMENTAL_PLAN_MODE=0 # Disabled because the opencode experimental plan mode causes hangs on non interactive sessions

# Parse arguments
MODE=${1:-build}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$SCRIPT_DIR/.."
PROMPT_FILE="$PROJECT_ROOT/prompt_${MODE}.md"

if [[ ! -f "$PROMPT_FILE" ]]
then
	echo "Error: Prompt file '$PROMPT_FILE' not found."
	exit 1
fi

# Validate MODE
if [[ "$MODE" != "build" && "$MODE" != "plan" ]]
then
	echo ""
	echo "==============================================================="
	echo " CUSTOM PROMPT FILE: $PROMPT_FILEE"
	echo "==============================================================="
	echo ""
	sleep 5
fi

PROMPT="$(cat "$PROMPT_FILE")"
if [ "$MODE" = "plan" ]
then
	SCOPE="$2"
	if [[ -z "$SCOPE" ]]
	then
		echo "Error: Scope must be provided in plan mode."
		exit 1
	fi
	PROMPT="Define the implementation plan for: $SCOPE. These are the details to consider: ${PROMPT}"
fi


echo "Starting Loop - Max iterations: $MAX_ITERATIONS"

for i in $(seq 1 $MAX_ITERATIONS); do
	echo ""
	echo "==============================================================="
	echo " Iteration $i of $MAX_ITERATIONS"
	echo "==============================================================="

	OUTPUT=$(opencode run "$PROMPT" 2>&1 | tee /dev/stderr) || true

	# Check for completion signal
	if echo "$OUTPUT" | grep -q "<promise>COMPLETE</promise>"; then

		echo ""
		echo "All planned tasks completed!"
		echo "Completed at iteration $i of $MAX_ITERATIONS"

		break
	fi

	echo "Iteration $i complete. Continuing..."
done

if [ $i -ge $MAX_ITERATIONS ]; then
	echo ""
	echo "Reached max iterations ($MAX_ITERATIONS) without completing all planned tasks."
	exit 1
fi


# Optional extra steps (Refactors and post validations)
# if [ "$MODE" = "build" ]
# then
# 	until rector-command; do :; done
# 	until styling-command; do :; done

# 	if [ "$(git status -s)" ]
# 	then
# 		git add .
# 		# Pre-commit validations are ignored to avoid blockages in the automated process
# 		git commit -m "Automated refactors" -n
# 	fi

# 	until LINTER_OUTPUT="$(linter-command)"; do
# 		opencode run "Fix the following lint errors: $LINTER_OUTPUT" 2>&1 | tee /dev/stderr || true
# 	done

# 	STATIC_ANALYSIS_ITERATIONS=0
# 	until STATIC_ANALYSIS_OUTPUT="$(static-analysis-command)" || [ $STATIC_ANALYSIS_ITERATIONS -ge 50 ]; do
# 		echo ""
# 		echo "$STATIC_ANALYSIS_OUTPUT"
# 		echo ""

# 		opencode run "Fix the following static analysis findings: $STATIC_ANALYSIS_OUTPUT" || true

# 		STATIC_ANALYSIS_ITERATIONS=$((STATIC_ANALYSIS_ITERATIONS+1))
# 	done

# 	if [ "$(git status -s)" ]
# 	then
# 		git add .
# 		# Pre-commit validations are ignored to avoid blockages in the automated process
# 		git commit -m "Fix Static analysis findings" -n
# 	fi

# 	branch_name="$(git symbolic-ref HEAD 2>/dev/null)"
# 	branch_name=${branch_name##refs/heads/}

# 	git push origin "$branch_name"

# 	opencode run "Using the GitHub CLI (gh), create a draft Pull Request for branch $branch_name. Follow the standard template (.github/pull_request_template.md) and include the tasks documented under 'Manual Deployment Tasks' in the IMPLEMENTATION_PLAN." || true
# fi
