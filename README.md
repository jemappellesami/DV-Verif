# DV-Verif — revision for Quantum

Revision of **"Efficient certification of intractable quantum states with
few Pauli measurements"** (S. Abdul Sater, M. Garnier, T. Martinez,
H. Ollivier, U. Chabaud), [arXiv:2511.07300](https://arxiv.org/abs/2511.07300).

Quantum's decision (1 October 2026) was **revise and resubmit**: the paper
is likely to be accepted once all the referees' points, including the minor
ones, are addressed. The referees reviewed **arXiv v2**. This repository
holds that version, the revision (v3) being written from it, the
version-to-version changes, and the reply to the referees.

## Where to start (co-authors)

1. **The referee reports:** [`reviews/DV-Verif-reviews.pdf`](reviews/DV-Verif-reviews.pdf)
   (two referees, three comments each).
2. **What changed, step by step:** [`diffs/`](diffs/README.md). Each step
   has a PDF of the paper with the changes highlighted (blue = added,
   small red = removed), a table of every change with its page and the
   referee comment it answers, and instructions to comment.
3. **The reply to the referees:** [`response/response.tex`](response/response.tex)
   (compiled: `response/response.pdf` once built). Each referee comment has
   a status and a suggested reply, still to be rewritten.
4. **The current text:** [`revision/main.tex`](revision/main.tex).

## Folders

| Folder | Content | Edited? |
|--------|---------|---------|
| [`paper/`](paper/) | The paper as on arXiv (v2), sent to Quantum. Reference point of all the changes. | Never |
| [`revision/`](revision/) | The revision (v3): `main.tex`, bibliography, class and style files, and `figures/` (TikZ sources of the figures with their PDFs; `figpreamble.tex` is shared by the figures). `mkdiff.sh` builds the diffs. | Yes: only `main.tex` (and the figures) |
| [`diffs/`](diffs/README.md) | Version-to-version diffs (PDF and LaTeX source) with a guide for reading and commenting them. | Added at each new version |
| [`response/`](response/) | `response.tex`, the reply to the referees; `reply_example.tex`, the template it follows. | Yes |
| [`reviews/`](reviews/) | Editor's decision and referee reports. | Never |

## Versions

Each version is a git tag, so any two of them can be compared (in
[`diffs/`](diffs/README.md), or on GitHub, for instance
[v3.1 → v3.2](https://github.com/jemappellesami/DV-Verif/compare/v3.1...v3.2)).

| Version | Git tag | What it is |
|---------|---------|------------|
| arXiv v1 | `arxiv-v1` | First arXiv version. Not the one the referees read. (The tag `submitted` is an older, misleading name for the same version.) |
| arXiv v2 | `arxiv-v2` | The version sent to Quantum and reviewed. It is in [`paper/`](paper/). |
| v3.1 | `v3.1` | arXiv v2 + Reviewer 1, comment 2: the cost of certification now depends only on the number `t` of non-stabilizer inputs, not on the number of stabilizer inputs. Also the figures, redrawn in TikZ with the same content. This is the large change. |
| v3.2 | `v3.2` | v3.1 + Reviewer 1, comments 1 and 3, and Reviewer 2, comments 1, 2 and 3 (shorter changes in the text). |
| current | branch `main` | v3.2 + the commits made since (see `git log v3.2..main`). |

The tag `v1-R1.2-done` keeps a first attempt made on arXiv v1 by mistake;
it is superseded by v3.1 and can be ignored.

## Status of the referee comments

| Comment | Topic | In the paper | Reply in the letter |
|---------|-------|--------------|---------------------|
| Reviewer 1, comment 1 | "DFE is information-theoretically optimal" | Done (v3.2), Sec. 2.1 | Suggested, to rewrite |
| Reviewer 1, comment 2 | Complexity in terms of stabilizer and magic inputs | Done (v3.1), Sec. 2.1, 2.2, 3, 4, App. C, Fig. 4 | Suggested, to rewrite; TODO on `1/eps` vs `1/eps^2` |
| Reviewer 1, comment 3 | Fidelity witness vs union bound | Done (v3.2), Sec. 3.2 ("Joint estimation of the witness") | Suggested, to rewrite |
| Reviewer 2, comment 1 | Adversarial cost; `O(n)` measurements per Pauli string | First part done (v3.2), Sec. 3.3; second part TODO | Suggested for the first part; TODO for the second |
| Reviewer 2, comment 2 | Is the acceptance margin realistic? | Done (v3.2), Sec. 3.2 ("Robustness loss") | Suggested, to rewrite |
| Reviewer 2, comment 3 | Position the contribution | Done (v3.2), introduction | Suggested, to rewrite |

Still to do: the second part of Reviewer 2, comment 1; the final replies;
the letter to the editor.

## How to comment

See [`diffs/README.md`](diffs/README.md#how-to-comment): annotate the diff
PDFs, comment on lines of a commit on GitHub, or add `% [initials] ...`
comments in the LaTeX. Please mention the step and the page.

## Building

Each document builds in its own folder with `latexmk` (pdfLaTeX + BibTeX):

```
cd paper    && latexmk -pdf main.tex       # arXiv v2
cd revision && latexmk -pdf main.tex       # the revision
cd response && latexmk -pdf response.tex   # the reply to the referees
```

The figures of the revision are already compiled (`revision/figures/*.pdf`).
To change one, edit its `.tex` in `revision/figures/` and compile it there
(`pdflatex <figure>.tex`).

Diffs (needs `latexdiff`):

```
sh revision/mkdiff.sh              # revision/diff.pdf: changes since the last tag (local)
sh revision/mkdiff.sh arxiv        # revision/diff-arxiv.pdf: all changes since arXiv v2 (local)
sh revision/mkdiff.sh v3.2 v3.3    # diffs/v3.2_to_v3.3.pdf and .tex: a new step, to commit
```

## Conventions

- `paper/` is never edited; all changes go to `revision/`.
- One change per commit, with a message saying which referee comment it
  answers; when a comment is done in the paper, it is marked DONE in
  `response/response.tex`.
- When a version is finished, it is tagged (`v3.3`, ...) and its diff is
  added to [`diffs/`](diffs/README.md).
- Changes to the text are kept minimal and in the vocabulary of the paper.
