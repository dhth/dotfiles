#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = []
# ///
"""Collect the upstream changes a `mise lock --global --bump` would pull in.

Usage: collect.py [--no-delay] TOOL... > data.json

Asks mise for a dry-run bump, then fetches commits and release notes from
GitHub with `gh`. Tools that would not move still get the commits on their
default branch since the pinned tag, marked as unreleased.
"""

import json
import os
import re
import subprocess
import sys
import tomllib
from datetime import datetime, timezone

# Source repositories for tools whose backend does not name one. npm packages
# fall back to the package's `repository` field.
REPOS = {
    "openchamber": "openchamber/openchamber",
}


def run(*cmd):
    return subprocess.run(cmd, check=True, capture_output=True, text=True).stdout


def gh_json(path, paginate=False, jq=None):
    cmd = ["gh", "api", path]
    if paginate:
        cmd.append("--paginate")
    if jq:
        cmd += ["--jq", jq]
    out = run(*cmd)
    if jq:
        return [json.loads(line) for line in out.splitlines() if line]
    return json.loads(out)


def locked(tools):
    """Current (version, backend) pins from the global lockfile."""
    with open(os.path.expanduser("~/.config/mise/mise.lock"), "rb") as f:
        lock = tomllib.load(f)["tools"]
    return {t: (lock[t][0]["version"], lock[t][0]["backend"]) for t in tools if t in lock}


def bumps(tools, no_delay):
    cmd = ["mise", "lock", "--global", "--bump", "--dry-run", "--json"]
    if no_delay:
        cmd += ["--minimum-release-age", "0s"]
    return {c["name"]: c for c in json.loads(run(*cmd, *tools))}


def repo_for(tool, backend):
    if tool in REPOS:
        return REPOS[tool]
    kind, _, ident = backend.partition(":")
    if kind in ("github", "aqua", "ubi"):
        return "/".join(ident.split("/")[:2])
    if kind == "npm":
        try:
            url = json.loads(run("npm", "view", ident, "repository.url", "--json"))
        except (subprocess.CalledProcessError, json.JSONDecodeError):
            return None
        m = re.search(r"github\.com[/:]([^/]+/[^/.]+)", url or "")
        return m.group(1) if m else None
    return None


def tag_for(repo, version):
    # codex tags its releases rust-v<version>.
    for tag in (f"v{version}", version, f"rust-v{version}"):
        try:
            gh_json(f"repos/{repo}/git/ref/tags/{tag}")
            return tag
        except subprocess.CalledProcessError:
            continue
    return None


COMMIT_JQ = (
    ".commits[] | {sha, url: .html_url, author: (.author.login // .commit.author.name),"
    " date: .commit.author.date, message: .commit.message}"
)


def commits_between(repo, base, head):
    return gh_json(
        f"repos/{repo}/compare/{base}...{head}?per_page=100", paginate=True, jq=COMMIT_JQ
    )


def releases_between(repo, old_tag, new_tag):
    """Releases published after old_tag up to and including new_tag."""
    rels = gh_json(
        f"repos/{repo}/releases?per_page=100",
        jq=".[] | {tag: .tag_name, name, body, url: .html_url, published: .published_at, prerelease}",
    )
    by_tag = {r["tag"]: r for r in rels}
    if old_tag not in by_tag or new_tag not in by_tag:
        return [by_tag[new_tag]] if new_tag in by_tag else []
    lo, hi = by_tag[old_tag]["published"], by_tag[new_tag]["published"]
    return [
        r
        for r in rels
        if not r["prerelease"] and lo < r["published"] <= hi
    ]


def main(argv):
    no_delay = "--no-delay" in argv
    tools = [a for a in argv if not a.startswith("--")]
    changes = bumps(tools, no_delay)
    pins = locked(tools)

    report = {
        "generated": datetime.now(timezone.utc).isoformat(timespec="seconds"),
        "delay": "none" if no_delay else "mise default",
        "tools": [],
    }
    for tool in tools:
        change = changes.get(tool)
        old, backend = pins[tool]
        new = change["new_versions"][0] if change else None
        repo = repo_for(tool, backend)
        entry = {
            "name": tool,
            "backend": backend,
            "repo": repo,
            "old": old,
            "new": new,
            "commits": [],
            "releases": [],
        }
        if repo and old:
            old_tag = tag_for(repo, old)
            entry["old_tag"] = old_tag
            if new:
                new_tag = tag_for(repo, new)
                entry["new_tag"] = new_tag
                if old_tag and new_tag:
                    entry["compare_url"] = f"https://github.com/{repo}/compare/{old_tag}...{new_tag}"
                    entry["commits"] = commits_between(repo, old_tag, new_tag)
                    entry["releases"] = releases_between(repo, old_tag, new_tag)
            elif old_tag:
                branch = gh_json(f"repos/{repo}")["default_branch"]
                entry["unreleased_branch"] = branch
                entry["compare_url"] = f"https://github.com/{repo}/compare/{old_tag}...{branch}"
                entry["commits"] = commits_between(repo, old_tag, branch)
        report["tools"].append(entry)

    json.dump(report, sys.stdout, indent=2)


if __name__ == "__main__":
    main(sys.argv[1:])
