# Contributing Guide

このプロジェクトへの貢献方法・開発ルールをまとめたファイルです。

---

## Development Flow

```
Issue 作成 → feature ブランチ → 実装（AI 支援）→ PR → コードレビュー → main
```

### Branch Strategy

| ブランチ | 用途 |
|---|---|
| `main` | リリース済みの安定版 |
| `develop` | 開発統合ブランチ |
| `feature/*` | 機能開発・バグ修正 |

### Commit Format

[Conventional Commits](https://www.conventionalcommits.org/) に従う。

| プレフィックス | 用途 |
|---|---|
| `feat` | 新機能 |
| `fix` | バグ修正 |
| `refactor` | リファクタリング（機能変更なし） |
| `docs` | ドキュメントのみの変更 |
| `chore` | ビルド・設定・依存関係の変更 |

- **WIP 禁止**: 動作しないコードはコミットしない

---

## Code Design Principles

- **変更範囲は必要最小限**（over-engineering しない、YAGNI 原則）
- **DRY の判断**: 2回の重複では抽象化しない、3回目で検討
- **既存コードの再利用**: 新規実装前に類似機能がないか確認する
- **既存パターンに従う**: 命名規則・ディレクトリ構造・アーキテクチャ
- **TODO/FIXME を残さない**: 実装するか Issue に記録する

---

## Code Style

- 関数は 50 行以内、単一責務
- コメントは「なぜそうするか」のみ書く（コードから自明な処理には書かない）
- デバッグ用 `print` 文を本番コードに残さない

---

## Naming Conventions

| 対象 | 規則 | 例 |
|---|---|---|
| 変数・関数 | snake_case | `get_user_id` |
| クラス | PascalCase | `UserRepository` |
| 定数 | UPPER_SNAKE_CASE | `MAX_RETRY_COUNT` |
| モジュール | snake_case | `user_service.py` |
| ブランチ | `feature/issue-{番号}-{概要}` | `feature/issue-42-add-auth` |

---

## Code Review Checklist

### PR Author

- [ ] テストが全件通過している（`make all`）
- [ ] 新機能にテストを追加した
- [ ] ドキュメントを必要に応じて更新した
- [ ] シークレット・ローカルパスがコードに含まれていない
- [ ] AI が生成したコードをレビューしてからコミットした

### Reviewer

- [ ] ロジックが要件を満たしている
- [ ] テストカバレッジが十分
- [ ] 命名規則に従っている
- [ ] 不要な依存追加がない
- [ ] セキュリティリスクがない

---

## CI

```
lint（ruff check / ruff format --check / mypy）→ test（pytest）→ build（インストール可能性確認）
```

`build` が Branch Protection の必須ステータスチェック。全て通過しないと PR はマージ不可。

| コマンド | 内容 |
|---|---|
| `make lint` | ruff によるコードチェック |
| `make type` | mypy による型チェック |
| `make test` | pytest によるテスト実行 |
| `make all` | lint + type + test を一括実行 |
