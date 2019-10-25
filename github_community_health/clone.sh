#!/bin/bash -ex

rm -rf ./clones
while read repo; do
    repo_dir="./clones/$(echo $repo | cut -d: -f2)"
    mkdir -p $repo_dir
    git clone $repo $repo_dir
done < ./repos
