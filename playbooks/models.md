# Models (locked)

Prices are what we measured as of late 2026. Always call fal `pricing` before a batch; it's the source of truth.

| Job | Endpoint | Key settings | ~Cost | ~Time |
|---|---|---|---|---|
| Shot stills, edits | `google/nano-banana-2.1/edit` | 2K, 16:9, refs in `image_urls` | $0.07 | fast |
| Character sheets, swaps, identity fixes | `fal-ai/nano-banana-pro/edit` | 2K, 16:9, `num_images` 1–2 | $0.15 | fast |
| Motion | `fal-ai/kling-video/v3/pro/image-to-video` | cfg 0.5–0.55, `generate_audio` false, `duration` "3"–"15" (string) | $0.112/s | 200–300 s |
| Lip-sync | `minimax/h3-max/lip-sync/image-to-video` | 1080P, `image_url` + `audio_url` | $0.96 / 5 s | ~25 s |

## Not by default
Use only when the user asks by name: Kling v4, Kling turbo, Kling v2.6, Seedance (reapi or fal), sync-lipsync, Higgsfield.
- Seedance costs 1.5–2.5× Kling and has a different look. Valid only for whole-clip video edits (restyle, character swap on existing footage). If a re-still plus Kling can't do the job, propose `doubao-seedance-2.5-eco` (edit, `duration` -1, `size` "adaptive") with a price quote and wait for a yes.

## Why these
- One stills model and one motion model keep the look consistent across sessions and shots.
- Kling v3 Pro holds identity from the start still and follows explicit camera routes.
- MiniMax lip-sync matches mouths far better than prompting a motion model to sing.
