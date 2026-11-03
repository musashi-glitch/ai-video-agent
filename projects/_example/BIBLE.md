# <Show title> — BIBLE

The agent reads this at the start of every session. Rules here override the defaults in `skills/`.

## Kino
- Project ID: `<kino project id>`
- Composition: 3840x2160 @ 30 fps
- Lanes: video `zIndex` 1, music below.

## Paths (local)
- Assets folder: `projects/<show>/` (stills/, slices/, backups/, versions/ are gitignored)
- Music: `<path to final mix>`; stems: `<path to stems>` (e.g. `vocals_lead.wav`)
- Timing: `<bars.csv>` (bar starts), `<lyrics_words.csv>` (word start/end); these override auto word timing.
- Grid: `<BPM>` BPM, `<seconds>` s per bar.

## STYLE block (first line of every still prompt, verbatim)
> <e.g. 3D stylized animated feature film still, soft subsurface skin, expressive cartoon faces, warm theatrical lighting, <setting>, shallow depth of field, cinematic composition, 16:9. No text anywhere except <allowed text>.>

## Cast
| Character | Role | Reference media ID(s) | Identity block |
|---|---|---|---|
| <name> | <role/instrument> | `<uuid>` | <age, face, hair, eyes, build, wardrobe, signature detail> |

## Set geography
- <Who stands where, what's always in a wide, what never appears (e.g. no side frames).>

## Continuity details
- <Wardrobe pin/logo, side, size; eye colour; props.>

## Content rules
- <Sensitivity rules, who may appear on which lyric, gags to avoid.>

## Budget
- Ceiling: $<x>. Running total lives in `ROADMAP.md`.
