# tools

- `lipsync-check.sh video.mp4 "w:h:x:y"`: measures lip-sync lag. It needs ffmpeg/ffprobe and python3, and reads the fps from the video.
- `sync_corr.py dark.txt aud.txt [fps]`: the correlation step, called by `lipsync-check.sh`.
