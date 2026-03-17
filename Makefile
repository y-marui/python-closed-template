.PHONY: install lint type test all setup-hooks install-charter update-charter

install:
	poetry install

lint:
	poetry run ruff check .

type:
	poetry run mypy src

test:
	poetry run pytest

all: lint type test

## dev-charter ヘルパー

# セキュリティフックの初回セットアップ（SECURITY_POLICY.md 参照）
setup-hooks:
	cp docs/dev-charter/.pre-commit-config.yaml .
	cp docs/dev-charter/.gitleaks.toml .
	git config core.hooksPath 2>/dev/null \
		&& echo "core.hooksPath が設定されています。pre-commit run --all-files で動作確認してください。" \
		|| pre-commit install
	pre-commit run --all-files

# dev-charter を初回インストール（未追加のリポジトリ向け）
install-charter:
	git remote add dev-charter https://github.com/y-marui/dev-charter || true
	git fetch dev-charter
	git subtree add --prefix=docs/dev-charter dev-charter main --squash

# dev-charter を最新版に更新
update-charter:
	git subtree pull --prefix=docs/dev-charter dev-charter main --squash
