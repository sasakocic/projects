.PHONY: build run

build:
	docker build -t skocic/projects:1.0.0-amd64 --platform linux/amd64 .

run:
	docker run --rm -p 3000:3000 projects