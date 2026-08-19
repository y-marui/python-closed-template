# {プロジェクト名}

> **このファイルは正本（日本語版）です。**
> 英語版（参照）は [README.md](README.md) を参照してください。

[![License: All Rights Reserved](https://img.shields.io/badge/License-All%20Rights%20Reserved-red.svg)](LICENSE)
[![CI](https://github.com/{user}/{repo}/actions/workflows/{workflow}.yml/badge.svg)](https://github.com/{user}/{repo}/actions/workflows/{workflow}.yml)
[![Charter Check](https://github.com/{user}/{repo}/actions/workflows/dev-charter-check.yml/badge.svg)](https://github.com/{user}/{repo}/actions/workflows/dev-charter-check.yml)
[![GitHub Sponsors](https://img.shields.io/github/sponsors/[USERNAME]?style=social)](https://github.com/sponsors/[USERNAME])
[![Buy Me a Coffee](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-donate-yellow.svg)](https://www.buymeacoffee.com/[BMC_USERNAME])

{一行概要：「何を・誰のために・どう解決するか」を 1 文で}

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
# 主なコマンド例
uv run python -m project_name
```

| コマンド | 内容 |
|---|---|
| `make install` | 依存関係のインストール |
| `make lint` | ruff によるコードチェック |
| `make type` | mypy による型チェック |
| `make test` | pytest によるテスト実行 |
| `make all` | lint + type + test を一括実行 |

---

## License

All Rights Reserved — [LICENSE](LICENSE)

---
*この文書には英語版 [README.md](README.md) があります。編集時は同一コミットで更新してください。*
