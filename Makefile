.PHONY: build
build:
	mkdocs build

.PHONY: serve
serve:
	mkdocs serve

.PHONY: clean
clean:
	rm -rf site/

.PHONY: fresh
fresh: clean serve

.PHONY: run
run:
	docker run --rm -it -p 8000:8000 -v ${PWD}:/docs squidfunk/mkdocs-material:7.1.5
