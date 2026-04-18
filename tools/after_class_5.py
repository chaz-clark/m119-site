#!/usr/bin/env python3
"""Post-conversion patches for site/class/class-5.qmd.

Issues fixed:
1. Checks area: <details> blocks between indented list items break Pandoc list
   rendering. Restructured parameter sets as bold headings instead of sub-bullets.
2. Bare https:// URLs don't autolink in Pandoc — wrapped Desmos links as [text](url).

Run after pmwiki_to_quarto.py if Class.5 is re-synced from the wiki.
"""
import re
from pathlib import Path

QMD = Path(__file__).parent.parent / "site" / "class" / "class-5.qmd"


def fix_bare_desmos_urls(text: str) -> str:
    return text.replace(
        "Adapt this https://www.desmos.com/calculator/5jc00j0rpr to plot and compare the two functions.",
        "Adapt [this Desmos calculator](https://www.desmos.com/calculator/5jc00j0rpr){target=\"_blank\"} to plot and compare the two functions.",
    ).replace(
        "Let's use https://www.desmos.com/calculator/5jc00j0rpr and create some examples, exploring how parameters transform a function.",
        "Let's use [this Desmos calculator](https://www.desmos.com/calculator/5jc00j0rpr){target=\"_blank\"} and create some examples, exploring how parameters transform a function.",
    )


def fix_checks_list_structure(text: str) -> str:
    # Replace indented sub-bullets that precede <details> blocks with bold headings
    # Pattern: "    - $a=N,b=N,...$" → "**$a=N,\ b=N,...$**"
    text = re.sub(
        r'^ {4}- (\$a=[^\n]+\$)\s*$',
        lambda m: "\n**" + m.group(1).replace(",", r",\ ") + "**",
        text,
        flags=re.MULTILINE,
    )
    return text


if __name__ == "__main__":
    text = QMD.read_text()
    text = fix_bare_desmos_urls(text)
    text = fix_checks_list_structure(text)
    QMD.write_text(text)
    print(f"Patched {QMD.name}")
