sources = {{ cookiecutter.pkg_name }}

.PHONY: test format lint unittest coverage pre-commit clean
test: format lint unittest

format:
	isort $(sources) tests
	black $(sources) tests

lint:
	flake8 $(sources) tests
	{%- if cookiecutter.use_mypy == 'y' %}
	mypy $(sources) tests
	{%- endif %}

unittest:
	pytest

coverage:
	pytest --cov=$(sources) --cov-branch --cov-report=term-missing tests

pre-commit:
	pre-commit run --all-files

clean:
	rm -rf {% if cookiecutter.use_mypy == 'y' -%}.mypy_cache {% endif -%} .pytest_cache
	rm -rf *.egg-info
	rm -rf .tox dist site
	rm -rf coverage.xml .coverage
