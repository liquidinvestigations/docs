#!/bin/bash -ex

rm -rf ./clones
while read repo; do
    repo_dir="./clones/$repo"
    mkdir -p $repo_dir
    git clone  "git@github.com:$repo" "$repo_dir" &
done < ./repos.txt
wait

