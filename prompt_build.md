# Agent Instructions (Build Mode)

- Study `specs/*` (including `specs/readme.md` and related specs).
- Study `IMPLEMENTATION_PLAN.md` and pick the single most important task.
- Implement the task
- Validate the implementation
- Update the plan
- Commit the changes
- Stop after the commit

## Stop Condition

- After completing the selected task, stop. Do NOT start another task in the same run.
- If ALL stories are complete and passing, reply with:
  <promise>COMPLETE</promise>

## IMPORTANT

- Before changes, search the codebase. Do NOT assume functionality is missing.
- Implement ONLY one task. Stop after committing.
- Update `IMPLEMENTATION_PLAN.md` when the task is done.
- Use the verification log format: `YYYY-MM-DD: <command or URL> - <result>`.
- Keep the `Manual Deployment Tasks` section in the plan and use `None` when there are no tasks.
- You may implement missing functionality if required, but study relevant `specs/*` first.
- You may add temporary logging as needed and remove if no longer needed.
