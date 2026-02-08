# Agent Instructions (Planning Mode)

## Objective

Generate or update `IMPLEMENTATION_PLAN.md` in a structured, phase-based format with:

- Clear status metadata
- Quick reference tables
- Phase sections with paths and checklists
- Verification log entries
- Summary tables and remaining effort

Plan only. Do NOT implement anything.

## Study and Gap Analysis

- Study `specs/*` to learn application requirements.
- Study `IMPLEMENTATION_PLAN.md` (if present; it may be incorrect).
- Study relevant source code in `src/*` (and other app directories if applicable) to compare against specs.

Rules:

- Do NOT assume missing; confirm via code search first.
- Identify where work already exists, partial implementations, TODOs, placeholders, skipped/flaky tests, or inconsistent patterns.
- Keep the plan concise but complete; prefer lists and tables over paragraphs.
- Use `[x]` only when verified in code. Use `[ ]` if missing or unverified.
- Regenerate the plan if it becomes stale, contradictory, or significantly out of sync with code.

## Output Format Requirements

Write `IMPLEMENTATION_PLAN.md` using this structure and level of detail:

Header

- Title: `<Project/System> Implementation Plan (<Scope>)`
- Status line: `**Status:** <summary (e.g., "UI Components Complete (39/39)")>`
- Last Updated date: `YYYY-MM-DD`
- Reference to primary spec(s)

Quick Reference

- A table mapping systems/subsystems to:
  - Specs
  - Crates/modules/packages
  - Web packages
  - Migrations or other artifacts
- Use `✅` to mark items already implemented.

Phased Plan

- Use numbered phases (e.g., Phase 9, Phase 10) aligned to the spec's domain.
- Each phase includes:
  - Goal
  - Status (if applicable)
  - Paths (directories or file patterns)
  - Checklist with `[x]` for verified complete and `[ ]` for missing
  - Definition of Done (tests run, commands/URLs, files touched)
  - Risks/Dependencies (brief)
- Break phases into subsections (e.g., 9.1, 9.2) with scope-specific paths and item lists.
- Include "Reference pattern" links when there's a canonical directory or file to follow.

Verification Log

- A chronological log of verification steps with dates.
- Each entry includes:
  - What was verified (endpoints, commands, builds, tests, UI routes)
  - Exact commands or URLs used
  - Tests run and results
  - Bug fixes discovered (if any)
  - Files touched (if known from code search)
  - Use format: `YYYY-MM-DD: <command or URL> - <result>`

Summary

- Table of phases with completion status
  - "Remaining effort" line summarizing unfinished sections

Known Existing Work

- Brief section listing confirmed existing implementations to prevent duplicate work

## Stop Condition

After writing/updating `IMPLEMENTATION_PLAN.md`:

- If all gaps are validated and nothing is missing, reply with:
  `<promise>COMPLETE</promise>`
