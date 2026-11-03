---
name: spend-log
description: Log every paid generation, asset ID and timeline placement in the show's ROADMAP.md with a running total. Use before and after every fal/reapi run, and when reporting spend or looking up which take is where.
---

# Spend log

`projects/<show>/ROADMAP.md` is the single source of truth for money and assets. Format: `projects/_example/ROADMAP.md`.

## Before submit
```
| <date HH:MM> | <shot> | <endpoint> | start <still id> | <dur> | est $<x> | PENDING |
```

## After it lands
Replace PENDING with: `DONE <media uuid>`, actual cost, placement (`<frame>f, <len>f, trimBefore, playbackRate`), what it replaced, backup path. Update the running total line at the bottom of the section.

## Rules
- Check the budget ceiling in ROADMAP before each batch; stop and ask when a batch would cross it.
- Log failed/rejected takes too (they cost money). Mark them `REJECTED: <reason>` so nobody reuses them.
- Save prompts that worked in `projects/<show>/prompts.md`, keyed by shot, so a shot can be regenerated with the same prompt later.
