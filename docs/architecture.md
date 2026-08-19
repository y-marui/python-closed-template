# Architecture

モジュール・コンポーネント間の依存関係とエントリーポイントを記述する。

## Layer Dependency Direction

```
API → Service → Repository → Storage
```

逆依存・循環依存は禁止。

## Module Structure

| モジュール | 役割 | エントリーポイント |
|---|---|---|
| `core/` | ビジネスロジック | （ここに記述） |
| `api/` | HTTP インターフェース | （ここに記述） |
| `repository/` | データアクセス | （ここに記述） |

---

*このファイルはプロジェクト固有の内容に合わせて更新する。*
