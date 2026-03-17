# AI Native Template（Python クローズド）

> **このファイルは正本（日本語版）です。**
> 英語版（参照）は [README.md](README.md) を参照してください。

[![CI](https://github.com/y-marui/python-closed-template/actions/workflows/ci.yml/badge.svg)](https://github.com/y-marui/python-closed-template/actions/workflows/ci.yml)
[![License: All Rights Reserved](https://img.shields.io/badge/License-All%20Rights%20Reserved-red.svg)](LICENSE)

Poetry + Claude Code + GitHub Copilot で Python パッケージを作るためのテンプレート。小規模チーム（1〜3人）向け。

---

## メタ情報

| 項目 | 内容 |
|---|---|
| 開発対象 | Python パッケージ |
| 開発環境 | 小規模チーム（1〜3人） |
| 主言語 | 日本語 |
| AI ツール | Claude Code / GitHub Copilot |

---

## 特徴

- ✅ **AI ファースト**: Claude Code・GitHub Copilot との協働を前提とした構成
- ✅ **クローズドプロジェクト向け**: ドキュメント・コメントは日本語正本
- ✅ **セキュリティ内包**: pre-commit フック（gitleaks 等）をテンプレートに同梱
- ✅ **型安全**: mypy strict モードで型エラーを CI でブロック
- ✅ **CI 完備**: GitHub Actions で lint・型チェック・テストを自動実行
- ✅ **Poetry 管理**: 依存関係・仮想環境・パッケージングを Poetry で一元管理

---

## 動作要件

| ツール | バージョン |
|---|---|
| Python | `^3.11` |
| Poetry | 最新安定版 |
| pre-commit | 最新安定版 |

---

## クイックスタート

### 1. 依存関係のインストール

```sh
git clone https://github.com/[user]/[repo].git
cd [repo]
poetry install
```

### 2. セキュリティフックの設定

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

### 3. 動作確認

```sh
make all   # lint + 型チェック + テストを一括実行
```

---

## コマンド一覧

| コマンド | 内容 |
|---|---|
| `make install` | 依存関係のインストール |
| `make lint` | ruff によるコードチェック |
| `make type` | mypy による型チェック |
| `make test` | pytest によるテスト実行 |
| `make all` | lint + type + test を一括実行 |
| `make update-charter` | 開発憲章（dev-charter）を最新版に更新 |

---

## 開発フロー

```
Issue 作成 → feature ブランチ → AI 実装 → PR → レビュー → main
```

ブランチ: `main` / `develop` / `feature/*`
コミット形式: Conventional Commits（`feat` / `fix` / `refactor` / `docs` / `chore`）

---

## プロジェクト構造

```
.
├── src/                  # ソースコード
│   ├── core/             # ビジネスロジック
│   ├── api/              # HTTP インターフェース
│   └── repository/       # データアクセス
├── tests/                # テストコード
├── ai/
│   ├── context/          # AI が毎回読む要約・制約
│   ├── tasks/            # タスク別プロンプトテンプレート
│   └── review/           # レビューチェックリスト
├── docs/
│   ├── specification.md  # システム仕様（人間が書く）
│   ├── architecture.md   # アーキテクチャ設計（人間が書く）
│   ├── guardrails.md     # AI 変更禁止範囲
│   ├── development_rules.md  # 開発ルール詳細
│   └── dev-charter/      # 開発憲章（git subtree）
├── .github/
│   ├── workflows/ci.yml
│   ├── copilot-instructions.md
│   └── pull_request_template.md
├── AI_CONTEXT.md         # AI コンテキスト（セッション開始時に参照）
├── CLAUDE.md             # Claude Code エントリポイント
├── AI.md                 # AI ツール共通ガイド
└── pyproject.toml
```

---

## ドキュメント索引

| ファイル | 内容 |
|---|---|
| [docs/specification.md](docs/specification.md) | システム仕様 |
| [docs/architecture.md](docs/architecture.md) | アーキテクチャ設計 |
| [docs/guardrails.md](docs/guardrails.md) | AI 変更禁止範囲 |
| [docs/development_rules.md](docs/development_rules.md) | 開発ルール詳細 |
| [AI_CONTEXT.md](AI_CONTEXT.md) | AI コンテキスト（AI セッション開始時に参照） |

---

## AI 支援開発

`AI_CONTEXT.md` が存在します。AI ツールはセッション開始時にこのファイルを参照してください。

| ツール | 担当 |
|---|---|
| Claude Code | プロジェクト立ち上げ・大規模変更・設計 |
| GitHub Copilot | バグ修正・補助実装・単体テスト |
| Gemini CLI | ドキュメント・ストア申請系（手動で渡す） |

詳細: [AI_CONTEXT.md](AI_CONTEXT.md)

---

## ライセンス

All Rights Reserved — [LICENSE](LICENSE)
