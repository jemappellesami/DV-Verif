#!/bin/sh
# Build latexdiffs of the revision. Run from anywhere.
#
#   sh revision/mkdiff.sh
#       revision/diff.pdf: the working revision (revision/main.tex, even
#       uncommitted) against the last finished version (BASELINE below).
#       For the author, while editing; not committed.
#
#   sh revision/mkdiff.sh arxiv
#       revision/diff-arxiv.pdf: the working revision against the paper on
#       arXiv (paper/main.tex). Not committed.
#
#   sh revision/mkdiff.sh FROM TO
#       diffs/FROM_to_TO.pdf and diffs/tex/FROM_to_TO.tex: the changes
#       between two versions, given as git tags (arxiv-v2 for the paper on
#       arXiv, then v3.1, v3.2, ...). Both files are meant to be committed,
#       for the co-authors (see diffs/README.md).
#
# Deletions are in small red text, additions in blue sans-serif text (colour
# markup only, so that long formulas still break across lines; a changed
# equation is shown entirely as deleted and added, which latexdiff needs
# for the large aligned equations of the proofs).
# The build happens in a temporary folder, so it does not clash with an
# editor compiling in revision/; only the outputs are copied back.
set -e
BASELINE=v3.2
HERE="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$HERE/.." && pwd)"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

# main.tex of a version: arXiv tags hold it in paper/, revision tags in
# revision/.
source_of() {
  case "$1" in
    arxiv-*) git -C "$ROOT" show "$1:paper/main.tex" ;;
    *)       git -C "$ROOT" show "$1:revision/main.tex" ;;
  esac
}

if [ $# -eq 2 ]; then
  FROM=$1; TO=$2; NAME="${FROM}_to_${TO}"
  # The revision folder as it was at version TO (figures, bibliography...).
  git -C "$ROOT" archive "$TO" revision | tar -x -C "$TMP"
  cd "$TMP/revision"
  # Highlighting of the changes (red text and tags) is switched off, as
  # latexdiff marks the changes itself.
  source_of "$FROM" | sed 's/\\highlightchangestrue/\\highlightchangesfalse/' > old.tex
  source_of "$TO" | sed 's/\\highlightchangestrue/\\highlightchangesfalse/' > main.tex
  latexdiff --type=CFONT --math-markup=whole old.tex main.tex > diff.tex
  latexmk -pdf -interaction=nonstopmode -halt-on-error diff.tex
  mkdir -p "$ROOT/diffs/tex"
  cp diff.pdf "$ROOT/diffs/$NAME.pdf"
  # The .tex, made to compile from diffs/tex/ with the class, style,
  # bibliography and figures of revision/.
  sed -e 's|^\\documentclass\[\(.*\)\]{quantumarticle}|\\documentclass[\1]{../../revision/quantumarticle}|' \
      -e 's|^\\begin{document}|\\graphicspath{{../../revision/}}\
\\begin{document}|' \
      -e 's|\\usepackage{env}|\\usepackage{../../revision/env}|' \
      -e 's|\\bibliographystyle{linksen}|\\bibliographystyle{../../revision/linksen}|' \
      -e 's|\\bibliography{bibliography}|\\bibliography{../../revision/bibliography}|' \
      diff.tex > "$ROOT/diffs/tex/$NAME.tex"
  echo "Written: $ROOT/diffs/$NAME.pdf and $ROOT/diffs/tex/$NAME.tex"
  exit 0
fi

cp -R "$HERE"/. "$TMP"/
if [ "$1" = "arxiv" ]; then
  cp "$ROOT/paper/main.tex" "$TMP/old.tex"
  OUT=diff-arxiv.pdf
else
  source_of "$BASELINE" > "$TMP/old.tex"
  OUT=diff.pdf
fi
cd "$TMP"
# Highlighting of the changes switched off, as latexdiff marks them itself.
for f in old.tex main.tex; do
  sed 's/\\highlightchangestrue/\\highlightchangesfalse/' "$f" > "$f.tmp" && mv "$f.tmp" "$f"
done
latexdiff --type=CFONT --math-markup=whole old.tex main.tex > diff.tex
latexmk -pdf -interaction=nonstopmode -halt-on-error diff.tex
cp diff.pdf "$HERE/$OUT"
echo "Written: $HERE/$OUT"
