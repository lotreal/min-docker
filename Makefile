.PHONY: build
build:
	docker build . -t lotreal/min-docker:latest

run:
	docker run --rm -p 80:8000 lotreal/min-docker:latest

push:
	docker push lotreal/min-docker:latest
