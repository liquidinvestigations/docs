#!/bin/bash
set -ex
mkdir -p .local
docker build . --tag li-docs
docker rm -f li-docs || true
docker run -it --rm --name li-docs \
        --user $(id -u):$(id -g) \
        -v $PWD:/app \
        -v $PWD/.local:/.local \
        li-docs \
        bash in-container.sh
