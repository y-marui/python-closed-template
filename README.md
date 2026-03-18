# Python Closed Template

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

## Private Package PAT Configuration

When `pyproject.toml` references private GitHub repositories, a PAT (Personal Access Token) may be required.
**Never write the PAT directly in source code.** Inject it per environment as follows.

### Local Development (git config)

```sh
# Route authentication for https://github.com/[username]/python-* through PAT
# Adjust [username] and the python- prefix to match your project
git config --local \
  url."https://github_pat_xxxx@github.com/[username]/python-".insteadOf \
  "https://github.com/[username]/python-"
```

- Replace `github_pat_xxxx` with your actual PAT
- The `python-` prefix applies to all `python-*` private packages at once
- Stored in `.git/config`, never committed

### GitHub Actions CI

Register in **Settings → Secrets and variables → Actions → Repository secrets**:

| Secret name | Value |
|---|---|
| `GH_TOKEN` | `github_pat_xxxx` (the PAT value itself) |

Add to `ci.yml` before `poetry install`:

```yaml
- name: Inject PAT into pyproject.toml git URLs (CI only, not committed)
  run: |
    sed -i \
      "s|https://github.com/[username]/python-|https://${{ secrets.GH_TOKEN }}@github.com/[username]/python-|g" \
      pyproject.toml
```

See [README-jp.md](README-jp.md) for full details (Japanese canonical).

---

## License

All Rights Reserved — [LICENSE](LICENSE)
