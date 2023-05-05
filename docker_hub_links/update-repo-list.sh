#!/bin/bash -ex

ORG=liquidinvestigations
# curl -q "https://api.github.com/orgs/$ORG/repos?per_page=100" > github-repo-info.json

# cat github-repo-info.json | jq '.[] | select(.private==false) | select(.archived==false)|select(.disabled==false)|select(.fork==false).full_name' | tr -d '"' > repos.txt

cat github-repo-info.json | jq '.[] | select(.private==false) | select(.disabled==false).full_name' | tr -d '"' | sort -u > repos.txt

