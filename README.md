# AI Native Template (Python Closed)

> **This file is the English reference.**
> The canonical version (Japanese) is [README-jp.md](README-jp.md).

AI-assisted development template for closed Python applications.
Designed for Poetry + Claude Code + GitHub Copilot workflows.

---

## Features

- **AI-first**: Built for collaboration with Claude Code and GitHub Copilot
- **Closed project**: Docs and comments are in Japanese (canonical)
- **Security built-in**: pre-commit hooks (gitleaks, etc.) included
- **Type-safe**: mypy strict mode enforced in CI

---

## Tech Stack

| | |
|---|---|
| Language | Python `^3.11` |
| Package manager | Poetry |
| Testing | pytest `^8` |
| Linter | ruff `^0.3` |
| Type checker | mypy `^1.8` (strict) |
| CI | GitHub Actions |

---

## Quick Start

```sh
poetry install
cp docs/dev-charter/.pre-commit-config.yaml .
cp docs/dev-charter/.gitleaks.toml .
pre-commit install
make all
```

See [README-jp.md](README-jp.md) for full documentation.
