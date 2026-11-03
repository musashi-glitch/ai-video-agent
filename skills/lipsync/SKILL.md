---
name: lipsync
description: Make singing or talking shots with MiniMax lip-sync image-to-video on fal — cut the audio slice from stems, build a lip-sync-safe still, place the clip on the lyric, and measure sync. Use for any shot where a character's mouth must match vocals or dialogue.
---

# Lip-sync

Use MiniMax, not Kling, for any shot where a mouth must match audio.

## Model
`minimax/h3-max/lip-sync/image-to-video` — `image_url`, `audio_url`, `resolution` "1080P". No prompt. ~$0.96 per 5 s, ~25 s run.

## Steps
1. **Still.** Lip-sync still rule (`skills/stills`): mouth fully visible, open mid-word, mic below the chin, no other faces in frame. MiniMax animates **every** face it sees, including portraits and background singers: blur them in the still or reframe.
2. **Audio slice.** Cut from the isolated vocal stem (not the full mix), at least 5 s, starting slightly before the lyric:
   ```
   ffmpeg -ss <sliceStart> -t <len≥5> -i vocals_lead.wav -ac 2 -ar 48000 projects/<show>/slices/<shot>-<sliceStart>.wav
   ```
   Import with `addMediaToKino` (type `localFile`). Use the show's lyric/word timing file (`BIBLE.md`) instead of auto-transcribed word timing when available.
3. **Run** MiniMax with the still and the slice. Log in `ROADMAP.md` first.
4. **Place** so the lyric lines up:
   `sourceStart = (lyricStart − sliceStart) × fps` frames, position = lyric start on the timeline.
5. **Measure sync:**
   ```
   tools/lipsync-check.sh clip.mp4 "w:h:x:y"
   ```
   The crop is a generous box around the mouth. It correlates mouth darkness with vocal RMS across ±8 frames and prints the best lag. Best lag within ±1 frame is good; otherwise nudge `sourceStart` by the lag.
6. **Verify** with `lookAtFrames`: identity, mouth shape, no extra faces animating.

## Several singers in one shot
Lip-sync each face separately (one still per face, the others blurred or cropped), then composite in the edit.
