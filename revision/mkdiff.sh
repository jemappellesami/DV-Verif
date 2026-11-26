#!/bin/sh
# Build a latexdiff of the revision (revision/main.tex) against a reference:
#   sh revision/mkdiff.sh          -> revision/diff.pdf, against the current
#                                     baseline (git tag below): the changes
#                                     made since the last finished comment
#   sh revision/mkdiff.sh arxiv    -> revision/diff-arxiv.pdf, against the
#                                     paper on arXiv (paper/main.tex): all
#                                     the changes of the revision
# Deletions in small red text, additions in blue sans-serif text (colour
# markup only, so that long formulas still break across lines).
# The build happens in a temporary folder, so it does not clash with an
# editor compiling in revision/; only the PDF is copied back.
set -e
BASELINE=R1.2-done
HERE="$(cd "$(dirname "$0")" && pwd)"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
cp -R "$HERE"/. "$TMP"/
if [ "$1" = "arxiv" ]; then
  cp "$HERE/../paper/main.tex" "$TMP/old.tex"
  OUT=diff-arxiv.pdf
else
  git -C "$HERE/.." show "$BASELINE:revision/main.tex" > "$TMP/old.tex"
  OUT=diff.pdf
fi
cd "$TMP"
latexdiff --type=CFONT old.tex main.tex > diff.tex
latexmk -pdf -interaction=nonstopmode -halt-on-error diff.tex
cp diff.pdf "$HERE/$OUT"
echo "Written: $HERE/$OUT"
