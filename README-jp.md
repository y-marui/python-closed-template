# Python クローズド Template

> **このファイルは正本（日本語版）です。**
> 英語版（参照）は [README.md](README.md) を参照してください。

[![License: All Rights Reserved](https://img.shields.io/badge/License-All%20Rights%20Reserved-red.svg)](LICENSE)
[![CI](https://github.com/y-marui/python-closed-template/actions/workflows/ci.yml/badge.svg)](https://github.com/y-marui/python-closed-template/actions/workflows/ci.yml)
[![Charter Check](https://github.com/y-marui/python-closed-template/actions/workflows/dev-charter-check.yml/badge.svg)](https://github.com/y-marui/python-closed-template/actions/workflows/dev-charter-check.yml)

uv + Claude Code + GitHub Copilot で Python パッケージを作るためのテンプレート。小規模チーム（1〜3人）向け。

---

## Meta Info

| 項目 | 内容 |
|---|---|
| 開発対象 | Python パッケージ |
| 開発環境 | 小規模チーム（1〜3人） |
| 主言語 | 日本語 |
| AI ツール | Claude Code / GitHub Copilot |

---

## Features

- ✅ **AI ファースト**: Claude Code・GitHub Copilot との協働を前提とした構成
- ✅ **クローズドプロジェクト向け**: ドキュメント・コメントは日本語正本
- ✅ **セキュリティ内包**: pre-commit フック（gitleaks 等）をテンプレートに同梱
- ✅ **型安全**: mypy strict モードで型エラーを CI でブロック
- ✅ **CI 完備**: GitHub Actions で lint・型チェック・テストを自動実行
- ✅ **uv 管理**: 依存関係・仮想環境・パッケージングを uv で一元管理

---

## Requirements

| ツール | バージョン |
|---|---|
| Python | `^3.11` |
| uv | 最新安定版 |
| pre-commit | 最新安定版 |

---

## Quick Start

GitHub の **Use this template** ボタン、または以下の手順でプロジェクトを作成する。

### 1. Create a Repository from the Template

GitHub の **Use this template → Create a new repository** をクリックしてリポジトリを作成する。

### 2. Initial README Setup

```sh
# README_TEMPLATE-jp.md → README-jp.md にリネームして日本語正本に使う
mv README_TEMPLATE-jp.md README-jp.md
mv README_TEMPLATE.md README.md
# プレースホルダを実際の値に置き換える（{user}・{repo}・{workflow}・[USERNAME]・[BMC_USERNAME] など）
```

### 3. Install Dependencies

```sh
uv sync
```

### 4. Set Up Security Hooks

```sh
# dev-charter から設定ファイルをコピー
cp docs/dev-charter/.pre-commit-config.yaml .
cp docs/dev-charter/.gitleaks.toml .

# pre-commit フックをインストール
# core.hooksPath が設定済みの場合（グローバルフックが pre-commit を呼ぶ）はインストール不要
git config core.hooksPath 2>/dev/null \
  && echo "core.hooksPath が設定されています。次に進んでください。" \
  || pre-commit install

# 動作確認（必須）
pre-commit run --all-files
```

### 5. Verify Setup

```sh
make all   # lint + 型チェック + テストを一括実行
```

---

## Command Reference

| コマンド | 内容 |
|---|---|
| `make install` | 依存関係のインストール |
| `make lint` | ruff によるコードチェック |
| `make type` | mypy による型チェック |
| `make test` | pytest によるテスト実行 |
| `make all` | lint + type + test を一括実行 |
| `make update-charter` | 開発憲章（dev-charter）を最新版に更新 |

---

## Development Flow

開発フロー・ブランチ戦略・コミット形式・コードレビューチェックリストは [CONTRIBUTING.md](CONTRIBUTING.md) を参照。

---

## Project Structure

```
.
├── src/                  # ソースコード
│   ├── core/             # ビジネスロジック
│   ├── api/              # HTTP インターフェース
│   └── repository/       # データアクセス
├── tests/                # テストコード
├── docs/
│   ├── specification.md  # システム仕様（人間が書く）
│   ├── architecture.md   # アーキテクチャ設計（人間が書く）
│   ├── file-map.md       # ファイルレベルの依存関係
│   ├── ui-design.md      # UI 設計（UI がない場合は「該当なし」）
│   └── dev-charter/      # 開発憲章（git subtree）
├── .github/
│   ├── workflows/ci.yml
│   ├── copilot-instructions.md
│   └── pull_request_template.md
├── README_TEMPLATE-jp.md # プロジェクト化後の README 雛形（日本語正本）
├── README_TEMPLATE.md    # プロジェクト化後の README 雛形（英語参照版）
├── CONTRIBUTING.md       # 開発フロー・命名規則・コードレビューチェックリスト
├── AI_CONTEXT.md         # AI コンテキスト（セッション開始時に参照）
├── CLAUDE.md             # Claude Code エントリポイント
└── pyproject.toml
```

---

## Document Index

| ファイル | 内容 |
|---|---|
| [CONTRIBUTING.md](CONTRIBUTING.md) | 開発フロー・命名規則・コードレビューチェックリスト |
| [README_TEMPLATE-jp.md](README_TEMPLATE-jp.md) | プロジェクト化後の README 雛形（日本語正本） |
| [README_TEMPLATE.md](README_TEMPLATE.md) | プロジェクト化後の README 雛形（英語参照版） |
| [docs/specification.md](docs/specification.md) | システム仕様 |
| [docs/architecture.md](docs/architecture.md) | アーキテクチャ設計 |
| [docs/file-map.md](docs/file-map.md) | ファイルレベルの依存関係 |
| [docs/ui-design.md](docs/ui-design.md) | UI 設計 |
| [AI_CONTEXT.md](AI_CONTEXT.md) | AI コンテキスト（AI セッション開始時に参照） |

---

## AI-Assisted Development

`AI_CONTEXT.md` が存在します。AI ツールはセッション開始時にこのファイルを参照してください。

| ツール | 担当 |
|---|---|
| Claude Code | プロジェクト立ち上げ・大規模変更・設計 |
| GitHub Copilot | バグ修正・補助実装・単体テスト |
| Gemini CLI | ドキュメント・ストア申請系（手動で渡す） |

詳細: [AI_CONTEXT.md](AI_CONTEXT.md)

---

## Private Package PAT Configuration

`pyproject.toml` に `https://github.com/` の private リポジトリを依存として記載する場合、
PAT（Personal Access Token）が必要になることがある。
**PAT はソースコードに書き込まない**こと。以下の方法で環境ごとに注入する。

### Local Development Environment (git config)

```sh
# https://github.com/[username]/python-* への認証を PAT で通す
# [username] と python- プレフィックスは実際のプロジェクトに合わせて変更すること
git config --local \
  url."https://github_pat_xxxx@github.com/[username]/python-".insteadOf \
  "https://github.com/[username]/python-"
```

- `github_pat_xxxx` は実際の PAT に置き換える
- `python-` のプレフィックス指定により `python-*` の全プライベートパッケージに一括適用される
- `.git/config` に保存されるためコミットには含まれない（`.gitignore` 不要）
- gitleaks 等の pre-commit フックで誤コミットも検出される

### GitHub Actions CI

#### 1. Register Secrets

リポジトリの **Settings → Secrets and variables → Actions → Repository secrets** に登録:

| シークレット名 | 値 |
|---|---|
| `GH_TOKEN` | `github_pat_xxxx`（PAT の値そのもの） |

#### 2. Injection Step in ci.yml

```yaml
- name: pyproject.toml の git URL に PAT を注入（CI のみ・コミットされない）
  run: |
    # python-* プレフィックスのプライベートパッケージ URL に PAT を一括注入
    sed -i \
      "s|https://github.com/[username]/python-|https://${{ secrets.GH_TOKEN }}@github.com/[username]/python-|g" \
      pyproject.toml
```

- `[username]` は実際の GitHub ユーザー名に置き換える
- `sed` で `pyproject.toml` を一時書き換えるのみ。コミット・プッシュはされない
- PAT が必要な private 依存が複数あっても `python-` プレフィックスで一括対応できる

---

## License

All Rights Reserved — [LICENSE](LICENSE)

---
*この文書には英語版 [README.md](README.md) があります。編集時は同一コミットで更新してください。*
