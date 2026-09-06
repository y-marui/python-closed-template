# AI_CONTEXT.md

このファイルは Claude Code・GitHub Copilot など AI ツールがセッション開始時に参照する唯一のコンテキストファイルです。

## Document Reference Order

AI はセッション開始時に以下の順序でドキュメントを参照する：

1. **AI_CONTEXT.md**（本ファイル：AI固有の指示・guardrails）
2. **README.md**（概要・セットアップ）
3. **docs/architecture.md**（モジュール・コンポーネント構造）— 詳細が必要な場合のみ
4. **docs/file-map.md**（ファイルレベルの依存関係）— 詳細が必要な場合のみ
5. **docs/specification.md**（機能仕様・データフロー）— 詳細が必要な場合のみ

---

## Project Overview

**目的**: AI支援開発用のクローズド Python アプリケーションテンプレート。
uv + Claude Code + GitHub Copilot 前提の開発体制。

**チーム規模**: 1〜3名の小規模チームで開発。将来的に外部メンテナンスへの移行を想定。

**言語ポリシー**: クローズドプロジェクトのため、ドキュメント・コメントは**日本語**を正本とする。

### Tech Stack

バージョン管理・パッケージ管理・Lint/Format・型チェックの一般方針は
[docs/dev-charter/topics/python/PYTHON_DEV_ENV.md](docs/dev-charter/topics/python/PYTHON_DEV_ENV.md)
を参照（CLI を実装する場合は
[docs/dev-charter/topics/python/PYTHON_CLI.md](docs/dev-charter/topics/python/PYTHON_CLI.md) も参照）。
CI（GitHub Actions）は push / PR のたびに実行する。

### Main Directories

```
.
├── src/              # ソースコード（core / api / repository）
├── docs/
│   ├── architecture.md
│   ├── specification.md
│   ├── file-map.md
│   ├── ui-design.md
│   └── dev-charter/  # 開発憲章（参照元）
└── .github/
    └── workflows/ci.yml
```

### Module Structure

| モジュール | 役割 |
|---|---|
| `core` | ビジネスロジック |
| `api` | HTTP インターフェース |
| `repository` | データアクセス |

### Architecture (Layer Dependency Direction)

```
API → Service → Repository → Storage
```

逆依存・循環依存は禁止。

---

## Coding Rules

- 可読性優先
- 関数は50行以内
- 単一責務
- 循環依存禁止
- コメントは「なぜそうするか」のみ書く（コードから自明な処理には書かない）

---

## Document Sync Rule

仕様・ルール・構成に変更が生じたとき、変更と同じ作業内で関連ドキュメントを更新する。
対象は `docs/` 内のファイルに限らず、`AI_CONTEXT.md`・`README.md` 等のルートファイルも含む。

---

## Applied Charter Principles

> 開発フロー・コードスタイル・命名規則・コードレビューチェックリストは [CONTRIBUTING.md](CONTRIBUTING.md) を参照。

### AI Behavior Principles

- **Scope（スコープ厳守）**: 会話の主題・タスク・ゴールを AI が勝手に変更しない。話題変更はユーザーが明示するか、AI の提案をユーザーが許可した場合のみ
- **Uncertainty（不明点の扱い）**: 重要な情報不足や曖昧さは質問する。軽微な不足は合理的な仮定で補い、仮定を明示する。推測で断定しない。不明点は以下の順で対応する：
  1. 推測しない
  2. TODO を書く
  3. Issue 提案
- 不明点・未定項目は**作業前に1回でまとめて**質問する（推測で進めない）
  - **確認必須**: ゴール（完了条件）・言語/FW/バージョン制約・新規 or 既存コード修正・テストの要否・影響範囲
  - **確認不要（既存コードに合わせる）**: コードスタイル・ファイル配置・軽微な実装詳細
- 大きな変更前に方針を説明してから着手する
- **不要な依存追加禁止**: 既存の依存で解決できないか先に検討する
- エラー発生時は「原因分析 → 修正方針説明 → 実装」の順で進める（エラーログ・スタックトレースは必ず全文確認）
- スコープを勝手に変更しない（話題変更はユーザーが明示した場合のみ）

---

## Project-Specific Rules

### AI Context Priority

1. **タスクコンテキスト**（Issue / Pull Request の内容）
2. **プロジェクトコンテキスト**（本ファイル・以下の読み込みファイル群）
3. **開発憲章**（`docs/dev-charter/`）
4. **グローバルコンテキスト**

### How to Reference the Charter

不明点が憲章（`docs/dev-charter/`）に関係する場合は全ファイルを検索せず、以下の手順で参照する：

