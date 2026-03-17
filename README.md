# AI Native Template (Python Closed)

> **This file is the English reference.**
> The canonical version (Japanese) is [README-jp.md](README-jp.md).

[![CI](https://github.com/y-marui/python-closed-template/actions/workflows/ci.yml/badge.svg)](https://github.com/y-marui/python-closed-template/actions/workflows/ci.yml)
[![License: All Rights Reserved](https://img.shields.io/badge/License-All%20Rights%20Reserved-red.svg)](LICENSE)

AI-assisted development template for closed Python packages. Designed for Poetry + Claude Code + GitHub Copilot workflows. Small team (1–3 people).

---

## Features

- ✅ **AI-first**: Built for collaboration with Claude Code and GitHub Copilot
- ✅ **Closed project**: Docs and comments are in Japanese (canonical)
- ✅ **Security built-in**: pre-commit hooks (gitleaks, etc.) included
- ✅ **Type-safe**: mypy strict mode enforced in CI
- ✅ **CI ready**: GitHub Actions runs lint, type check, and tests automatically
- ✅ **Poetry managed**: Dependencies, virtualenv, and packaging via Poetry

---

## Quick Start

```sh
git clone https://github.com/[user]/[repo].git
cd [repo]
poetry install

# Copy security config files
cp docs/dev-charter/.pre-commit-config.yaml .
cp docs/dev-charter/.gitleaks.toml .

# Install pre-commit hooks (skip if core.hooksPath is already set)
git config core.hooksPath 2>/dev/null \
  && echo "core.hooksPath is set. Proceed to next step." \
  || pre-commit install

# Verify hooks
pre-commit run --all-files

make all
```

See [README-jp.md](README-jp.md) for full documentation.

---

## License

All Rights Reserved — [LICENSE](LICENSE)
