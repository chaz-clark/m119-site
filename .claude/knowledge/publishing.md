# Publishing the student-facing site

**When to read:** editing `.github/workflows/publish.yml`, the Quarto site config, or planning the migration back to the org-level host.

## Current deploy

The course site publishes from this repo's `site/` directory to **https://chaz-clark.github.io/m119-site/** via the `Publish Quarto Site` workflow (`.github/workflows/publish.yml`), which pushes built HTML to the `gh-pages` branch of `chaz-clark/m119-site`.

## Temporary host

This is a temporary URL. Originally the target was `byui-math-dept/Applied_Calculus_for_Data_Analysis`, but GitHub Pages is disabled at the `byui-math-dept` org level. **When org admins re-enable Pages**, migrate back using `tools/swap_pages_url.py` (edit `OLD`/`NEW` at top, run `--apply`). The log at `tools/url_swap_log_YYYY-MM-DD.md` lists every Canvas location the URL appears in.
