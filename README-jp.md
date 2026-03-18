# Python クローズド Template

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

## プライベートパッケージの PAT 設定

`pyproject.toml` に `https://github.com/` の private リポジトリを依存として記載する場合、
PAT（Personal Access Token）が必要になることがある。
**PAT はソースコードに書き込まない**こと。以下の方法で環境ごとに注入する。

### ローカル開発環境（git config）

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

#### 1. Secrets の登録

リポジトリの **Settings → Secrets and variables → Actions → Repository secrets** に登録:

| シークレット名 | 値 |
|---|---|
| `GH_TOKEN` | `github_pat_xxxx`（PAT の値そのもの） |

#### 2. ci.yml への注入ステップ

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

## ライセンス

All Rights Reserved — [LICENSE](LICENSE)
