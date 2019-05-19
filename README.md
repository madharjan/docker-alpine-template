# docker-template

[![Build Status](https://travis-ci.com/madharjan/docker-template.svg?branch=master)](https://travis-ci.com/madharjan/docker-template)
[![Layers](https://images.microbadger.com/badges/image/madharjan/docker-template.svg)](http://microbadger.com/images/madharjan/docker-template)

Docker container with Template Client based on [gliderlabs/alpine](https://github.com/gliderlabs/docker-alpine/)

## Features

* Bats [bats-core/bats-core](https://github.com/bats-core/bats-core) based test cases

## Template Client 1.0 (docker-template)

### Environment

| Variable             | Default      | Example        |
|----------------------|--------------|----------------|
| TEMPLATE_HOST        |              | 192.168.1.1    |
| TEMPLATE_USERNAME    | postgres     | myuser         |
| TEMPLATE_PASSWORD    |              | mypass         |

## Build

```bash
# clone project
git clone https://github.com/madharjan/docker-template
cd docker-template

# login to DockerHub
docker login

# build
make

# tests
make run
make test

# clean
make clean
```

## Run

### Template Server (docker-template)

```bash
# stop & remove previous instances
docker stop template
docker rm template
# run container
docker run -d \
  -e TEMPLATE_PASSWORD=mypass \
  --name template \
  madharjan/docker-template:1.0
```

### Template Client (docker-template)

```bash
# psql console
docker run --rm -it \
  --link template:db \
  -e TEMPLATE_HOST=db \
  -e TEMPLATE_PASSWORD=mypass \
  madharjan/docker-template:1.0

# psql script
docker run --rm -it \
  --link template:db \
  -e TEMPLATE_HOST=db \
  -e TEMPLATE_PASSWORD=mypass \
  madharjan/docker-template:1.0 \
  -c 'select user from user'
```

### Cleanup

```bash
docker stop template
docker rm template

``
