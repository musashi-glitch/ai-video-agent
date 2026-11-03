---
name: timeline-placement
description: Place, swap, trim, retime and mute generated clips on a Kino timeline for an AI video cut to music. Use when dropping a new take into a slot, replacing a shot, fitting a clip's length, or slowing/speeding a take.
---

# Timeline placement (Kino)

## Lane and swap
- All generated video sits on one lane at `zIndex` 1; music/audio below.
- Read the slot first with `timelineGet` (position, duration of the clip being replaced).
- **Back up `App.tsx`** to `projects/<show>/backups/<timestamp>-<change>.App.tsx` before changes.
- Swap: `timelineEdit` delete the old clip, then insert the new media with the same position and duration, plus `sourceStart` for the good frame range. Or replace the `kino:<id>` src in place when timing stays the same.
- Use the playhead/selection the user points at ("cut around here") as the exact frame.

## Mute every inserted video
Generated clips may carry audio. After inserting, add `muted`:
```
perl -0pi -e 's/(kino:<ID>"(?: trimBefore=\{\d+\})?) style=/$1 muted style=/' App.tsx
```
Then `projectScreenshot` to confirm the edit synced.

## Fitting a take into a slot
- Trim the bad head/tail with `trimBefore` / duration. Cut before any weird motion at the end (sudden turns, morphs).
- Change speed with `playbackRate` on the video element: 0.85–1.2. Below 0.85 looks mushy; above 1.2 looks rushed.
- Source frames used = duration × playbackRate. Make sure `trimBefore + duration × playbackRate` ≤ clip length.
- To slow a shot down AND end on a specific frame, solve for `playbackRate` = (source frames you want to show) / (slot frames).

## Verify
`projectScreenshot` at the start, middle and end of the slot. Check the cut points on the bar grid. Then log the placement in ROADMAP (`skills/spend-log`).
