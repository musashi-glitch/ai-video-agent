---
name: video-pipeline
description: Locked end-to-end workflow for making AI video from images in Kino with fal — stills (Nano Banana), animation (Kling v3 Pro), lip-sync (MiniMax), cutting to a music bar grid, spend logging and timeout recovery. Use for ANY request to generate, animate, lip-sync, fix, replace or swap shots or characters in an AI video project. Read this before calling fal or reapi.
---

# Video pipeline (start here)

This is the index skill. It defines the order of work and points to the focused skills. Follow it exactly so every session produces the same look and the same process.

## 0. Session start (always, before generating anything)
1. Find the show folder: `projects/<show>/` in this repo. Read `BIBLE.md` (style, cast, rules, paths, budget) and the tail of `ROADMAP.md` (spend log).
2. Check `ROADMAP.md` for `PENDING` jobs and run the recovery check in `skills/fal-job-recovery`. Earlier runs may already be in the library; never pay twice.
3. Confirm the budget ceiling and running total in `ROADMAP.md`.
4. If there is no show folder, copy `projects/_example/` to `projects/<show>/` and fill in `BIBLE.md` with the user before generating.

## 1. Model discipline
- Use only the models in `playbooks/models.md`. Never switch models silently. If the locked model can't do the job, say so, propose an alternative with a price quote, and wait for a yes.
- Call fal `pricing` before the first `run` of each batch and tell the user the cost.
- Kino runs fal calls one at a time. Use sub-agents for parallel generation only when the user asks for it.

## 2. Per-section workflow
Work one section at a time (e.g. one verse or chorus). Don't overthink; ship the section and show it.

| Step | What | Skill |
|---|---|---|
| 1. Plan | Shot list against the music bar grid, ~1 cut per bar, varied scale. Get approval for new sections. | `projects/_example/SHOTLIST.md` |
| 2. Still | One start frame per shot with Nano Banana, STYLE block first, refs attached. Show new concepts as stills before animating. | `skills/stills` |
| 3. Animate | Kling v3 Pro from the approved still, "already mid-action" prompt, one camera move. | `skills/motion-kling` |
| 4. Lip-sync | Singing/talking shots with MiniMax from a lip-sync still plus an audio slice. | `skills/lipsync` |
| 5. Verify | `lookAtFrames` on every clip before placing: pose, identity, wardrobe details, extra limbs, duplicates, frozen or morphing faces. Note the usable frame range. | — |
| 6. Cut | Place with `timelineEdit`, mute, fit to the slot, screenshot. | `skills/timeline-placement` |
| 7. Log | Every job, media ID, cost and placement in `ROADMAP.md`. | `skills/spend-log` |
| 8. Stop and show | Table of what changed plus what to check by eye/ear. Do only what was asked. | — |

Export for social: `skills/export-to-twitter`.

## 3. Hard rules
- **Every submit is logged as PENDING first.** On a timeout or interrupt, recover, never re-run (`skills/fal-job-recovery`).
- **Fix the still, not the prompt.** If a clip starts in the wrong pose, fix the start still and re-animate.
- **Edit a still at most once before animating.** Stacked edits drift; regenerate from clean references instead.
- **Media refs are `kino://media/<full uuid>`.** Short IDs fail; resolve them with `findMedia` `glob: "<short>*"`.
- **Chat-attached images** import with `addMediaToKino` type `chatAttachment` and the `s3Key` (`org_…/chat-uploads/<id>.png`). The `url` type returns 401 for chat uploads.
- **Show rules in `BIBLE.md` override defaults here** (style, cast, sensitivity rules, stage geography).
- Prompt and camera patterns: `playbooks/prompt-patterns.md`, `playbooks/camera-moves.md`.
