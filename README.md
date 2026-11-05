# Python Closed Template

> **This is the reference (English) version.**
> The canonical (Japanese) version is [README-jp.md](README-jp.md).

[![License: All Rights Reserved](https://img.shields.io/badge/License-All%20Rights%20Reserved-red.svg)](LICENSE)
[![CI](https://github.com/y-marui/python-closed-template/actions/workflows/ci.yml/badge.svg)](https://github.com/y-marui/python-closed-template/actions/workflows/ci.yml)
[![Charter Check](https://github.com/y-marui/python-closed-template/actions/workflows/dev-charter-check.yml/badge.svg)](https://github.com/y-marui/python-closed-template/actions/workflows/dev-charter-check.yml)
[![GitHub Sponsors](https://img.shields.io/github/sponsors/y-marui?style=social)](https://github.com/sponsors/y-marui)
[![Buy Me a Coffee](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-donate-yellow.svg)](https://www.buymeacoffee.com/y.marui)

AI-assisted development template for closed Python packages. Designed for uv + Claude Code + GitHub Copilot workflows. Small team (1–3 people).

---

## Meta Info

| Item | Detail |
|---|---|
| Target | Python package |
| Team | Small team (1–3 people) |
| Primary language | Japanese |
| AI tools | Claude Code / GitHub Copilot |

---

## Features

- ✅ **AI-first**: Built for collaboration with Claude Code and GitHub Copilot
- ✅ **Closed project**: Docs and comments are in Japanese (canonical)
- ✅ **Security built-in**: pre-commit hooks (gitleaks, etc.) included
- ✅ **Type-safe**: mypy strict mode enforced in CI
- ✅ **CI ready**: GitHub Actions runs lint, type check, and tests automatically
- ✅ **uv managed**: Dependencies, virtualenv, and packaging via uv

---

## Requirements

| Tool | Version |
|---|---|
| Python | `^3.11` |
| uv | Latest stable |
| pre-commit | Latest stable |

---

## Quick Start

Click **Use this template** on GitHub, or follow the steps below to create a project.

### 1. Create a Repository from the Template

Click **Use this template → Create a new repository** on GitHub.

### 2. Initial README Setup

```sh
# Rename README_TEMPLATE.md → README.md (and the Japanese one → README-jp.md) for your project
mv README_TEMPLATE-jp.md README-jp.md
mv README_TEMPLATE.md README.md
# Replace placeholders: {user}, {repo}, {workflow}, [USERNAME], [BMC_USERNAME], etc.
```

### 3. Install Dependencies

```sh
uv sync
```

### 4. Set Up Security Hooks

```sh
# Copy config files from dev-charter
cp docs/dev-charter/.pre-commit-config.yaml .
cp docs/dev-charter/.gitleaks.toml .

# Install pre-commit hooks
# Not needed if core.hooksPath is already set (the global hook calls pre-commit)
git config core.hooksPath 2>/dev/null \
  && echo "core.hooksPath is set. Proceed to next step." \
  || pre-commit install

# Verify hooks (required)
pre-commit run --all-files
```

### 5. Verify Setup

```sh
make all   # run lint + type check + tests together
```

---

## Command Reference

| Command | Description |
|---|---|
| `make install` | Install dependencies |
| `make lint` | Lint with ruff |
| `make type` | Type check with mypy |
| `make test` | Run tests with pytest |
| `make all` | Run lint + type + test together |
| `make update-charter` | Update dev-charter to the latest version |

---

## Development Flow

See [CONTRIBUTING.md](CONTRIBUTING.md) for the development flow, branching strategy, commit format, and code review checklist.

---

## Project Structure

```
.
├── src/
│   └── project_name/     # Package (rename when turning the template into a project)
├── tests/
│   ├── unit/             # Unit tests
│   ├── integration/      # Integration tests
│   └── conftest.py       # Shared fixtures
├── examples/
│   └── patterns/         # Implementation pattern examples
├── docs/
│   ├── specification.md  # System specification (written by humans)
│   ├── architecture.md   # Architecture design (written by humans)
│   ├── file-map.md       # File-level dependencies
│   ├── ui-design.md      # UI design ("N/A" if there is no UI)
│   └── dev-charter/      # Development charter (git subtree)
├── scripts/              # pre-commit hook and branch-creation scripts
├── .github/
│   ├── workflows/        # ci.yml, dev-charter-check.yml, auto-assign-self.yml
│   ├── ISSUE_TEMPLATE/
│   ├── copilot-instructions.md
│   └── pull_request_template.md
├── README_TEMPLATE-jp.md # README template for new projects (Japanese canonical)
├── README_TEMPLATE.md    # README template for new projects (English reference)
├── CONTRIBUTING.md       # Development flow, naming rules, code review checklist
├── AI_CONTEXT.md         # AI context (read at the start of a session)
├── CLAUDE.md             # Claude Code entry point
├── Makefile              # Development commands
└── pyproject.toml
```

---

## Document Index

| File | Description |
|---|---|
| [CONTRIBUTING.md](CONTRIBUTING.md) | Development flow, naming rules, code review checklist |
| [README_TEMPLATE-jp.md](README_TEMPLATE-jp.md) | README template for new projects (Japanese canonical) |
| [README_TEMPLATE.md](README_TEMPLATE.md) | README template for new projects (English reference) |
| [docs/specification.md](docs/specification.md) | System specification |
| [docs/architecture.md](docs/architecture.md) | Architecture design |
| [docs/file-map.md](docs/file-map.md) | File-level dependencies |
| [docs/ui-design.md](docs/ui-design.md) | UI design |
| [AI_CONTEXT.md](AI_CONTEXT.md) | AI context (read at the start of an AI session) |

---

## AI-Assisted Development

`AI_CONTEXT.md` exists. AI tools should read it at the start of a session.

| Tool | Role |
|---|---|
| Claude Code | Project setup, large changes, design |
| GitHub Copilot | Bug fixes, supporting implementation, unit tests |

Details: [AI_CONTEXT.md](AI_CONTEXT.md)

---

## Private Package PAT Configuration

When `pyproject.toml` lists a private GitHub repository as a dependency,
a PAT (Personal Access Token) may be required.
**Never write the PAT in source code.** Inject it per environment as follows.

### Local Development Environment (git config)

```sh
# Route authentication for https://github.com/[username]/python-* through the PAT
# Adjust [username] and the python- prefix to match your project
git config --local \
  url."https://github_pat_xxxx@github.com/[username]/python-".insteadOf \
  "https://github.com/[username]/python-"
```

- Replace `github_pat_xxxx` with your actual PAT
- The `python-` prefix applies to all `python-*` private packages at once
- Stored in `.git/config`, so it is never committed (no `.gitignore` entry needed)
- Pre-commit hooks such as gitleaks also catch accidental commits

### GitHub Actions CI

#### 1. Register Secrets

Register in **Settings → Secrets and variables → Actions → Repository secrets**:

| Secret name | Value |
|---|---|
| `GH_TOKEN` | `github_pat_xxxx` (the PAT value itself) |

#### 2. Injection Step in ci.yml

```yaml
- name: Inject PAT into pyproject.toml git URLs (CI only, not committed)
  run: |
    # Inject the PAT into all python-* private package URLs at once
    sed -i \
      "s|https://github.com/[username]/python-|https://${{ secrets.GH_TOKEN }}@github.com/[username]/python-|g" \
      pyproject.toml
```

- Replace `[username]` with your actual GitHub username
- `sed` only rewrites `pyproject.toml` temporarily; nothing is committed or pushed
- Multiple private dependencies are covered at once by the `python-` prefix

---

## License

All Rights Reserved — [LICENSE](LICENSE)

---
*This document has a Japanese canonical version [README-jp.md](README-jp.md). Update both in the same commit when editing.*
