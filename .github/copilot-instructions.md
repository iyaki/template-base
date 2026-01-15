# OpenCode Devcontainer Project Template

## Project Overview
This is a **template repository** for setting up devcontainerized projects with OpenCode integration. The primary purpose is to provide a production-ready dev environment bootstrap for any project type, with all infrastructure pre-configured.

## Architecture & Key Components

### Devcontainer Setup (`.devcontainer/`)
- **Base Image**: `mcr.microsoft.com/devcontainers/universal:2-linux` - provides a general-purpose dev environment
- **Key Features Enabled**:
  - Docker-outside-of-docker (required for Playwright MCP server)
  - Git (latest)
  - OpenCode CLI (`opencode-ai` npm package)
- **Mount Point**: Host's `~/.opencode` → Container's `.local/share/opencode` (preserves OpenCode config across runs)
- **Extensions**: `opencode` (main IDE) + `openchamber` (complementary tool)

### OpenCode Configuration (`opencode.json`)
This project uses OpenCode (alternative to Claude Code/Cursor) with the following setup:
- **Models**: GPT-4.1 (main) + GPT-5 Mini (small tasks)
- **MCPs Enabled** (Model Context Protocol servers):
  - `playwright` (local Docker) - browser automation & web scraping
  - `context7` (local npm) - documentation lookup
  - `sequentialthinking` (local npm) - reasoning & planning
  - `gh_grep` (remote) - GitHub code search
  - `github` (remote) - GitHub API integration
- **Plugins**: 
  - `opencode-pty` - terminal integration
  - `opencode-md-table-formatter` - markdown utilities
  - `opencode-notifier` - notifications
  - `plannotator` - task planning visualization

## Critical Workflows

### Initialize a New Project
1. Run `./setup.sh` to:
   - Clean up template artifacts (Notes.md, .git, setup.sh itself)
   - Initialize a fresh git repo
   - This is typically run ONCE when cloning the template
2. Customize `devcontainer.json`:
   - Change `"name"` field to your project name
   - Add project-specific features/extensions as needed
   - Modify `mcp` config if project requires different tools
3. Update `opencode.json`:
   - Adjust models if project benefits from specialized models (e.g., `claude-opus-4` for complex reasoning)
   - Enable/disable MCPs based on project needs
   - Add or customize plugins

### Development in Devcontainer
1. Open workspace in VS Code with devcontainer extension
2. Container starts with pre-installed OpenCode CLI and Git
3. Host's `~/.opencode` config automatically available inside container
4. Use OpenCode as your primary AI coding agent (via IDE extension)

## Project-Specific Patterns & Conventions

### Configuration Philosophy
- **Composable MCPs**: Each MCP serves a specific purpose. Disable unused ones to reduce latency
- **Feature Comments in JSON**: `devcontainer.json` includes commented examples for optional features (GitHub CLI, Python UV, etc.)
- **Template Pattern**: This repo is meant to be customized, not extended. Fork/clone and adapt for your needs

### Dockerfile Approach
- No custom Dockerfile - relies on Microsoft's maintained devcontainer base image for compatibility
- Docker feature is included via devcontainer feature (not installed via Dockerfile) to support Docker-in-Docker for Playwright

## Key Files & Their Purpose

| File | Purpose | When to Modify |
|------|---------|---|
| `opencode.json` | OpenCode model, MCP, and plugin config | When project requirements change (new tools needed, different AI model preferred) |
| `.devcontainer/devcontainer.json` | Container image, features, mount points, extensions | When adding new dev tools, languages, or changing environment setup |
| `setup.sh` | One-time template cleanup script | Rarely - only if template bootstrap logic changes |
| `.github/dependabot.yml` | Dependency update automation | When adding package managers to track |
| `README.md` | Project documentation | Should be replaced with actual project docs when forked |

## Common Tasks for AI Agents

### Task: Add a New Tool to Devcontainer
1. Edit `.devcontainer/devcontainer.json`
2. Add feature under `"features"` key OR uncomment existing example (e.g., GitHub CLI)
3. OpenCode will refresh environment on next container start

### Task: Update AI Model Strategy
1. Edit `opencode.json`
2. Change `"model"` for general tasks or override per-MCP if needed
3. Consider `small_model` for low-complexity tasks (cost optimization)

### Task: Extend for Specific Project Type
- Add language-specific devcontainer features (Python, Node, Go, etc.)
- Include project-specific MCPs (e.g., database tools, API documentation servers)
- Customize `opencode.json` model selection based on workload

## Integration Points

- **GitHub**: Dependabot configured; add workflows in `.github/workflows/` for CI/CD
- **OpenCode**: Container automatically mounts host config for seamless auth/settings
- **VS Code**: Extensions load via devcontainer customization; settings apply automatically

## Notes for AI Agents

- This is a **template, not a fixed product**. Modifications are expected and encouraged.
- The `Notes.md` file contains brainstorming ideas for features to develop (not implemented yet).
- When onboarding a new project type, consider what MCPs and devcontainer features are essential vs. optional.
