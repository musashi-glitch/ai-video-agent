---
name: fal-job-recovery
description: Never lose or double-pay a fal/Kling/reapi generation job. Use whenever a generation call times out ("timed out awaiting tools/call after 300s"), is interrupted, returns ok:false with a resumeToken, or at the start of any session that may have pending jobs.
---

# fal job recovery

The Kino MCP call gives up after 300 s, but **the fal job keeps running** and Kino imports the result into the library when it finishes. A user interrupt also aborts the call, not the job. Calling `run` again bills a second time.

## Before every submit
Append a PENDING line to `projects/<show>/ROADMAP.md` with the submit time (see `skills/spend-log`): shot, endpoint, start-still ID, duration, est. cost, `PENDING submitted <HH:MM>`.

## After a timeout or interrupt — never call `run` again
1. Wait 1–2 min, then:
   ```json
   findMedia {"mediaType":"video","sortBy":"createdAt","date":{"by":"imported","from":"<YYYY-MM-DD today>"},"limit":5}
   ```
   (`mediaType` "image" for stills.)
2. fal outputs are named `<ISO time>-fal-<requestId>-1-….mp4`. Match an import time after the submit time.
3. Confirm with `lookAtFrames` that its first frame matches the start still. Then mark the ROADMAP line DONE with the media ID.
4. Not there yet → check again every 1–2 min for ~10–15 min. Kling usually lands in 200–300 s; long clips take longer.

## When the tool returns `ok:false` with a `resumeToken`
(still IN_QUEUE / IN_PROGRESS, unsaved outputs, or import failure)
- Save the token on the ROADMAP line.
- Later call `fal {"command":"result","resumeToken":"…"}`. It never charges again. Never `run`.

## reapi (Seedance)
`run` returns a `resumeToken` immediately. Wait `pollAfterSeconds`, then `reapi {"command":"result","resumeToken":"…"}`. Repeat `result`, never `run`.

## Nothing after ~15 min
Tell the user before re-running and log the possible double charge. Never re-run automatically.

## Session start
Read ROADMAP for PENDING lines and run the `findMedia` check above before generating anything.
