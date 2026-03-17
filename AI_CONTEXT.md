# AI_CONTEXT.md

このファイルは Claude Code・GitHub Copilot など AI ツールがセッション開始時に参照する唯一のコンテキストファイルです。

---

## プロジェクト概要

**目的**: AI支援開発用のクローズド Python アプリケーションテンプレート。
Poetry + Claude Code + GitHub Copilot 前提の開発体制。

**言語ポリシー**: クローズドプロジェクトのため、ドキュメント・コメントは**日本語**を正本とする。

### 技術スタック

| 項目 | 内容 |
|---|---|
| 言語 | Python `^3.11` |
| パッケージ管理 | Poetry |
| テスト | pytest `^8` |
| Linter | ruff `^0.3`（line-length=88、select: E/F/I） |
| 型チェック | mypy `^1.8`（strict モード） |
| CI | GitHub Actions（push / PR）|

### 主要ディレクトリ

```
.
├── src/              # ソースコード（core / api / repository）
├── ai/
│   ├── context/      # AI が毎回読む要約・制約（coding_rules.md, module_index.md, dependency_graph.md）
│   ├── tasks/        # タスク別プロンプトテンプレート
│   └── review/       # レビューチェックリスト
├── docs/
│   ├── architecture.md
│   ├── specification.md
│   ├── guardrails.md
│   ├── development_rules.md
│   └── dev-charter/  # 開発憲章（参照元）
└── .github/
    └── workflows/ci.yml
```

### アーキテクチャ（レイヤー依存方向）

```
API → Service → Repository → Storage
```

逆依存・循環依存は禁止。

---

## 適用する憲章原則

### コード設計

- **変更範囲は必要最小限**（over-engineering しない、YAGNI 原則）
- **DRY の判断**: 2回の重複では抽象化しない、3回目で検討
- **既存パターンに従う**: 命名規則・ディレクトリ構造・アーキテクチャ
- **TODO/FIXME を残さない**: 実装するか Issue に記録する

### コードスタイル

- 関数は50行以内、単一責務
- コメントは「なぜそうするか」のみ書く（コードから自明な処理には書かない）
- デバッグ用 `print` 文を本番コードに残さない

### Git 運用

- **ブランチ戦略**: `main` / `develop` / `feature/*`
- **フロー**: Issue → feature ブランチ → AI 実装 → PR → レビュー
- **コミット形式**: Conventional Commits（`feat` / `fix` / `refactor` / `docs` / `chore`）
- **WIP 禁止**: 動作しないコードはコミットしない

### AI 行動原則

- 不明点・未定項目は**作業前に1回でまとめて**質問する（推測で進めない）
- 大きな変更前に方針を説明してから着手する
- エラー発生時は「原因分析 → 修正方針説明 → 実装」の順で進める
- スコープを勝手に変更しない（話題変更はユーザーが明示した場合のみ）

---

## プロジェクト固有ルール

### AI コンテキスト優先順位

1. **タスクコンテキスト**（Issue / Pull Request の内容）
2. **プロジェクトコンテキスト**（本ファイル・以下の読み込みファイル群）
3. **開発憲章**（`docs/dev-charter/`）
4. **グローバルコンテキスト**

### AI 読み込み順序

1. `AI_CONTEXT.md`（本ファイル）
2. `ai/context/`（全ファイル: coding_rules.md / module_index.md / dependency_graph.md）
3. `docs/specification.md`（詳細が必要な場合のみ）
4. `docs/architecture.md`（詳細が必要な場合のみ）
5. `docs/guardrails.md`

### マネタイズ

現時点でマネタイズ計画なし。計画が生じた場合は `MONETIZATION.md` を作成し、本ファイルに概要を追記すること。

### ドキュメント権限

- `docs/` は人間が書き・読む仕様書。**AI は参照のみ、直接編集しない**
- `ai/context/` は `docs/` の内容を AI 向けに要約したもの。`docs/` と重複する場合は `ai/context/` を優先する

### セキュリティフック（pre-commit）

`.pre-commit-config.yaml` をルートにコピーして `pre-commit install` すること。
以下が自動チェックされる：

| チェック | ツール |
|---|---|
| シークレット漏洩検知 | gitleaks v8.21.2 |
| SSH 秘密鍵検知 | detect-private-key |
| `.env` ファイルのコミットブロック | detect-dotenv（local hook） |
| ローカル絶対パスのハードコード禁止 | no-hardcoded-local-paths |
| 500KB 超えファイルブロック | check-added-large-files |
| YAML/JSON 構文チェック | check-yaml / check-json |
| Shell スクリプト検証 | shellcheck |

### CI パイプライン

```
ruff check . → mypy src → pytest
```

全て通過しないと PR はマージ不可。

---

## AI ツール分担

| ツール | 担当範囲 |
|---|---|
| **Claude Code** | プロジェクト立ち上げ・大規模なコード変更・アーキテクチャ設計・リファクタリング提案 |
| **GitHub Copilot** | バグ修正・細かな実装・コーディング補助・単体テスト作成 |
| **Gemini CLI** | プライバシーポリシー・ストア説明文・審査用ドキュメント・プロジェクト全体のドキュメント管理 |

### AI 並用時のルール

- Claude Code 作業中は Copilot 提案を**参考程度**に（盲目的に受け入れない）
- Copilot の提案がプロジェクト規約に反する場合は無視し、Claude Code でレビュー後に採用
- Gemini CLI は自動読み込み不可。使用時に手動でコンテキストを渡すこと

---

## 禁止事項

### セキュリティ制約

- シークレット・APIキー・パスワード・トークンをコードにハードコードしない
- `.env` ファイルをコミットしない（`.env.example` のみ許可）
- ローカル絶対パス（`/Users/...` / `/home/...`）をコードにハードコードしない
- **シークレットを含むファイルやコードを AI に渡さない**（プロンプト・コンテキストファイル含む）
- AI が生成したコードは必ずレビューしてからコミットする

### スコープ外変更の禁止

- **API レスポンス変更・エンドポイント削除**（破壊的変更禁止）
- **ディレクトリ変更・モジュール移動**（アーキテクチャ一貫性のため）
- **依存追加**（ライセンス・セキュリティリスクのため。必要な場合は Issue を作成してレビューを受ける）
- 大規模リファクタ（意図しない挙動変化防止のため）
- AI との会話ログをリポジトリにコミットしない
