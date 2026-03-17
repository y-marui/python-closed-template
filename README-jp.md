# AI Native Template（Python クローズド）

> **このファイルは正本（日本語版）です。**
> 英語版（参照）は [README.md](README.md) を参照してください。

AI支援開発用のクローズド Python アプリケーションテンプレート。
Poetry + Claude Code + GitHub Copilot 前提の開発体制。

---

## 特徴

- **AI ファースト**: Claude Code・GitHub Copilot との協働を前提とした構成
- **クローズドプロジェクト向け**: ドキュメント・コメントは日本語正本
- **セキュリティ内包**: pre-commit フック（gitleaks 等）をテンプレートに同梱
- **型安全**: mypy strict モードで型エラーを CI でブロック

---

## 技術スタック

| 項目 | 内容 |
|---|---|
| 言語 | Python `^3.11` |
| パッケージ管理 | Poetry |
| テスト | pytest `^8` |
| Linter | ruff `^0.3` |
| 型チェック | mypy `^1.8`（strict） |
| CI | GitHub Actions |

---

## ディレクトリ構成

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

## セットアップ

### 1. 依存関係のインストール

```sh
poetry install
```

### 2. セキュリティフックの設定

```sh
# dev-charter から設定ファイルをコピー
cp docs/dev-charter/.pre-commit-config.yaml .
cp docs/dev-charter/.gitleaks.toml .

# pre-commit フックをインストール
pre-commit install

# 動作確認
pre-commit run --all-files
```

### 3. 動作確認

```sh
make all   # lint + type check + test
```

---

## 開発フロー

```
Issue 作成 → feature ブランチ → AI 実装 → PR → レビュー → main
```

ブランチ: `main` / `develop` / `feature/*`
コミット形式: Conventional Commits（`feat` / `fix` / `refactor` / `docs` / `chore`）

---

## AI ツール分担

| ツール | 担当 |
|---|---|
| Claude Code | プロジェクト立ち上げ・大規模変更・設計 |
| GitHub Copilot | バグ修正・補助実装・単体テスト |
| Gemini CLI | ドキュメント・ストア申請系（手動で渡す） |

詳細: [AI_CONTEXT.md](AI_CONTEXT.md)

---

## 開発憲章の更新

```sh
make update-charter
```
