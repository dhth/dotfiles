#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = []
# ///
"""Render collect.py output and the agent's highlights as one short HTML page.

Usage: render.py data.json highlights.json > preview.html

highlights.json maps a tool name to
  {"highlights": [{"text": "...", "prs": [123]}], "heads_up": ["..."]}
Text supports `code`, **bold** and [links](url).
"""

import html
import json
import re
import sys

esc = html.escape


def inline_md(text):
    text = esc(text)
    text = re.sub(r"`([^`]+)`", r"<code>\1</code>", text)
    text = re.sub(r"\*\*(.+?)\*\*", r"<strong>\1</strong>", text)
    return re.sub(r"\[([^\]]+)\]\(([^)]+)\)", r'<a href="\2">\1</a>', text)


def tool_section(tool, notes):
    repo = tool["repo"]
    n = len(tool["commits"])

    if tool["new"]:
        version = f'<span class="old">{esc(tool["old"])}</span> → <span class="new">{esc(tool["new"])}</span>'
        heading = "What's new"
    else:
        branch = tool.get("unreleased_branch")
        waiting = f" · {n} commits waiting on <code>{esc(branch)}</code>" if branch else ""
        version = f'<span>{esc(tool["old"] or "?")}</span> <span class="muted">no bump{waiting}</span>'
        heading = "Coming next"

    links = []
    if repo and tool["new"]:
        rel = tool["releases"][-1]["url"] if tool["releases"] else None
        rel = rel or (f'https://github.com/{repo}/releases/tag/{tool["new_tag"]}' if tool.get("new_tag") else None)
        if rel:
            links.append(f'<a href="{rel}">release notes</a>')
    if tool.get("compare_url"):
        label = f"{n} commits" if tool["new"] else "unreleased commits"
        links.append(f'<a href="{tool["compare_url"]}">{label}</a>')
    if not repo:
        links.append('<span class="muted">no public source</span>')

    parts = [
        f'<section class="tool{"" if tool["new"] else " quiet"}">',
        f'<header><h2>{esc(tool["name"])}</h2><span class="ver">{version}</span>'
        f'<span class="links">{" · ".join(links)}</span></header>',
    ]
    for warning in notes.get("heads_up", []):
        parts.append(f'<p class="heads-up">⚠ {inline_md(warning)}</p>')
    if items := notes.get("highlights"):
        rows = []
        for h in items:
            prs = " ".join(f'<a class="pr" href="https://github.com/{repo}/pull/{p}">#{p}</a>' for p in h.get("prs", []))
            rows.append(f"<li>{inline_md(h['text'])} {prs}</li>")
        label = "" if tool["new"] else f'<p class="label">{heading}</p>'
        parts.append(f'{label}<ul>{"".join(rows)}</ul>')
    parts.append("</section>")
    return "\n".join(parts)


CSS = """
:root { color-scheme: light dark; --bg:#fbf1c7; --fg:#3c3836; --muted:#7c6f64; --card:#f9f5d7; --line:#d5c4a1;
  --accent:#076678; --old:#9d0006; --new:#79740e; --warn:#b57614; --code:#ebdbb2; }
@media (prefers-color-scheme: dark) { :root { --bg:#1d2021; --fg:#ebdbb2; --muted:#a89984; --card:#282828;
  --line:#3c3836; --accent:#83a598; --old:#fb4934; --new:#b8bb26; --warn:#fabd2f; --code:#3c3836; } }
body { margin:0; background:var(--bg); color:var(--fg); font:15px/1.5 -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif; }
main { max-width: 760px; margin: 0 auto; padding: 32px 20px 60px; }
a { color: var(--accent); text-decoration: none; } a:hover { text-decoration: underline; }
code { font: 13px ui-monospace, monospace; background: var(--code); padding: 1px 4px; border-radius: 4px; }
h1 { margin: 0; font-size: 22px; }
.sub { color: var(--muted); margin: 2px 0 24px; font-size: 13px; }
section.tool { background:var(--card); border:1px solid var(--line); border-radius:10px; padding:14px 20px; margin-bottom:16px; }
section.quiet { background: transparent; }
header { display:flex; align-items:baseline; gap:12px; flex-wrap: wrap; }
h2 { margin:0; font-size:18px; }
.ver { font: 600 14px ui-monospace, monospace; } .old { color:var(--old); } .new { color:var(--new); }
.muted { color: var(--muted); font-weight: normal; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif; }
.links { margin-left: auto; font-size: 13px; }
.heads-up { margin: 10px 0 0; padding: 6px 10px; border-left: 3px solid var(--warn); }
.label { margin: 10px 0 0; color: var(--muted); font-size: 12px; text-transform: uppercase; letter-spacing: .04em; }
ul { margin: 8px 0 0; padding-left: 20px; } li { margin: 3px 0; }
.pr { font-size: 12px; color: var(--muted); }
"""


def main(argv):
    with open(argv[0]) as f:
        data = json.load(f)
    with open(argv[1]) as f:
        highlights = json.load(f)
    # Tools that would bump come first; the rest keep their order.
    data["tools"].sort(key=lambda t: t["new"] is None)
    body = "\n".join(tool_section(t, highlights.get(t["name"], {})) for t in data["tools"])
    print(f"""<!doctype html>
<html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>Agent bump preview</title><style>{CSS}</style></head>
<body><main>
<h1>Agent bump preview</h1>
<p class="sub">What <code>mise lock --global --bump</code> would pull in · release-age delay: {esc(data["delay"])} · {esc(data["generated"][:16].replace("T", " "))} UTC</p>
{body}
</main></body></html>""")


if __name__ == "__main__":
    main(sys.argv[1:])