1. `docs/dev-charter/CHARTER_INDEX.md` を読み、該当トピックのファイルを特定する
2. 特定したファイル（1〜2件）のみを読む
3. 参照後にユーザーへ提案・確認を行う

### Monetization

現時点でマネタイズ計画なし。計画が生じた場合は `MONETIZATION.md` を作成し、本ファイルに概要を追記すること。

### Document Permissions

- `docs/` は人間が書き・読む仕様書。**AI は参照のみ、直接編集しない**
- `docs/dev-charter/` 配下のファイルは **直接編集しない**。変更が必要な場合は dev-charter リポジトリ本体に Issue を立て、`git subtree pull` でアップデートを取り込む

### Security Hooks (pre-commit)

セットアップ手順は `docs/dev-charter/SECURITY_POLICY.md` の「Setup Steps」を参照。

以下が自動チェックされる：

| チェック | ツール |
|---|---|
| シークレット漏洩検知 | gitleaks |
| SSH 秘密鍵検知 | detect-private-key |
| `.env` ファイルのコミットブロック | detect-dotenv（local hook） |
| ローカル絶対パスのハードコード禁止 | no-hardcoded-local-paths |
| 500KB 超えファイルブロック | check-added-large-files |
| YAML/JSON 構文チェック | check-yaml / check-json |
| Shell スクリプト検証 | shellcheck |
| Markdown セクションヘッダの言語検証 | check-markdown-heading-language |

### CI Pipeline

```
security（pre-commit） / lint（ruff check / ruff format --check / mypy） / test（pytest）
  → build（インストール可能性確認） → gate（Required Checks）
```

docs-only の変更では `lint`/`test`/`build` は自動スキップされる（`changes` job が判定）。
`gate`（`Required Checks`）が Branch Protection の必須ステータスチェック。全て通過しないと PR はマージ不可。

---

## AI Tool Assignments

- **使用ツール**：Claude Code、GitHub Copilot、Gemini CLI
- **標準担当の正本**：`docs/dev-charter/AI_COLLABORATION_RULES.md` の「AI Tool Responsibilities」と「Rules for Multi-AI Usage」
- **プロジェクト固有の上書き**：
  - GitHub Copilot：バグ修正・細かな実装・コーディング補助・単体テスト作成（標準担当より実装寄りの役割）
  - Claude Code 作業中は Copilot 提案を参考程度に（盲目的に受け入れない）
  - Gemini CLI は自動読み込み不可。使用時に手動でコンテキストを渡すこと

### GitHub Operations

Issue を作成する場合は、必ずリポジトリオーナーを `assignee` に設定する。

```bash
gh issue create --title "..." --body "..." --assignee @me
```

> `@me` はトークンのオーナーに解決されるため、ユーザー名のハードコードは不要。

---

## Task Templates

### Bug Fix

1. 再現確認
2. エラーログ・スタックトレースを全文確認してから原因分析
3. 原因特定（推測で修正しない。必要なら既存コードを確認）
4. 修正方針を説明してから実装
5. 最小修正
6. テスト追加

### Feature Implementation

1. `docs/specification.md` 確認
2. `docs/architecture.md` 確認
3. 最小変更で実装
4. テスト追加

### Writing Tests

1. テスト対象の仕様を `docs/specification.md` で確認
2. 正常系・異常系・境界値を洗い出す
3. fixture は `tests/conftest.py` に定義
4. モックは Protocol ベースで注入する
5. テスト名は `test_<対象>_<条件>_<期待結果>` の形式

---

## Review Checklist

- 仕様準拠
- テスト存在
- 可読性
- 依存関係問題なし

---

## Prohibited Actions

### Security Constraints

- シークレット・APIキー・パスワード・トークンをコードにハードコードしない
- `.env` ファイルをコミットしない（`.env.example` のみ許可）
- ローカル絶対パス（`/Users/...` / `/home/...`）をコードにハードコードしない
- **シークレットを含むファイルやコードを AI に渡さない**（プロンプト・コンテキストファイル含む）
- AI が生成したコードは必ずレビューしてからコミットする

### Out-of-Scope Changes Are Prohibited

- **API レスポンス変更・エンドポイント削除**（破壊的変更禁止）
- **ディレクトリ変更・モジュール移動**（アーキテクチャ一貫性のため）
- **依存追加**（ライセンス・セキュリティリスクのため。必要な場合は Issue を作成してレビューを受ける）
- 大規模リファクタ（意図しない挙動変化防止のため）
- AI との会話ログをリポジトリにコミットしない
