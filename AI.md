# AI Guide

このファイルはAI開発ツールの入口です。

対象AI
- Claude Code
- GitHub Copilot

## ディレクトリの役割

### docs/ — 人間が書き・読む仕様書
- 詳細な設計・仕様を記述する
- AIは参照のみ。直接編集しない
- 更新権限: 人間の開発者のみ

### ai/context/ — AIが毎回読み込む要約・制約
- docs/ の内容を簡潔に要約したもの
- AIへの具体的な制約・ルールを記述する
- docs/ と重複する場合は ai/context/ を優先する

## 読み込み順序
1. PROJECT_CONTEXT.md
2. ai/context/（全ファイル）
3. docs/specification.md（詳細が必要な場合のみ）
4. docs/architecture.md（詳細が必要な場合のみ）
5. docs/guardrails.md

## AIルール
- API仕様変更禁止（破壊的変更で他サービスに影響するため）
- 設計変更禁止（アーキテクチャの一貫性を保つため）
- 大規模リファクタ禁止（意図しない挙動変化を防ぐため）
- 依存追加禁止（ライセンス・セキュリティリスクを人間がレビューするため）

## 不明点
1. 推測しない
2. TODOを書く
3. Issue提案
