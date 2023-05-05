#!/bin/bash -ex

DOCS_DIR=docs
WIKI_REPO_LINK="https://github.com/liquidinvestigations/docs.wiki.git"

sudo rm -rf $DOCS_DIR
mkdir -p $DOCS_DIR
git clone $WIKI_REPO_LINK $DOCS_DIR
(
        cd $DOCS_DIR
        git pull
        ln -s Home.md index.md
)


pipenv install
pipenv run mkdocs build
