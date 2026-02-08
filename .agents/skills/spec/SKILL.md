---
name: spec
description: Generate comprehensive technical specifications with explicit scope, architecture, entities, APIs, SDKs, data models, and security constraints.
user-invocable: true
---

# Spec Authoring

## Purpose

Produce detailed, engineering-grade specifications similar in depth and structure to a full platform spec. The output must be explicit, testable, and implementation-ready without needing back-and-forth clarification.

## Core Principles

1. State intent clearly and early.
2. Define scope and non-scope to avoid ambiguity.
3. Make every requirement verifiable.
4. Prefer concrete examples over vague descriptions.
5. Use consistent naming and types across the document.
6. Include failure modes and edge cases.
7. Avoid assumptions; write them down.

## Required Structure

Follow this structure exactly, but customize content to the project.

**Header**
- Status, Version, Last Updated

**Overview**
- Purpose
- Goals
- Non-Goals

**Architecture**
- Module/package layout (tree format)
- Component diagram (ASCII)
- Data flow summary

**Core Entities**
- Define primary entities with types and fields
- Include code snippets in the target language
- Explain relationships between entities

**Key Workflows**
- Step-by-step flows for critical operations
- Include both happy path and error/merge cases

**APIs**
- Base paths
- Endpoints (method, path, purpose)
- Auth requirements
- Request/response payloads

**Client SDK Design**
- Initialization patterns
- Example usage
- Behavior expectations (batching, retry, persistence)

**Data Model**
- Schema definitions (SQL or equivalent)
- Indexing and constraints

**Configuration**
- Environment variables and defaults

**Permissions**
- Roles and access matrix

**Security Considerations**
- Sensitive data handling
- Validation rules
- Key management

**Dependencies**
- Library list with rationale where needed

**Appendices**
- Compatibility notes
- Future considerations

## Writing Rules

- Use precise, plain language.
- Every section must include at least one concrete example when possible.
- Prefer tables for enums, options, or matrices.
- Include code blocks with correct syntax highlighting.
- Keep naming consistent across entities, APIs, and SDKs.
- If a behavior depends on policy, state it explicitly.

## Verification Hooks

At the end of the spec, add a short "Verification" section with 3-5 objective checks.
Examples:

- Tests pass for capture + identify flows.
- API returns 401 without key.
- Schema migration applies cleanly on empty DB.

## Output Quality Checklist

Before finalizing, confirm:

- Scope is explicit and non-goals are listed.
- All core entities and relationships are defined.
- Every endpoint has auth and payloads.
- All critical workflows are described step-by-step.
- Security and permissions are not implicit.
- At least one example is given for each major section.

## Related docs

When the new spec is complete, update specs/README.md to include it in the list of available specs.
