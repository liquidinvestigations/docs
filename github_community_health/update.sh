#!/bin/bash -ex

ROOT=$(pwd)
for repo in $(find clones -mindepth 2 -maxdepth 2 -type d); do
  (
    cd $repo
    rm -rf LICENSE.md LICENSE .github
    cp -a $ROOT/files/{LICENSE,.github} .
    git add .
    git commit -m "update license, contrib guide etc"
  )
done

echo "please inspect the repos and run './forall.sh git push'"
