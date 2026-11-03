---
name: motion-kling
description: Animate an approved still into a video shot with Kling v3 Pro image-to-video on fal, using the locked settings, prompt pattern and negative prompts. Use for any non-lip-sync motion shot — performers playing, camera moves, drone/crane/fly-through shots.
---

# Motion with Kling v3 Pro

## Locked settings
Endpoint `fal-ai/kling-video/v3/pro/image-to-video`
```json
{
  "start_image_url": "kino://media/<still uuid>",
  "end_image_url": "kino://media/<optional landing still>",
  "prompt": "…",
  "negative_prompt": "…",
  "cfg_scale": 0.5,
  "generate_audio": false,
  "duration": "5"
}
```
- `duration` is a **string**, "3"–"15". Generate a little longer than the slot; trim later.
- `cfg_scale` 0.5–0.55. `generate_audio` always false (cheaper, and the music bed replaces it).
- Cost ~$0.112/s with audio off. Run time ~200–300 s, longer for long clips. **The MCP call times out at 300 s; follow `skills/fal-job-recovery`.**
- Log PENDING in `ROADMAP.md` before every submit.

## Prompt pattern
```
[Subject] is already mid-[action] from the very first frame and keeps [action] the whole time, [specific body detail].
[ONE camera move with an explicit route].
[Lighting/style sentence], background stays consistent.
```
- Mid-action from frame 1 works best. Never ask a performer to "take a breath", "begin", or "start a phrase"; you get a frozen start.
- One camera move per shot. See `playbooks/camera-moves.md`.
- Use `end_image_url` when the shot must land on a specific frame.

## Negative prompt
Base, always:
`morphing face, warped face, extra fingers, extra limbs, frozen, static, pausing, looking at camera, fog, haze, text, camera shake, blur`

Add shot-specific locks, e.g. `lips leaving flute`, `instruments morphing`, `smiling`, `duplicate <character>`.
When portraits or background people must stay still: `portrait moving, portrait face animating, portrait mouth opening, portrait laughing, <group> singing, <group> mouths moving`.

## When the clip is wrong
- Wrong pose at the start → fix the start still (`skills/stills`), re-run. Don't prompt around it.
- Camera does the wrong move → make the route more explicit and add motion negatives (`playbooks/camera-moves.md`).
- Identity drift mid-clip → use only the good frame range, or add `end_image_url`.
- Change only one variable per retry and log what changed.
