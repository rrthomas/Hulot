# Makefile for Hulot
#
# Copyright (C) Reuben Thomas 2012-2023
# See COPYING for license

test:
	tox

dist:
	git diff --exit-code && \
	rm -rf ./dist && \
	mkdir dist && \
	python -m build

release-pypi:
	twine upload dist/*

release:
	make test
	make dist
	version=$$(grep version pyproject.toml | grep -o "[0-9.]\+") && \
	twine upload dist/* && \
	gh release create v$$version --title "Release v$$version" dist/* && \
	git pull --tags

loc:
	cloc hulot
#cloc tests/*.py

.PHONY:	dist
