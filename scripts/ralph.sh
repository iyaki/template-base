#!/bin/bash
# Usage: ./ralph.sh [mode] [max_iterations]

set -e

# Parse arguments
MAX_ITERATIONS=${2:-25}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$SCRIPT_DIR/.."
MODE=${1:-build}
PROMPT_FILE="$SCRIPT_DIR/../prompt_${MODE}.md"

echo "Starting Loop - Max iterations: $MAX_ITERATIONS"

for i in $(seq 1 $MAX_ITERATIONS); do
  echo ""
  echo "==============================================================="
  echo " Iteration $i of $MAX_ITERATIONS"
  echo "==============================================================="

  OUTPUT=$(cat "$PROMPT_FILE" | opencode run 2>&1 | tee /dev/stderr) || true

  # Check for completion signal
  if echo "$OUTPUT" | grep -q "<promise>COMPLETE</promise>"; then
    echo ""
    echo "All tasks completed!"
    echo "Completed at iteration $i of $MAX_ITERATIONS"
    exit 0
  fi

  echo "Iteration $i complete. Continuing..."
  sleep 2
done

echo ""
echo "Reached max iterations ($MAX_ITERATIONS) without completing all tasks."
exit 1
