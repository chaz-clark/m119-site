"""Swap old Pages URL -> new URL across Canvas + generate location log.

Scans Canvas pages/assignments/discussions/modules/quizzes/syllabus.
Writes tools/url_swap_log_YYYY-MM-DD.md listing every hit so future
migrations can re-target the same list.

Dry-run by default; pass --apply to actually update Canvas.
"""
import json
import os
import re
import socket
import sys
import urllib.parse
import urllib.request
from datetime import date
from pathlib import Path
from dotenv import load_dotenv

load_dotenv("/Users/chazclar/Documents/GitHub/m119_master/.env")
socket.setdefaulttimeout(15)

TOKEN = os.environ["CANVAS_API_TOKEN"]
COURSE = os.environ["CANVAS_COURSE_ID"]
BASE = f"https://{os.environ['CANVAS_BASE_URL']}/api/v1"

OLD = "https://miniature-adventure-g44yz51.pages.github.io"
NEW = "https://chaz-clark.github.io/m119-site"

APPLY = "--apply" in sys.argv
LOG_PATH = Path(f"/Users/chazclar/Documents/GitHub/m119_master/tools/url_swap_log_{date.today().isoformat()}.md")

HEADERS = {"Authorization": f"Bearer {TOKEN}"}


def req(method: str, path: str, data: dict | None = None) -> dict:
    url = path if path.startswith("http") else f"{BASE}{path}"
    body = urllib.parse.urlencode(data, doseq=True).encode() if data else None
    r = urllib.request.Request(url, data=body, method=method, headers=HEADERS)
    if body:
        r.add_header("Content-Type", "application/x-www-form-urlencoded")
    with urllib.request.urlopen(r) as resp:
        txt = resp.read().decode()
        return json.loads(txt) if txt else {}


def paged(path: str) -> list:
    items = []
    url = f"{BASE}{path}?per_page=100"
    while url:
        r = urllib.request.Request(url, headers=HEADERS)
        with urllib.request.urlopen(r) as resp:
            items.extend(json.loads(resp.read().decode()))
            link = resp.headers.get("Link", "")
            nxt = re.search(r'<([^>]+)>;\s*rel="next"', link)
            url = nxt.group(1) if nxt else None
    return items


def swap(text: str | None) -> tuple[str | None, int]:
    if not text or OLD not in text:
        return text, 0
    return text.replace(OLD, NEW), text.count(OLD)


locations: list[tuple[str, str, str, int]] = []  # (kind, id, label, hit_count)


def main():
    tag = "APPLY" if APPLY else "DRY-RUN"
    print(f"[{tag}] scanning course {COURSE} …", flush=True)
    print(f"       OLD: {OLD}", flush=True)
    print(f"       NEW: {NEW}", flush=True)
    total_hits = 0

    for p in paged(f"/courses/{COURSE}/pages"):
        full = req("GET", f"/courses/{COURSE}/pages/{p['url']}")
        new_body, hits = swap(full.get("body"))
        if hits:
            total_hits += hits
            locations.append(("page", p["url"], p.get("title", ""), hits))
            print(f"  page {p['url']}: {hits} hit(s)", flush=True)
            if APPLY:
                req("PUT", f"/courses/{COURSE}/pages/{p['url']}",
                    {"wiki_page[body]": new_body})

    for a in paged(f"/courses/{COURSE}/assignments"):
        new_desc, hits = swap(a.get("description"))
        if hits:
            total_hits += hits
            locations.append(("assignment", str(a["id"]), a["name"], hits))
            print(f"  assignment {a['id']} ({a['name'][:40]}): {hits} hit(s)", flush=True)
            if APPLY:
                req("PUT", f"/courses/{COURSE}/assignments/{a['id']}",
                    {"assignment[description]": new_desc})

    for d in paged(f"/courses/{COURSE}/discussion_topics"):
        new_msg, hits = swap(d.get("message"))
        if hits:
            total_hits += hits
            locations.append(("discussion", str(d["id"]), d["title"], hits))
            print(f"  discussion {d['id']} ({d['title'][:40]}): {hits} hit(s)", flush=True)
            if APPLY:
                req("PUT", f"/courses/{COURSE}/discussion_topics/{d['id']}",
                    {"message": new_msg})

    for m in paged(f"/courses/{COURSE}/modules"):
        for item in paged(f"/courses/{COURSE}/modules/{m['id']}/items"):
            url = item.get("external_url")
            if url and OLD in url:
                new_url = url.replace(OLD, NEW)
                total_hits += 1
                locations.append(("module_item", f"{m['id']}/{item['id']}", item.get("title", ""), 1))
                print(f"  module item {item['id']} ({item.get('title','')[:40]}): external_url", flush=True)
                if APPLY:
                    req("PUT", f"/courses/{COURSE}/modules/{m['id']}/items/{item['id']}",
                        {"module_item[external_url]": new_url})

    for q in paged(f"/courses/{COURSE}/quizzes"):
        new_desc, hits = swap(q.get("description"))
        if hits:
            total_hits += hits
            locations.append(("quiz", str(q["id"]), q["title"], hits))
            print(f"  quiz {q['id']} ({q['title'][:40]}): {hits} hit(s)", flush=True)
            if APPLY:
                req("PUT", f"/courses/{COURSE}/quizzes/{q['id']}",
                    {"quiz[description]": new_desc})

    course = req("GET", f"/courses/{COURSE}?include[]=syllabus_body")
    new_syll, hits = swap(course.get("syllabus_body"))
    if hits:
        total_hits += hits
        locations.append(("syllabus", "-", "Course Syllabus", hits))
        print(f"  syllabus: {hits} hit(s)", flush=True)
        if APPLY:
            req("PUT", f"/courses/{COURSE}", {"course[syllabus_body]": new_syll})

    print(f"[{tag}] total hits: {total_hits} across {len(locations)} locations", flush=True)

    # Write log
    lines = [
        f"# URL Swap Log — {date.today().isoformat()}",
        "",
        f"- **OLD:** `{OLD}`",
        f"- **NEW:** `{NEW}`",
        f"- **Mode:** {tag}",
        f"- **Course ID:** {COURSE}",
        f"- **Total hits:** {total_hits} across {len(locations)} locations",
        "",
        "## Locations updated",
        "",
        "| Kind | ID / slug | Title | Hits |",
        "|---|---|---|---|",
    ]
    for kind, ident, title, hits in locations:
        safe_title = (title or "").replace("|", "\\|")[:80]
        lines.append(f"| {kind} | `{ident}` | {safe_title} | {hits} |")
    lines.append("")
    lines.append("## Re-running for a future migration")
    lines.append("")
    lines.append("Edit `OLD` and `NEW` at the top of `tools/swap_pages_url.py`,")
    lines.append("run `--apply`, and it will touch exactly the locations in the")
    lines.append("table above (plus any new pages that reference OLD).")
    LOG_PATH.write_text("\n".join(lines))
    print(f"Log written: {LOG_PATH}", flush=True)

    if not APPLY and total_hits:
        print("Re-run with --apply to push changes.", flush=True)


if __name__ == "__main__":
    main()
