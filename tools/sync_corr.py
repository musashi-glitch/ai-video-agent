#!/usr/bin/env python3
"""Correlate mouth darkness against vocal RMS to estimate lip-sync lag.
usage: sync_corr.py dark.txt aud.txt [fps]"""
import re, sys

mf = sys.argv[1] if len(sys.argv) > 1 else "dark.txt"
af = sys.argv[2] if len(sys.argv) > 2 else "aud.txt"
fps = float(sys.argv[3]) if len(sys.argv) > 3 else 30.0

m = [float(x) for x in re.findall(r"YAVG=([\d.]+)", open(mf).read())]
a = [-90.0 if "inf" in x else float(x) for x in re.findall(r"RMS_level=(\S+)", open(af).read())]
n = min(len(m), len(a))
if n < 10:
    sys.exit(f"not enough samples ({n})")
m, a = m[:n], a[:n]
peak = max(m) or 1
mouth = [v / peak for v in m]
lo, hi = min(a), max(a)
audio = [(v - lo) / ((hi - lo) or 1) for v in a]


def corr(x, y):
    k = len(x)
    mean_x, mean_y = sum(x) / k, sum(y) / k
    sx = sum((v - mean_x) ** 2 for v in x) ** 0.5
    sy = sum((v - mean_y) ** 2 for v in y) ** 0.5
    return sum((p - mean_x) * (q - mean_y) for p, q in zip(x, y)) / (sx * sy) if sx and sy else 0


results = []
for lag in range(-8, 9):
    x, y = (mouth[lag:], audio[: n - lag]) if lag >= 0 else (mouth[: n + lag], audio[-lag:])
    results.append((lag, corr(x, y)))
for lag, c in results:
    print(f"lag {lag:+d}f ({lag / fps * 1000:+.0f}ms): r={c:+.3f} " + "#" * int(max(c, 0) * 40))
best = max(results, key=lambda t: t[1])
print(f"BEST lag {best[0]:+d}f r={best[1]:+.3f}  (positive = mouth lags audio)")
print("\nt     audio                mouth")
for i in range(n):
    print(f"{i / fps:5.2f} {'█' * int(audio[i] * 20):20s} {'█' * int(mouth[i] * 20)}")
