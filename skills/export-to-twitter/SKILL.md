---
name: export-to-twitter
description: Export a Kino project (or any video file) as the highest-quality upload X/Twitter accepts. Use when the user asks to "export to twitter", "export for X", "make a twitter version", or wants a post-ready export of a cut.
---

# Export to Twitter / X

Two steps: render a full-res master from Kino, then transcode it with the bundled script. Never upload the Kino master directly. A 4K ~40 Mb/s file gets re-encoded hard by X and looks worse than a clean 1080p file.

## 1. Render the master from Kino
- Call `exportVideo` with `container` "mp4", `videoCodec` "h264", `audioCodec` "aac". The project resolution comes through as-is (render at full size, e.g. 4K).
- `outputDirectory`: `projects/<show>/versions/` if the show has one, otherwise the user's Downloads folder. Pass the resolved absolute path, not `~`.
- `exportName`: `<SHOW>-v<N>-<change>`. Look at existing files to pick the next N.
- Poll `getVideoExportTask` until `done`.

## 2. Make the Twitter file
```
skills/export-to-twitter/scripts/twitter-export.sh <master.mp4> [out.mp4] [crf]
```
(From the repo root, or `~/.agents/skills/export-to-twitter/scripts/` after `install.sh`.)
- Output goes to the top level of `~/Downloads` so it's easy to grab; only the filename of `[out.mp4]` is used. Set `TWITTER_EXPORT_DIR` to change the folder.
- Default name `<master>-twitter.mp4`; for versioned shows pass `<SHOW>-v<N>-twitter.mp4`.
- Settings:
  - Video: Lanczos downscale to fit 1920x1080 (1080x1920 vertical), H.264 High 4.2, yuv420p, bt709 tags, ≤60 fps, 2 s GOP.
  - Bitrate: CRF 18 with a 25 Mb/s VBV cap. Pass `20` for a smaller file.
  - Audio/file: AAC-LC 192k, 48 kHz stereo, faststart.
- Over X's 512 MB limit → the script raises CRF automatically. It warns over 2:20 (Premium-only length).

## 3. Verify and report
- The script prints `ffprobe`. Optionally pull a frame: `ffmpeg -ss 10 -i out.mp4 -frames:v 1 /tmp/check.png`.
- Show the file inline as `![name](/absolute/path.mp4)` with size, bitrate and duration.
- Log the export in `projects/<show>/ROADMAP.md`: version, change, both paths. Back up `App.tsx` to `versions/v<N>-<change>.App.tsx`.
