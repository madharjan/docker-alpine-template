
NAME = madharjan/docker-alpine-template
VERSION = 1.0

DEBUG ?= true

DOCKER_USERNAME ?= $(shell read -p "DockerHub Username: " pwd; echo $$pwd)
DOCKER_PASSWORD ?= $(shell stty -echo; read -p "DockerHub Password: " pwd; stty echo; echo $$pwd)
DOCKER_LOGIN ?= $(shell cat ~/.docker/config.json | grep "docker.io" | wc -l)

.PHONY: all build run test stop clean tag_latest release clean_images

all: build

docker_login:
ifeq ($(DOCKER_LOGIN), 1)
		@echo "Already login to DockerHub"
else
		@docker login -u $(DOCKER_USERNAME) -p $(DOCKER_PASSWORD)
endif

build:
	docker build \
		--build-arg TEMPLATE_VERSION=$(VERSION) \
		--build-arg VCS_REF=`git rev-parse --short HEAD` \
		--build-arg DEBUG=${DEBUG} \
		-t $(NAME):$(VERSION) --rm .

run:
	@if ! docker images $(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME) version $(VERSION) is not yet built. Please run 'make build'"; false; fi

test:
	sleep 1
	./bats/bin/bats test/tests.bats

stop:

clean: stop

publish: docker_login run test clean
	docker push $(NAME)

tag_latest:
	docker tag $(NAME):$(VERSION) $(NAME):latest

release: docker_login  run test clean tag_latest
	docker push $(NAME)

clean_images: clean
	docker rmi $(NAME):latest $(NAME):$(VERSION) 2> /dev/null || true
	docker logout 


