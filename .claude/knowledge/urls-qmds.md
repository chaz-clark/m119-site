# Class QMDs — byuistats → fork/local migration

**When to read:** editing a `site/class/*.qmd` or `site/flex/*.qmd` link to the Projects site, a PDF, or a CSV; planning reversal when the upstream PR merges.

## Current state

- **Project pages + probability page** (14 QMDs, 26 refs) → fork URLs (`chaz-clark.github.io/M119/Projects/...`). Scripted via `/tmp/swap_qmds_to_fork.py`. Anchor conversion: `#Task_2:_Models_and_Parameter_Exploration` → `#task-2-models-and-parameter-exploration`; `#Exercises` → `#exercises`.
- **PDFs + example_project.html** (11 QMDs, 16 refs) → local `site/assets/docs/`. Scripted via `/tmp/swap_internal_assets.py`. Files copied from `course_ref/M119/docs/` and published via `resources: [assets/docs/**, assets/data/**]` glob in `site/_quarto.yml`. Fixed two pre-existing typos: `SecondDerTest_BrianSittinger.pdf?`, `example_project.html.`.
- **Data CSVs** (3 QMDs, 15 refs, `class-30/31/32.qmd`) → fork root URLs (`chaz-clark.github.io/M119/<file>.csv`). Scripted via `/tmp/swap_csvs.py`. 7 CSVs copied from `course_ref/M119/docs/*.csv` to fork repo root (`~/Documents/GitHub/M119/`); fork `_quarto.yml` got `resources: ["*.csv"]`. Fork must be re-rendered + pushed for URLs to resolve.

## Reversal when byuistats PR merges

- **CSV swap:** trivial domain flip (`chaz-clark` → `byuistats`, same path — byuistats already serves these).
- **PDF / example_project refs:** stay local (they're ours now).
- **Project-page swap:** use the two scripts above in reverse.

## RMarkdown → Quarto (2026-04-20)

All project material requires `.qmd`, not `.Rmd`. On the fork: `Practice_RMarkdown.qmd` renamed to `Practice_QMD.qmd`; `rmarkdown-2.0.pdf` cheat sheet removed; RCheatSheets section renamed from "R Markdown / Quarto authoring" to "Quarto authoring". In this repo: class-3/4/5 wording updated (RMarkdown → Quarto, Knit → render). Canvas assignment submission types remain `html` only — students submit rendered HTML, no change needed.
