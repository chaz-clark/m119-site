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

## Two workflow gotchas (and their fixes)

1. **Duplicate cron commits across repos.** Because `m119-site/main` mirrors `m119_master/main`, any `.github/workflows/*.yml` file exists in both repos, and cron-driven workflows will fire in *both* unless gated. Without gating, you get two separate "daily schedule update" bot commits every weekday (one per repo) and the two mains drift. **Both workflows have `if: github.repository == 'chaz-clark/m119-site'`** so jobs only execute there.

2. **Bot commits don't trigger downstream workflows.** GitHub's anti-loop policy: commits made via `GITHUB_TOKEN` do not fire `push`-triggered workflows. That meant `Daily Schedule Update`'s commit updated `_today.qmd` but never kicked `Publish Quarto Site` → live site stayed stale. Fix: `publish.yml` has a `workflow_run` trigger listening for `Daily Schedule Update` completion. `workflow_run` is exempt from the anti-loop restriction.

## Temporary host

This is a temporary URL. Originally the target was `byui-math-dept/Applied_Calculus_for_Data_Analysis`, but GitHub Pages is disabled at the `byui-math-dept` org level (remote `quarto-site`). **When org admins re-enable Pages**, migrate back using `tools/swap_pages_url.py` (edit `OLD`/`NEW` at top, run `--apply`). The log at `tools/url_swap_log_YYYY-MM-DD.md` lists every Canvas location the URL appears in.
