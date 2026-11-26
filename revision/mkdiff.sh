#!/bin/sh
# Build diff.pdf: the changes of the revision (revision/main.tex) with
# respect to the paper on arXiv (paper/main.tex): deletions in small red
# text, additions in blue sans-serif text (colour markup only, so that long
# formulas still break across lines). Run from anywhere: sh revision/mkdiff.sh
# The build happens in a temporary folder, so it does not clash with an
# editor compiling in revision/; only diff.pdf is copied back.
set -e
HERE="$(cd "$(dirname "$0")" && pwd)"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
cp -R "$HERE"/. "$TMP"/
cd "$TMP"
latexdiff --type=CFONT "$HERE/../paper/main.tex" main.tex > diff.tex
latexmk -pdf -interaction=nonstopmode -halt-on-error diff.tex
cp diff.pdf "$HERE/diff.pdf"
echo "Written: $HERE/diff.pdf"
