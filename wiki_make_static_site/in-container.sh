#!/bin/bash -ex

DOCS_DIR=docs
SITE_DIR=site
OUT_DIR=output
WIKI_REPO_LINK="https://github.com/liquidinvestigations/docs.wiki.git"

sudo rm -rf $DOCS_DIR $SITE_DIR
mkdir -p $DOCS_DIR
git clone $WIKI_REPO_LINK $DOCS_DIR
# mkdocs really wants this filename
mv $DOCS_DIR/Home.md $DOCS_DIR/index.md


mkdocs build


# after docs build, replace github repo blob links with github raw user content links
grep -r -i -ohI 'https://github.com[^ "]\+\.\(jpg\|jpeg\|png\|gif\|svg\)' $SITE_DIR | sort -u > original-links.txt
python fix-links.py

# fetch all outgoing links as local files
grep -rEohI "(http|https)://[a-zA-Z0-9./?=_%:-]*" $SITE_DIR | sort -u > all-links.txt
python save-assets.py

rm -rf $OUT_DIR
mkdir -p $OUT_DIR
( shopt -s dotglob ; cd site; zip -r ../$OUT_DIR/docs.zip * )
