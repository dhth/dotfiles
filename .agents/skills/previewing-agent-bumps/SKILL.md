---
name: previewing-agent-bumps
description: Previews what `mise run global-tools:bump-agents` would pull in for the pinned AI agents (opencode, openchamber, pi, codex, and others) as a short HTML page of user-facing highlights, without writing the lockfile. Use when asked what's new in the agents, what a bump would bring, or before bumping them.
---

# Previewing agent bumps

Produces a one-screen HTML page: for each agent, the version change, a few
one-line highlights a daily user would notice, any heads-up, and links to the
release notes and commits. It reads like a short changelog, not a commit log.

The scripts use a `uv run --script` shebang; run them directly, not with
`python3`. They need `mise`, `gh` (authenticated), and `npm` on `PATH`.

## Steps

1. **Pick the tools.** Unless the user names some, use the tool list from the
   `global-tools:bump-agents` task in the repository-root `mise.toml`. Match
   the task the user would run: `bump-agents` uses mise's default
   release-age delay; `bump-agents-no-delay` means pass `--no-delay`.

2. **Collect the data:**

   ```sh
   S=.agents/skills/previewing-agent-bumps/scripts
   mkdir -p /tmp/abp/site
   $S/collect.py opencode openchamber > /tmp/abp/data.json
   ```

   For each tool, `collect.py` records the pin from `~/.config/mise/mise.lock`,
   the target from `mise lock --global --bump --dry-run --json`, the source
   repository, the commits between the two tags, and the non-prerelease GitHub
   releases in that range. A tool that would not move gets the commits on its
   default branch since the pinned tag, marked with `unreleased_branch`.
   Nothing is written to the lockfile.

   Check the result before going on:

   ```sh
   jq -c '.tools[] | {name, repo, old, new, old_tag, new_tag, unreleased_branch, commits: (.commits | length), releases: [.releases[].tag]}' /tmp/abp/data.json
   ```

   A tool with a repo but no `old_tag` uses a tag scheme `tag_for` in
   `collect.py` doesn't know yet. Look at
   `gh api repos/<repo>/releases --jq '.[].tag_name'` and add the pattern.

3. **Write `/tmp/abp/highlights.json`.** This is the judgement step, and the
   page is only as good as it.

   Sources, best first:
   - the release notes: `jq -r '.tools[] | select(.name=="openchamber") | .releases[].body' /tmp/abp/data.json`
   - when there are none, a `CHANGELOG.md` diff in the compare range, if the
     repo keeps one
   - the `feat`, `fix` and `perf` commit subjects:
     `jq -r '.tools[] | select(.name=="opencode") | .commits[].message | split("\n")[0]' /tmp/abp/data.json | rg '^(feat|fix|perf)'`

   Choose:
   - A tool that would bump: 3–6 items. Features first, then opt-in settings,
     then fixes to bugs a user would actually hit.
   - A tool that would not bump: at most 3 items of what's coming. Leave it
     empty when nothing stands out.
   - Skip refactors, tests, CI, docs, dependency bumps, internal tracing, and
     website, console or marketing changes.

   Write each item as one short line for a user, not a developer: "Cmd+Up in
   the composer opens a searchable history of earlier prompts.", not
   "feat(composer): add searchable prompt history". Say where an opt-in
   setting lives. Prefix fixes with "Fixed:". Add the PR numbers an item
   comes from when the commits name them.

   Add `heads_up` lines only for breaking changes, changed defaults, or a new
   minimum version of another tool. Check minimums against the pinned versions
   in the lockfile and say whether the user is fine.

   ```json
   {
     "openchamber": {
       "heads_up": ["Needs OpenCode ≥ 2.2.4. You have 2.2.5 pinned, so you're fine."],
       "highlights": [
         { "text": "Cmd+Up in the composer opens a searchable history of earlier prompts.", "prs": [4972] },
         { "text": "Opt-in agent memory: Settings → General → OpenChamber Tools." }
       ]
     }
   }
   ```

   Text supports `` `code` ``, `**bold**` and `[links](url)`. Tools missing
   from the file render with just their version line and links.

4. **Render and open the page:**

   ```sh
   $S/render.py /tmp/abp/data.json /tmp/abp/highlights.json > /tmp/abp/site/index.html
   ```

   Bumped tools come first; the rest are drawn quieter. The page is one
   self-contained file. Open it in the user's browser with `open` on macOS or
   `xdg-open` on Linux. If the user can't open files on the machine you run
   on, serve `/tmp/abp/site` over HTTP however your environment makes local
   servers reachable, such as `python3 -m http.server --directory /tmp/abp/site`.

5. **Reply** with the page and a one-line summary per bumped tool. Don't
   repeat the whole page in the chat.

## Per-agent notes

- **Source repositories:** `aqua:`, `github:` and `ubi:` backends name their
  repository. `npm:` packages use the package's `repository` field. When that
  is missing, add the tool to `REPOS` in `collect.py`, as for openchamber.
- **amp:** no public source, so the page shows only the version change.
- **claude:** `anthropics/claude-code` holds the changelog and issues, not the
  source. Its commits are mostly changelog edits, so read the `CHANGELOG.md`
  diff for highlights.
- **codex:** tags releases `rust-v<version>` and publishes many alphas;
  `collect.py` ignores prereleases.
