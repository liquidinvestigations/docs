#!/bin/bash -ex

for repo in $(find clones -mindepth 2 -maxdepth 2 -type d); do
  (
    cd $repo
    "$@"
  ) &
done
wait
