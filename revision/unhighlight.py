#!/usr/bin/env python3
"""Remove the highlighting of the changes from a revision source, for
latexdiff: \\rev{TAG}{text} and \\revother{text} become text, and
\\revtag{TAG} is removed. Reads stdin, writes stdout."""
import re, sys

def matching(s, i):
    """Index of the brace closing the one opened at s[i]."""
    depth = 0
    while i < len(s):
        c = s[i]
        if c == '\\':
            i += 2
            continue
        if c == '{':
            depth += 1
        elif c == '}':
            depth -= 1
            if depth == 0:
                return i
        i += 1
    raise ValueError('unbalanced braces')

def unwrap(s):
    out = []
    i = 0
    pat = re.compile(r'\\(rev|revother|revtag)(?![A-Za-z])\s*')
    while True:
        m = pat.search(s, i)
        if not m or s.startswith('\\newcommand', m.start() - 11) or s.startswith('\\newcommand{', m.start() - 12):
            if not m:
                out.append(s[i:])
                return ''.join(out)
            out.append(s[i:m.end()]); i = m.end(); continue
        out.append(s[i:m.start()])
        j = m.end()
        if j >= len(s) or s[j] != '{':
            out.append(s[m.start():j]); i = j; continue
        name = m.group(1)
        if name in ('rev', 'revtag'):          # drop the tag argument
            j = matching(s, j) + 1
            if name == 'revtag':
                i = j
                continue
        k = matching(s, j)                     # the text argument
        out.append(unwrap(s[j + 1:k]))
        i = k + 1

src = sys.stdin.read()
# keep the macro definitions of the preamble untouched
head, sep, body = src.partition('\\begin{document}')
sys.stdout.write(head + sep + unwrap(body) if sep else unwrap(src))
