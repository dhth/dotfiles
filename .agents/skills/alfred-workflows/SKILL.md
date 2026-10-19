---
name: alfred-workflows
description: Inspect, create, or modify Alfred workflows using native workflow files and AppleScript.
---

# Alfred workflows

Use native files and AppleScript first; no CLI package or MCP server is needed.

## Find and inspect

- Read the configured sync directory with
  `defaults read com.runningwithcrayons.Alfred-Preferences syncfolder`.
  Expand `~`; workflows live under `<syncfolder>/Alfred.alfredpreferences/workflows/`.
  Without a sync directory, check
  `~/Library/Application Support/Alfred/Alfred.alfredpreferences/workflows/`.
- Each workflow directory contains `info.plist` and optional scripts/assets.
  Use Python `plistlib` to read XML or binary plists. Identify workflows by
  `bundleid` and `name`, not their generated folder names.
- List metadata first. Inspect only relevant objects; scripts, variables, and
  personal `prefs.plist` overrides may contain secrets. Do not dump them wholesale.

## Edit safely

1. Back up the target `info.plist` outside the workflow directory. Avoid editing
   while the user is changing the same workflow in Alfred Preferences.
2. Preserve existing objects, connections, configuration, and unknown fields.
   The graph format is not a documented stable authoring API: copy relevant
   object shapes and versions from working local workflows instead of guessing.
3. Add unique object `uid` values, wire `connections` using `destinationuid`, and
   position new objects with `uidata` so the canvas stays readable.
4. For substantial logic, prefer supporting script files over large inline scripts.
5. Parse the result, verify unique IDs and valid connection endpoints, check
   preset arguments, and confirm all unrelated workflow data is unchanged.
6. Reload the workflow with the native AppleScript command below.

## Fixed picker pattern

For a fixed picker, use **External Trigger → List Filter → Copy to Clipboard**.
An external trigger can connect directly to the List Filter; no keyword or
AppleScript search intermediary is needed.

- External Trigger: `alfred.workflow.trigger.external`; set `triggerid` and,
  if URL invocation is wanted, `availableviaurlhandler` to true.
- List Filter: `alfred.workflow.input.listfilter`; `config.items` is a JSON
  **string** containing objects with `title`, `subtitle`, and `arg`. Set
  `fixedorder` to true for predictable preset order.
- Clipboard: `alfred.workflow.output.clipboard`; set `clipboardtext` to
  `{query}` and `autopaste` to false. Enter copies the selected item's `arg`.

## Reload and invoke

```sh
osascript -e 'tell application id "com.runningwithcrayons.Alfred" to reload workflow "com.example.workflow"'
osascript -e 'tell application id "com.runningwithcrayons.Alfred" to run trigger "picker" in workflow "com.example.workflow" with argument ""'
open 'alfred://runtrigger/com.example.workflow/picker/'
```

Substitute the actual bundle/trigger IDs. Percent-encode URL arguments; do not
interpolate untrusted input into AppleScript source. Apple Events may require
Automation permission. To verify supported commands, locate the installed
Alfred application and inspect `Contents/Resources/Alfred.sdef` inside its bundle;
do not assume its installation path or major version.

Only invoke actions within the user's requested scope. A successful trigger
call does not prove downstream behavior: validate scripts separately and use
Alfred's Workflow Debugger or a human UI check. Report what was actually tested.

For Karabiner shortcuts, read repository `docs/karabiner.md` and `docs/keymaps.md`,
check simlayer collisions, and reuse the existing `:alfred` template. Run `goku`
when requested to apply the mapping.

References:
- https://www.alfredapp.com/help/workflows/triggers/external/
- https://www.alfredapp.com/help/workflows/inputs/list-filter/
- https://www.alfredapp.com/help/workflows/advanced/debugger/
