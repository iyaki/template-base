#!/bin/bash
# Usage: ./ralph.sh [mode] [scope]

set -e

# Parse arguments
MAX_ITERATIONS=50

MODE=${1:-build}

# Validate MODE
if [[ "$MODE" != "build" && "$MODE" != "plan" ]]
then
	echo "Error: Invalid mode '$MODE'. Must be 'build' or 'plan'."
	exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROMPT_FILE="$SCRIPT_DIR/../prompt_${MODE}.md"

if [ "$MODE" = "build" ]
then
	PROMPT="$(cat "$PROMPT_FILE")"
else
	SCOPE="$2"
	if [[ -z "$SCOPE" ]]
	then
		echo "Error: Scope must be provided in plan mode."
		exit 1
	fi
	PROMPT="Define the implementation plan for: $SCOPE. These are the details to consider: $(cat "$PROMPT_FILE")"
fi


echo "Starting Loop - Max iterations: $MAX_ITERATIONS"

for i in $(seq 1 $MAX_ITERATIONS); do
	echo ""
	echo "==============================================================="
	echo " Iteration $i of $MAX_ITERATIONS"
	echo "==============================================================="

	OUTPUT=$(OPENCODE_EXPERIMENTAL_PLAN_MODE=0 opencode run "$PROMPT" 2>&1 | tee /dev/stderr) || true

	# Check for completion signal
	if echo "$OUTPUT" | grep -q "<promise>COMPLETE</promise>"; then
		echo ""
		echo "All tasks completed!"
		echo "Completed at iteration $i of $MAX_ITERATIONS"
		exit 0
	fi

	echo "Iteration $i complete. Continuing..."
done

echo ""
echo "Reached max iterations ($MAX_ITERATIONS) without completing all tasks."
exit 1
