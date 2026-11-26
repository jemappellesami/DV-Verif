# Changes of the revision, version by version

This folder shows what changed in the paper between consecutive versions of
the revision for Quantum, so that each step can be read and commented on
separately. Start from the paper on arXiv (v2, the version the referees
read), then read each step in order.

| # | Read this | Changes from → to | What it covers |
|---|-----------|-------------------|----------------|
| 1 | [`arxiv-v2_to_v3.1.pdf`](arxiv-v2_to_v3.1.pdf) | arXiv v2 → v3.1 | Reviewer 1, comment 2 (the large change): the cost of certification depends only on the number of non-stabilizer inputs. Also the figures, redrawn in TikZ. |
| 2 | [`v3.1_to_v3.2.pdf`](v3.1_to_v3.2.pdf) | v3.1 → v3.2 | Reviewer 1, comments 1 and 3; Reviewer 2, comments 1, 2 and 3; two small notation fixes. |
| – | [`arxiv-v2_to_v3.2.pdf`](arxiv-v2_to_v3.2.pdf) | arXiv v2 → v3.2 | Steps 1 and 2 together: everything changed since arXiv (this is the "version with the changes highlighted" Quantum asks for). |

Each PDF is the full paper with the changes marked:

- **added text** is in blue sans-serif;
- **removed text** is in small red;
- a **changed equation** is shown entirely, once removed (red) and once
  added (blue), even if only one symbol changed;
- figures are always the new ones (the diff cannot mark changes inside a
  figure; changed figures are listed below).

The page numbers below are those of the diff PDFs.

The current text of the revision is [`revision/main.tex`](../revision/main.tex),
the paper on arXiv is [`paper/main.tex`](../paper/main.tex), and the reply to
the referees is [`response/response.tex`](../response/response.tex) (with a
status and a suggested reply for each comment). The referee reports are in
[`reviews/`](../reviews/).

---

## Step 1: arXiv v2 → v3.1 — Reviewer 1, comment 2

[`arxiv-v2_to_v3.1.pdf`](arxiv-v2_to_v3.1.pdf) · source
[`tex/arxiv-v2_to_v3.1.tex`](tex/arxiv-v2_to_v3.1.tex) · git tags `arxiv-v2`
→ `v3.1`

The referee suggested expressing the sample complexity in terms of the
numbers of stabilizer and magic inputs. The protocol now treats all the
stabilizer inputs as one block and each non-stabilizer input as its own
block, so that the number of copies depends only on the number `t` of
non-stabilizer inputs: `O((1+t)^2/eps^2 log(1/delta))` instead of
`O(n^2/eps^2 log(1/delta))`, with acceptance for `F >= 1 - eps/(3(1+t))`
instead of `1 - eps/(3n)`.

| Where | What changed | Page |
|-------|--------------|------|
| Sec. 2.1 (DFE) | For a stabilizer state, DFE needs `O(eps^-2 log(1/delta))` copies, independently of the dimension (new reference DHZ20). | 4 |
| Sec. 2.2 (fidelity witnesses) | Block fidelity witness and its robustness `1 - B(1-F) <= W <= F` for `B` blocks. | 5 |
| Sec. 3 (introduction) | Completeness parameter `eps/(3(1+t))`; new i.i.d. and non-i.i.d. scalings. | 6 |
| Sec. 3.1 (notations) | Stabilizer inputs gathered in the first `s` qubits (block `S`), the `t` others are single-qubit blocks; new normalization `m = 2 + sum_{i in M} ||chi_psi_i||_1`; distributions `mu(b)` and `D_psi_b` on blocks, with their interpretation (stabilizer test with probability `2/m`, test of a non-stabilizer qubit with probability `||chi_psi_i||_1/m`). | 6 |
| Sec. 3.2 (Protocol 1) | Sample a block `b` and a Pauli operator on it; output `W = 1-(1+t)+m X`. | 7 |
| Sec. 3.2 (after Protocol 1) | Explanation of the protocol: back-propagation recovers the product structure, DFE on each block. | 7 |
| Sec. 3.2 (Theorem 1) | `N_iid in O((1+t)^2/eps^2 log(1/delta))`, acceptance for `F >= 1 - eps/(3(1+t))`. | 7 |
| Sec. 3.2 (proof of Theorem 1) | Same proof on blocks, with the derivation written line by line. | 8–9 |
| Figure 4 and caption | The protocol figure shows the two kinds of tests and groups the wires into the block `S` and a qubit `i`. | 10 |
| Sec. 3.3 (Theorem 2) | Acceptance for `F >= 1 - eps/(3(1+t))`; adversarial scaling `O~(n(1+t)^4/(delta^2 eps^6))` instead of `O~(n^5/...)`, and why a factor `n` remains. | 10–11 |
| Sec. 4 (theorem) | Completeness for `F >= 1 - eps/(3(1+t))`. | 12 |
| App. C (Lemma 2) | Thresholds `1 - eps/(3(1+t))`. | 17–18 |

