# Prompt patterns

## Still (Nano Banana)
```
<STYLE block from BIBLE.md, verbatim>
Shot <n>: <framing>, <camera height/angle>. <Character A> (the <role> from the 1st reference image: <2–3 traits>) is <pose, already mid-action>, <expression>. <Character B> … Background: <set plate from the Nth reference image>. No text anywhere except <allowed text>.
```

## Still edit
```
Edit the first image. Keep EXACTLY the same position, size, pose, camera angle, lighting and background. Change only: <one change>.
```

## Character block (put in BIBLE.md, one per character)
```
<Name/role>: <age range>, <face shape>, <hair>, <eye colour>, <build>, <wardrobe>, <signature detail>.
```

## Kling motion
```
<Subject> is already mid-<action> from the very first frame and keeps <action> the whole time, <body detail>. <One camera move with explicit route>. <Lighting sentence>, background stays consistent.
```
Negative: `morphing face, warped face, extra fingers, extra limbs, frozen, static, pausing, looking at camera, fog, haze, text, camera shake, blur` + shot-specific locks.

## Lip-sync still
Mouth fully visible, open mid-word, mic just below the chin, no other faces in frame.

## "Kino move"
Not every shot needs a generation. A slow push or pan on a still inside the edit (scale/translate keyframes) is free and stable; use it for inserts and held moments.

## Anti-patterns
- "takes a breath", "begins to play", "starts singing" → frozen first second.
- Several camera moves in one prompt → chaotic.
- Stacking 2+ edits on one still → identity drift.
- "FPV" → a literal drone appears in frame.
