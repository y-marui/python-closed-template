.PHONY: install lint type test all

install:
	poetry install

lint:
	poetry run ruff check .

type:
	poetry run mypy src

test:
	poetry run pytest

all: lint type test
