# AGENTS.md

This document is for all agentic coding agents (including OpenCode, Copilot, and future systems) operating within this repository. Its purpose is to maximize agent productivity, prevent ambiguity, and ensure consistently high-quality code and configuration in this template-based, devcontainerized environment.

## Table of Contents
1. [Project Philosophy & Agent Mission](#project-philosophy--agent-mission)
2. [Environment Initialization & Setup](#environment-initialization--setup)
3. [Build, Lint, and Test Commands](#build-lint-and-test-commands)
4. [Code Style Guidelines](#code-style-guidelines)
    - [Imports & Module Organization](#imports--module-organization)
    - [Formatting](#formatting)
    - [Type Annotations](#type-annotations)
    - [Naming Conventions](#naming-conventions)
    - [Error Handling](#error-handling)
    - [Documentation](#documentation)
5. [Cursor and Copilot Instructions](#cursor-and-copilot-instructions)
6. [Adding New Languages or Tools](#adding-new-languages-or-tools)
7. [AI Agent Best Practice Checklist](#ai-agent-best-practice-checklist)
8. [Meta: Maintaining This File](#meta-maintaining-this-file)

---

## 1. Project Philosophy & Agent Mission
- This repository is a **template**: It is expected, encouraged, and required that it be **adapted, not extended**.
- The goal: Define and automate best-practices for initializing a devcontainer-based project with agentic tooling (OpenCode AI, Copilot, etc.).
- When this template is cloned and customized **add specific language/tooling rules**—agents should document any non-obvious configuration or workflows.

## 2. Environment Initialization & Setup
- Run `./setup.sh` **once after cloning**. This script:
    - Deletes template notes and self-cleans setup artifacts
    - Re-initializes the repository as a fresh git repo
- Customize `.devcontainer/devcontainer.json` to add tools/extensions/features for your project
- Update `opencode.json` to reflect which OpenCode features/MCPs should be active.
    - E.g., enable web automation, documentation search, GitHub API tools, etc.
- Install further language or framework tooling as needed (add `package.json`, `requirements.txt`, etc. per your stack)

## 3. Build, Lint, and Test Commands
*This is a template: no universal commands are present. As soon as any language/tooling is added, AGENTS **must edit this section with precise commands** for build/lint/test.*

- **Initialization**: `./setup.sh` (one time only; see above)
- **Build**: _Add project-specific instructions here (e.g., `npm run build`, `make`, etc)._ 
- **Lint**: _Add project-specific instructions here (e.g., `npm run lint`, `black .`, etc)._ 
- **Test (all)**: _Add project-specific instructions here (e.g., `npm test`, `pytest`, etc)._ 
- **Test (single test or file)**: _Document the pattern for your stack (e.g., `npm test -- path/to/file.test.js`)_

▶️ **Agent Action Required:**
Whenever a language stack is added, update this section with real commands for single file/single test execution (critical for AI agents/bots).

## 4. Code Style Guidelines
*Core patterns, with the expectation that agents update or extend this with language-specific tools/rules upon customization.*

### Imports & Module Organization
- **Absolute imports** where feasible (vs. deeply nested relative paths)
- **Group imports:**
    - Standard library first
    - Third-party libraries second
    - Project files last
- Agents: auto-sort and deduplicate imports unless language norms dictate otherwise.

### Formatting
- **Enforce automated formatting** (e.g., Prettier, Black, gofmt) for all code with a `.editorconfig` or formatter config present. If none exist, prefer the community standard for any adopted core language.
- Use whitespace generously to separate logical code blocks.
- Always end files with a newline.

### Type Annotations
- If a language supports types (e.g., TypeScript, Python type hints), **maximize typing coverage**:
    - Explicit return types for all functions exported from modules
    - Strong types for function arguments and return values
    - Prefer interfaces over type aliases when supported (e.g., TypeScript)
- For untyped languages, agents should write clear doc-comments specifying purpose and argument types.

### Naming Conventions
- Match standard naming conventions for the chosen language
- Functions: `camelCase`, classes/types: `PascalCase`, constants: `UPPER_UNDERSCORE`, variables: context-dependent
- **Be descriptive but concise.** Avoid ambiguous names like `foo`, `bar`, `data` when more specific context is available.

### Error Handling
- Always check for possible error states. **NEVER** ignore return values or callbacks that report errors.
- Use idiomatic error handling for the target stack (try/catch, error returns, etc.).
- For CLI/tools: print clear errors and exit non-zero on failure.

### Documentation
- All public functions, classes, or modules **should have docstrings or doc-comments** indicating their purpose and usage.
- Document non-obvious configuration or workflow steps adjacent to code (inline or in README/AGENTS.md).

## 5. Cursor and Copilot Instructions
- **Cursor**: No rules present as of this template version. If `.cursor/rules` or `.cursorrules` are added, **summarize and incorporate their rules here**.
- **Copilot**:
    - Project is designed for maximal agentic clarity—see [README.md](README.md) and [copilot-instructions.md](.github/copilot-instructions.md) for further context.
    - Summarize main points: "This is a composable, devcontainerized template for agent-first workflows. Extend and document any language/tooling-specific logic or CI/CD you add. Keep instructions current as the stack evolves."

## 6. Adding New Languages or Tools
- On adding a tool/language (Node, Python, Go, etc):
    - Install all standard dev dependencies (formatters, linters, test runners)
    - Add prototypical working config examples for build/lint/test
    - Update [Section 3](#build-lint-and-test-commands) and [Section 4](#code-style-guidelines) accordingly
    - Create/extend per-language README or doc sections as needed

## 7. AI Agent Best Practice Checklist
- [ ] Use the **latest available linter/formatter** for the language
- [ ] Apply type annotations and doc-comments
- [ ] Document single-test execution for CI/agent accuracy
- [ ] Prioritize minimal, clean, and secure configuration files
- [ ] Add/extend AGENTS.md and include Cursor/Copilot rules if added
- [ ] NEVER push secrets (e.g., in .env, config files, etc.)
- [ ] Always run and pass all tests/build/lint before proposing merges/commits
- [ ] If unsure, prefer explicitness and documentation over "magic"

## 8. Meta: Maintaining This File
- Agents and humans must update this file whenever the stack, build/lint/test flow, or code conventions change.
- If Cursor or Copilot rules are adopted, paste a summary block and update related instructions.
- Keep this file under 150 lines for readability; link to per-language docs if more space is needed.

---

*This file is mandatory reading for all agents/humans proposing code changes, both local and remote. Always consult and update as the repo grows.*
