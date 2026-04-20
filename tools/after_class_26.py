#!/usr/bin/env python3
"""Post-conversion patches for site/class/class-26.qmd.

Issue fixed:
- Prep item 6 introduces the loglikelihood $\\ell_5$ but the derivative labels,
  critical-point reference, and fitted-model reference were copy-pasted from the
  $\\ell_1$ block in the wiki source (Prep.26). Corrects those to $\\ell_5$ / $f_5$.

Run after pmwiki_to_quarto.py if Prep.26 is re-synced from the wiki.
"""
from pathlib import Path

QMD = Path(__file__).parent.parent / "site" / "class" / "class-26.qmd"

REPLACEMENTS = [
    ("$ \\frac{d\\ell_1}{da_1} = 1386372 - 225775231a_1 $",
     "$ \\frac{d\\ell_5}{da_1} = 1386372 - 225775231a_1 $"),
    ("$ \\frac{d^2\\ell_1}{da_1^2} = -225775231 $",
     "$ \\frac{d^2\\ell_5}{da_1^2} = -225775231 $"),
    ("- Find the critical points of $\\ell_1$.\n- Use the second derivative test to determine if the critical points are locations of maxima or minima.\n- State the value of $a_1$ that gives the location of the maximum of loglikelihood (or maximum loglikelihood).\n    - Note: This is the same value that give the location of the maximum of the likelihood (or maximum likelihood).\n- Plot the lightbulb data (using the seed 123) along with the fitted model $ f_1(t) $",
     "- Find the critical points of $\\ell_5$.\n- Use the second derivative test to determine if the critical points are locations of maxima or minima.\n- State the value of $a_1$ that gives the location of the maximum of loglikelihood (or maximum loglikelihood).\n    - Note: This is the same value that give the location of the maximum of the likelihood (or maximum likelihood).\n- Plot the lightbulb data (using the seed 123) along with the fitted model $ f_5(t) $"),
]


if __name__ == "__main__":
    text = QMD.read_text()
    for old, new in REPLACEMENTS:
        text = text.replace(old, new)
    QMD.write_text(text)
    print(f"Patched {QMD.name}")
