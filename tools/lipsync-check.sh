#!/usr/bin/env bash
# usage: lipsync-check.sh video.mp4 "w:h:x:y"
# The crop is a generous box around the mouth (ffmpeg crop syntax, source pixels).
set -euo pipefail
video="${1:?usage: lipsync-check.sh video.mp4 \"w:h:x:y\"}"
crop="${2:?mouth crop w:h:x:y}"
here="$(cd "$(dirname "$0")" && pwd)"
tmp="$(mktemp -d)"
fps="$(ffprobe -v error -select_streams v:0 -show_entries stream=r_frame_rate -of csv=p=0 "$video" | python3 -c 'import sys;from fractions import Fraction as F;print(float(F(sys.stdin.read().strip())))')"
samples="$(python3 -c "print(round(48000/$fps))")"
ffmpeg -hide_banner -loglevel error -i "$video" -vf "crop=$crop,format=gray,lut=y='if(lt(val,55),255,0)',signalstats,metadata=print:key=lavfi.signalstats.YAVG:file=$tmp/dark.txt" -f null -
ffmpeg -hide_banner -loglevel error -i "$video" -af "aresample=48000,highpass=f=250,lowpass=f=3500,asetnsamples=n=$samples,astats=metadata=1:reset=1,ametadata=print:key=lavfi.astats.Overall.RMS_level:file=$tmp/aud.txt" -f null -
python3 "$here/sync_corr.py" "$tmp/dark.txt" "$tmp/aud.txt" "$fps"
