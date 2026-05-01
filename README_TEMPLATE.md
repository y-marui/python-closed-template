# {Project Name}

> **This file is the English reference.**
> The canonical version (Japanese) is [README-jp.md](README-jp.md).

[![License: All Rights Reserved](https://img.shields.io/badge/License-All%20Rights%20Reserved-red.svg)](LICENSE)
[![CI](https://github.com/{user}/{repo}/actions/workflows/{workflow}.yml/badge.svg)](https://github.com/{user}/{repo}/actions/workflows/{workflow}.yml)
[![Charter Check](https://github.com/{user}/{repo}/actions/workflows/dev-charter-check.yml/badge.svg)](https://github.com/{user}/{repo}/actions/workflows/dev-charter-check.yml)
[![GitHub Sponsors](https://img.shields.io/github/sponsors/[USERNAME]?style=social)](https://github.com/sponsors/[USERNAME])
[![Buy Me a Coffee](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-donate-yellow.svg)](https://www.buymeacoffee.com/[BMC_USERNAME])

{One-line description: what it does, for whom, and how it helps.}

---

## Setup

```sh
git clone https://github.com/{user}/{repo}.git
cd {repo}
uv sync
```

---

## Usage

```sh
# Example command
uv run python -m project_name
```

| Command | Description |
|---|---|
| `make install` | Install dependencies |
| `make lint` | Run ruff linter |
| `make type` | Run mypy type check |
| `make test` | Run pytest |
| `make all` | Run lint + type + test |

---

## License

All Rights Reserved — [LICENSE](LICENSE)

---
*This document has a Japanese canonical version [README-jp.md](README-jp.md). Update both in the same commit when editing.*
