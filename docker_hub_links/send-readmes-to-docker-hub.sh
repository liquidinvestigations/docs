#!/bin/bash -ex

. .env

ROOT=$(pwd)
touch $ROOT/errors.txt

for repo in $(find clones -type f -name 'Dockerfile*' | cut -d'/' -f2-3); do
  export repo_prefix=$(echo "$repo" | cut -d'/' -f1)
  export repo_name=$(echo "$repo" | cut -d'/' -f2)
  (
    cd clones/$repo
    # put away all the past changes
    git clean -f || true
    git stash || true
    # this script really wants README.md
    if [[ -f "readme.md" ]]; then cp readme.md README.md; fi
    if [[ -f "Readme.md" ]]; then cp Readme.md README.md; fi
    if [[ -f "README" ]]; then cp README README.md; fi
    touch README.md
    # 
    touch README_PRE
    echo "
# Liquid Investigations
This Repository is part of Liquid Investigations.

- [Source Code for $repo_name](https://github.com/$repo_prefix/$repo_name.git)
- [Project Home Page](https://github.com/liquidinvestigations/docs/wiki)
- [Security]( https://github.com/liquidinvestigations/docs/wiki/Security)
- [Contribution Guide](https://github.com/liquidinvestigations/docs/wiki/Contributing)
- [Code of Conduct](https://github.com/liquidinvestigations/docs/blob/37c1fd98b643a10a321ae124f2636ce738cb159d/github_community_health/files/.github/CODE_OF_CONDUCT.md)

---


" > README_PRE

    echo "$(cat README_PRE)

$(cat README.md)
" > README.md

    ( docker run --rm \
      -v "$PWD:/data/" \
      -e DOCKERHUB_USERNAME=$DOCKER_USER \
      -e DOCKERHUB_PASSWORD=$DOCKER_PASS \
      -e DOCKERHUB_REPO_PREFIX=$repo_prefix \
      -e DOCKERHUB_REPO_NAME=$repo_name \
      sheogorath/readme-to-dockerhub ) || ( echo "$repo"  > $ROOT/errors.txt )
    git clean -f || true
    git stash || true
  )
done
wait