Figures (not marked in the diff): figures 1, 3, 4 and 5 are redrawn in TikZ
(sources in [`revision/figures/`](../revision/figures/)), with the same
content and colours as on arXiv; figure 4 then changes for this comment (see
the table). Figure 2 is unchanged.

Commits of this step (each one can be opened and commented on GitHub):

- [`f7c9bdd`](https://github.com/jemappellesami/DV-Verif/commit/f7c9bdd) revision/: restart from arXiv v2 (v3.0 = v2)
- [`69d71fe`](https://github.com/jemappellesami/DV-Verif/commit/69d71fe) Figures 3 and 5 (back-propagation, adversarial): TikZ
- [`6b265fc`](https://github.com/jemappellesami/DV-Verif/commit/6b265fc) Figure 1 (CPS): redraw in TikZ
- [`90f857f`](https://github.com/jemappellesami/DV-Verif/commit/90f857f) Figure 4 (protocol): redraw in TikZ
- [`053ee78`](https://github.com/jemappellesami/DV-Verif/commit/053ee78) R1.2, point 1: DFE of stabilizer states (Section 2.1)
- [`bc933c7`](https://github.com/jemappellesami/DV-Verif/commit/bc933c7) R1.2, point 2: block fidelity witness (Section 2.2)
- [`882eabb`](https://github.com/jemappellesami/DV-Verif/commit/882eabb) R1.2, point 3: Section 3.1 notations on blocks
- [`e1bc517`](https://github.com/jemappellesami/DV-Verif/commit/e1bc517) R1.2, point 4: protocol on blocks (Protocol 1)
- [`3771bd5`](https://github.com/jemappellesami/DV-Verif/commit/3771bd5) R1.2, point 5: intuition of the protocol (after Protocol 1)
- [`2eaf287`](https://github.com/jemappellesami/DV-Verif/commit/2eaf287) R1.2, point 6: Theorem 1 scaling with the number of magic inputs
- [`7c0221f`](https://github.com/jemappellesami/DV-Verif/commit/7c0221f) R1.2, point 7: proof of Theorem 1 on blocks
- [`8c014ea`](https://github.com/jemappellesami/DV-Verif/commit/8c014ea) R1.2: scaling beyond i.i.d. (Sections 3.3, 4, Appendix C)
- [`3bdfdbd`](https://github.com/jemappellesami/DV-Verif/commit/3bdfdbd) R1.2: figure 4 on blocks and its caption
- [`047d4d5`](https://github.com/jemappellesami/DV-Verif/commit/047d4d5) Response letter: R1.2

---

## Step 2: v3.1 → v3.2 — the other referee comments

[`v3.1_to_v3.2.pdf`](v3.1_to_v3.2.pdf) · source
[`tex/v3.1_to_v3.2.tex`](tex/v3.1_to_v3.2.tex) · git tags `v3.1` → `v3.2`

| Where | What changed | Referee comment | Page |
|-------|--------------|-----------------|------|
| Introduction | "we combine existing techniques, namely ..." | Reviewer 2, comment 3 (position the contribution) | 3 |
| Sec. 2.1 (DFE) | The `eps^-2` dependence is optimal for fidelity estimation; the dependence in `d` is not universally optimal (`O(2^n)` in the worst case, `O(1)` for stabilizer states), which is why DFE is used here only on small systems and stabilizer states. | Reviewer 1, comment 1 ("information-theoretically optimal") | 4 |
| Sec. 3 (introduction) | Completeness and soundness variables renamed `eps_c` and `eps_s` (`s` is now the number of stabilizer inputs). | – (notation) | 6 |
| Sec. 3.2, new paragraph "Joint estimation of the witness" | Estimating each block separately with a union bound would cost `t^3`; the joint estimator costs `t^2`. | Reviewer 1, comment 3 (witness vs union bound) | 9 |
| Sec. 3.2, new paragraph "Robustness loss" | Why there is a loss in robustness, why it is linear in `1+t`, and why it is realistic for fault-tolerant resource states. | Reviewer 2, comment 2 (is the margin realistic?) | 10 |
| Sec. 3.3, after Theorem 2 | The adversarial cost is large because the approach is generic; optimizing it is left to future work, as was done for stabilizer states. | Reviewer 2, comment 1 (adversarial cost) | 11 |
| App. C, before Lemma 2 | Lemma 2 adapts the result of [FKMO24] to our completeness and soundness parameters. | – (precision) | 17 |

Not addressed yet: the second half of Reviewer 2, comment 1 (a sampled
Pauli string can involve `O(n)` elementary measurements).

Commits of this step:

- [`9fe97a0`](https://github.com/jemappellesami/DV-Verif/commit/9fe97a0) Section 3: completeness and soundness variables eps_c and eps_s
- [`5c8c5ee`](https://github.com/jemappellesami/DV-Verif/commit/5c8c5ee) Appendix C: Lemma 2 stated with our completeness and soundness parameters
- [`8b91db4`](https://github.com/jemappellesami/DV-Verif/commit/8b91db4) R2 C3: position the contribution as a combination of existing techniques
- [`c1c95cf`](https://github.com/jemappellesami/DV-Verif/commit/c1c95cf) R1 C1: optimality of DFE (Section 2.1)
- [`e3f59b1`](https://github.com/jemappellesami/DV-Verif/commit/e3f59b1) R1 C3: joint estimation of the witness vs block-by-block
- [`cbbeaf9`](https://github.com/jemappellesami/DV-Verif/commit/cbbeaf9) R2 C2: robustness loss
- [`f722202`](https://github.com/jemappellesami/DV-Verif/commit/f722202) R2 C1: adversarial sample complexity
- [`cb2bb2b`](https://github.com/jemappellesami/DV-Verif/commit/cb2bb2b) Response letter: suggested replies

---

## How to comment

Use whichever is easiest for you; please say which step and page you are
commenting on.

1. **On the PDF.** Annotate the diff PDF of a step (highlights and notes in
   Preview, Acrobat, or any PDF reader) and send it back, or commit it in
   `diffs/comments/` with your initials in the file name, for instance
   `diffs/comments/v3.1_to_v3.2_UC.pdf`.
2. **On GitHub, line by line.** Open one of the commits listed above, find
   the changed lines of `revision/main.tex`, and click the `+` next to a
   line to leave a comment on it. Everyone with access to the repository
   sees it.
3. **In the source.** Open the `.tex` of a step (in [`tex/`](tex/)) or
   `revision/main.tex`, and add a LaTeX comment where you want to react,
   for instance `% [UC] I would rather say ...`. Commit it, or send the
   file.

For a question on the whole step rather than a line, a GitHub issue titled
with the step (for instance "v3.1 → v3.2: robustness paragraph") works well.

## Compiling a `.tex` of this folder

The files in [`tex/`](tex/) are the latexdiff sources of the PDFs above.
They use the class, style, bibliography and figures of `revision/`, so
compile them from `diffs/tex/` in a copy of the whole repository:

```
cd diffs/tex
latexmk -pdf v3.1_to_v3.2.tex
```

(LaTeX prints a harmless warning about the path of the class and style
files.) The figures are always those of the current `revision/figures/`,
whereas the PDFs of this folder were built with the figures of each
version.

## How these files are made (for the author)

When a version is finished, it gets a git tag (`v3.1`, `v3.2`, ...) and its
step is added to this folder with

```
sh revision/mkdiff.sh v3.2 v3.3
sh revision/mkdiff.sh arxiv-v2 v3.3
```

which write `diffs/v3.2_to_v3.3.pdf` and `diffs/tex/v3.2_to_v3.3.tex` (and
the cumulative diff from arXiv). While editing, `sh revision/mkdiff.sh`
alone writes `revision/diff.pdf`, the changes since the last tag (not
committed).

Versions (git tags): `arxiv-v1` and `arxiv-v2` are the two arXiv versions
(v2 was sent to Quantum); `v3.1`, `v3.2`, ... are the versions of the
revision. The tag `submitted` is an old name for arXiv v1.
