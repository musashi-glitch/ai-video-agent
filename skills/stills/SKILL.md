---
name: stills
description: Generate and edit start-frame stills, character sheets and character swaps with Nano Banana on fal for an AI video project. Use when making a shot's first frame, fixing a pose, matching an angle, or building/swapping a character before animation.
---

# Stills

## Models
| Job | Endpoint | Settings | Cost (verify with `pricing`) |
|---|---|---|---|
| Shot stills, single edits, pose fixes | `google/nano-banana-2.1/edit` | `image_urls` [refs], `prompt`, `resolution` "2K", `aspect_ratio` "16:9" | ~$0.07 |
| Character sheets, turnarounds, character swaps, hard identity fixes | `fal-ai/nano-banana-pro/edit` | same fields, `num_images` 1–2 | ~$0.15 |

Use `outputMode` "media" so results import into Kino.

## References (attach every time)
Pass in `image_urls`, in a stable order you name in the prompt ("the man from the 2nd reference image"):
1. Character sheet(s) of everyone in frame.
2. Location / set plate.
3. Detail refs the BIBLE requires (wardrobe pin, prop, logo).
4. The previous approved still, when the angle must match the shot before it.

## Prompt structure
1. The show's **STYLE block** from `BIBLE.md`, verbatim, first.
2. The shot: number, framing, camera height and angle.
3. Who is in it: "the X from the Nth reference image" plus 2–3 key identity traits.
4. Pose and expression, already mid-action (the still is frame 1 of the clip).
5. Exclusions: "No text anywhere except …".

**Edit prompts** start: "Edit the first image. Keep EXACTLY the same position, size, pose, camera angle, lighting and background. Change only: …". Change one thing per edit.

## Rules
- A still may be edited **at most once** before animating. Otherwise regenerate from clean references.
- **Lip-sync stills:** mouth fully visible and open mid-word; mic (if any) just below the chin, never covering the mouth; no other faces in frame, or they get blurred/cropped (MiniMax animates every face).
- Background portraits, posters and photos: describe them as "flat printed photograph" so motion models keep them still.
- Show new concepts to the user as stills before spending on animation.
- Check every result with `lookAtFrames` (or view the image) for identity, extra limbs, duplicates and wardrobe details.
