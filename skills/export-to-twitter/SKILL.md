---
name: export-to-twitter
description: Export a Kino project (or any video file) as the highest-quality upload X/Twitter accepts. Use when Patrick asks to "export to twitter", "export for X", "make a twitter version", or post-ready export of a cut.
---

# Export to Twitter / X

Two steps: render a full-res master from Kino, then transcode it with the bundled script. Never upload the Kino master directly. A 4K ~43 Mb/s file gets re-encoded hard by X and looks worse than a clean 1080p file.

## 1. Render the master from Kino
- Call `exportVideo` with `container` "mp4", `videoCodec` "h264", `audioCodec` "aac". The project resolution comes through as-is; ITS OVER renders at 3840x2160.
- `outputDirectory`: the project's versions folder if it has one (ITS OVER: `~/Downloads/its-over-cast/versions/`), otherwise `~/Downloads`. Pass the resolved absolute path, not `~`.
- `exportName`: `<PROJECT>-v<N>-<change>` (e.g. `ITS-OVER-v7-swap`). Look at existing files to pick the next N.
- Poll `getVideoExportTask` until `done`. ITS OVER (1:52 at 4K) takes a few minutes.

## 2. Make the Twitter file
```
~/.agents/skills/export-to-twitter/scripts/twitter-export.sh <master.mp4> [out.mp4] [crf]
```
- **The Twitter file ALWAYS goes to the top level of `~/Downloads`** (e.g. `/Users/patrick/Downloads/ITS-OVER-v7-twitter.mp4`) so Patrick can grab it. Never put it in a subfolder or the versions folder. The script enforces this: only the filename of `[out.mp4]` is used.
- The default name is `<master>-twitter.mp4`. For versioned projects, pass `<PROJECT>-v<N>-twitter.mp4`.
- The 4K master stays in the project versions folder.
- Settings:
  - Video: Lanczos downscale to fit 1920x1080 (1080x1920 when vertical), H.264 High 4.2, yuv420p, bt709 tags, 60 fps or less, 2 s GOP.
  - Bitrate: CRF 18 with a 25 Mb/s VBV cap.
  - Audio and file: AAC-LC at 192k, 48 kHz stereo, faststart.
- If the file comes out over X's 512 MB limit, the script raises the CRF automatically. It warns when the video is over 2:20, because only Premium accounts can post that length.
- Earlier ITS OVER exports used CRF 20 (~4.6 Mb/s, 68 MB). CRF 18 is the "as high quality as possible" default. Pass `20` to get the old size back.

## 3. Verify and report
- Spot-check the output with `ffprobe` (the script prints it). Optionally pull one frame: `ffmpeg -ss 10 -i out.mp4 -frames:v 1 /tmp/check.png`.
- Show Patrick the file inline as `![name](/absolute/path.mp4)`, with its size, bitrate and duration.
- Log the export in the project's ROADMAP.md if one exists. Include the version, the change, and both file paths. Back up App.tsx to `versions/v<N>-<change>.App.tsx`.
