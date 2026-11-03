#!/usr/bin/env bash
# Usage: twitter-export.sh <master.mp4> [out.mp4] [crf]
# Turns a high-res master (e.g. Kino 4K export) into the best-looking file X/Twitter accepts:
# H.264 High 4.2, yuv420p bt709, max 1920x1080 (or 1080x1920 vertical), <=60fps, AAC-LC 192k 48kHz,
# faststart, 2s GOP, VBV-capped CRF. Auto-raises CRF if the file would exceed X's 512 MB limit.
# Output lands in $TWITTER_EXPORT_DIR (default ~/Downloads); only the filename of [out.mp4] is used.
set -euo pipefail
in="${1:?usage: twitter-export.sh <master.mp4> [out.mp4] [crf]}"
name="$(basename "${2:-$(basename "${in%.*}")-twitter.mp4}")"
out_dir="${TWITTER_EXPORT_DIR:-$HOME/Downloads}"
mkdir -p "$out_dir"
out="$out_dir/$name"
crf="${3:-18}"
limit_bytes=$((512*1000*1000))

IFS=, read -r w h fps_raw < <(ffprobe -v error -select_streams v:0 -show_entries stream=width,height,r_frame_rate -of csv=p=0 "$in")
dur=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$in")
fps=$(python3 -c "from fractions import Fraction as F; f=float(F('$fps_raw')); print(f if f<=60 else 60)")
gop=$(python3 -c "print(round($fps*2))")
if (( w >= h )); then box="1920:1080"; else box="1080:1920"; fi
vf="scale=${box}:force_original_aspect_ratio=decrease:flags=lanczos,scale=trunc(iw/2)*2:trunc(ih/2)*2,fps=${fps},format=yuv420p"

encode() {
  ffmpeg -hide_banner -loglevel warning -stats -y -i "$in" \
    -map 0:v:0 -map 0:a:0? -vf "$vf" \
    -c:v libx264 -preset slow -crf "$1" -maxrate 25M -bufsize 50M \
    -profile:v high -level:v 4.2 -g "$gop" -keyint_min "$gop" -bf 2 \
    -colorspace bt709 -color_primaries bt709 -color_trc bt709 -color_range tv \
    -c:a aac -b:a 192k -ar 48000 -ac 2 \
    -movflags +faststart "$out"
}

while :; do
  echo "Encoding ${w}x${h}@${fps_raw} -> fit ${box} @${fps}fps, CRF ${crf}"
  encode "$crf"
  size=$(stat -f%z "$out" 2>/dev/null || stat -c%s "$out")
  if (( size <= limit_bytes )) || (( crf >= 28 )); then break; fi
  crf=$((crf+2)); echo "Too big ($size bytes), retrying at CRF $crf"
done

python3 - "$dur" "$size" <<'PY'
import sys; d=float(sys.argv[1]); s=int(sys.argv[2])
print(f"Duration {d:.1f}s, size {s/1e6:.1f} MB, avg {s*8/d/1e6:.1f} Mb/s")
if d>140: print("WARNING: over 2:20 - only X Premium accounts can post this length.")
if s>512e6: print("WARNING: still over 512 MB.")
PY
ffprobe -v error -show_entries stream=codec_name,profile,level,width,height,r_frame_rate,pix_fmt,sample_rate,channels -of compact "$out"
echo "$out"
