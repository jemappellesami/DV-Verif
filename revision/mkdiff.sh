#!/bin/sh
# Build diff.pdf: the changes of the revision (revision/main.tex) with
# respect to the paper on arXiv (paper/main.tex), deletions in red and
# additions in blue. Run from anywhere: sh revision/mkdiff.sh
set -e
cd "$(dirname "$0")"
latexdiff ../paper/main.tex main.tex > diff.tex
latexmk -pdf -interaction=nonstopmode diff.tex
