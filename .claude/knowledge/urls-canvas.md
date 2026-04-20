# Canvas → Projects site URLs

**When to read:** editing Canvas project links, Module items, assignment descriptions, or planning the reversal when the upstream `byuistats/M119` PR merges.

All Canvas references to the project site now point at Chaz's fork (`chaz-clark.github.io/M119`). Scope: 12 Project Links pages, Project assignments' descriptions, Project Instructions module items, Additional Resources module items, the MATH 119 Frontpage, and the Math 119 Weekly Rhythm page.

## Mappings applied

| Upstream (byuistats) | Fork (chaz-clark) |
|---|---|
| `projectN.html` | `Projects/unitN.html` |
| `project.html` | `Projects/index.html` |
| `specs_detail.html` | `Projects/specs_detail.html` |
| `m119-docs/FILE.html` | `Projects/m119-docs/FILE.html` |
| `index.html` | `index.html` |

## Anchor asymmetry (P1 Final only)

| Fork | Upstream |
|---|---|
| `unit1.html#project-1-bringing-it-all-together` | `project1.html#project-1-bringing-it-all-together-and-answer-a-question` |

## Reversal

When the upstream `byuistats/M119` PR is merged, flip URLs back by running `/tmp/swap_to_fork.py` and `/tmp/swap_remaining_byuistats.py` in reverse (invert FORK/SRC). Both scripts are idempotent and use the mapping table above.
