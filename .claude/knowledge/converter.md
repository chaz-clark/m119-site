# PMWiki → Quarto converter

**When to read:** touching `tools/pmwiki_to_quarto.py`, a `tools/after_class_N.py`, or diagnosing a rendering bug on a class/flex page.

## Bug triage

- **Global rule** (affects multiple pages, stems from PMWiki markup pattern) → fix in `tools/pmwiki_to_quarto.py`.
- **Page-specific quirk** (one-off content issue that can't be generalized) → create `tools/after_class_N.py` that patches just that QMD after conversion.

## Full sync workflow

```bash
uv run pull_wiki.py
uv run python tools/pmwiki_to_quarto.py
# run any after_class_N.py scripts that exist
uv run python tools/generate_schedule.py
git add site/ && git commit -m "Sync wiki" && git push
```

## Known page-specific scripts

- `tools/after_class_5.py` — fixes Check blocks (list/HTML interleave) and bare Desmos URLs
- `tools/after_class_26.py` — fixes Prep item 6 copy-paste typos (ℓ₁/f₁ → ℓ₅/f₅ in the ℓ₅ block)

## Schedule ownership rule (2026-04-20)

`site/schedule.qmd` is owned by `tools/generate_schedule.py`, which writes a week×MTRF grid from `schedule_config.yml`. The PMWiki converter used to also write `schedule.qmd` from stale 2020 `Schedule.YYYYMMDD` wiki pages, clobbering the generated file. That write has been removed (comment at `pmwiki_to_quarto.py:~900`). The helper `build_schedule_page()` still exists but is unreferenced — safe to delete if cleaning up.

If you find raw PMWiki markup (`!Agenda`, `%height=200px%`, `[[x -> y]]`) in `site/schedule.qmd`, the converter has regressed and is writing it again. Re-apply the removal and run `uv run python tools/generate_schedule.py`.

## Direction of travel

`.qmd` files in `site/` are becoming the master. Once conversion is clean enough we stop re-converting and edit the `.qmd`s directly. The `after_class_*.py` scripts are interim belt-and-suspenders until that cutover.

## Pandoc markdown gotchas (seen across class-*.qmd)

- `<a id="..."></a>` followed immediately by `## Heading` absorbs the heading into a paragraph → need blank line between anchor and heading.
- `1. ` or `- ` list lines immediately after prose collapse into the paragraph → need blank line before the first list marker.
- Adjacent markdown tables without a blank line between them merge into one table with shifted headers → one blank line between distinct tables, zero blank lines within a table.
