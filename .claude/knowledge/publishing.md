# Publishing the student-facing site

**When to read:** editing `.github/workflows/publish.yml`, the Quarto site config, diagnosing why a site change isn't live, or planning the migration back to the org-level host.

## The two-remote publishing flow (important)

This repo (`chaz-clark/m119_master`) has **two remotes**:

- `origin` → `chaz-clark/m119_master` (source of truth, where editing happens)
- `m119-site` → `chaz-clark/m119-site` (publishing repo — has the actual `Publish Quarto Site` workflow that builds `site/` → `gh-pages`)

After committing on `main`, **push to both**:

```bash
git push            # origin
git push m119-site main
```

`m119-site`'s `main` mirrors `m119_master`'s `main`. Its publish workflow runs on push to main, renders `site/`, and commits the HTML to `gh-pages`. A `pages-build-deployment` then serves it at **https://chaz-clark.github.io/m119-site/**.

`m119-site` also has a `Daily Schedule Update` workflow (weekdays 10:15 MDT) that re-runs `tools/generate_schedule.py` and commits `site/_today.qmd`, `site/schedule.qmd`, `site/schedule_full.json` — that's what keeps "Today" fresh without editing.

## The m119_master publish workflow is dead

`m119_master/.github/workflows/publish.yml` also exists and also targets `gh-pages`, but `m119_master` has no `gh-pages` branch — every run fails with "the remote origin does not have a branch named 'gh-pages'". It's a vestigial workflow; actual publishing happens via the `m119-site` remote. **If you see red X's on recent m119_master Actions runs, that's why — they're non-blocking.** Candidates: delete the workflow, or change it to mirror-push to `m119-site`.

## Temporary host

This is a temporary URL. Originally the target was `byui-math-dept/Applied_Calculus_for_Data_Analysis`, but GitHub Pages is disabled at the `byui-math-dept` org level (remote `quarto-site`). **When org admins re-enable Pages**, migrate back using `tools/swap_pages_url.py` (edit `OLD`/`NEW` at top, run `--apply`). The log at `tools/url_swap_log_YYYY-MM-DD.md` lists every Canvas location the URL appears in.
