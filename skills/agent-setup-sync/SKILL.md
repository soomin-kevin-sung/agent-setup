---
name: agent-setup-sync
description: Sync and apply this agent-setup repository's Codex environment profile across PCs. Use when the user wants to capture the current Codex skills/plugins/config into profiles/codex, apply the saved profile to another PC, inspect what Codex setup is managed by the repo, or update the repo after installing/removing Codex skills.
---

# Agent Setup Sync

Use this skill only for this `agent-setup` repository or a clone of it.

## Locate The Repository

Prefer the current working directory when it contains:

- `profiles/codex/`
- `scripts/sync-codex-profile.ps1`
- `scripts/apply-codex-profile.ps1`

If the current directory is not this repository, locate the `agent-setup` clone before running commands.

## Sync Current PC Into The Profile

Run this when the user installed, removed, or changed Codex skills/plugins/config on the current PC and wants the repository to become the source of truth:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\sync-codex-profile.ps1
```

Then verify:

```powershell
Get-Content -Raw profiles\codex\manifest.json | ConvertFrom-Json | Out-Null
git status --short
```

`manifest.json` should use `agent`, not `tool`, and should not include timestamps. Keep standalone skills separate from plugin-provided skills:

```json
{
  "agent": "codex",
  "skills": {
    "standalone": [],
    "fromPlugins": []
  },
  "plugins": []
}
```

Check that sensitive state is not included:

```powershell
Get-ChildItem -Recurse -Force -File profiles\codex |
  Where-Object { $_.Name -match 'auth|session|history|sqlite|token|secret|key|cookie' }
```

Expected result: no output from the sensitive-file check.

## Apply The Profile To This PC

Run this when the user wants this PC to match the repository profile:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\apply-codex-profile.ps1
```

Tell the user to restart Codex after applying the profile.

## Validate Without Touching The Live Codex Home

Use a temp directory for restore/apply tests:

```powershell
$tmp = Join-Path $env:TEMP 'codex-apply-test'
if (Test-Path -LiteralPath $tmp) { Remove-Item -LiteralPath $tmp -Recurse -Force }
powershell -ExecutionPolicy Bypass -File scripts\apply-codex-profile.ps1 -CodexHome $tmp
Get-ChildItem -Directory -LiteralPath (Join-Path $tmp 'skills') | Measure-Object
Remove-Item -LiteralPath $tmp -Recurse -Force
```

Before deleting any computed temp path, verify it is under `$env:TEMP`.

## Guardrails

- Do not copy `auth.json`, sessions, history, logs, SQLite state, or plugin cache into the profile.
- Keep `profiles/codex/` as the managed source of truth.
- Preserve `profiles/codex/manifest.json` as the human-readable inventory of installed skills, plugins, and their relationships.
- If Playwright is involved on Windows, use `scripts/playwright-edge.ps1` so Edge opens via `--browser msedge`.
