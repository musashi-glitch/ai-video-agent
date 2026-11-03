# projects

One folder per show. Only `_example/` is committed; everything else here is gitignored, so your assets, likenesses and budgets stay local.

Start a show:
```
cp -R projects/_example projects/<show>
```
Then fill in `BIBLE.md` (style, cast, set, rules, paths) before generating. Agents read `BIBLE.md` and `ROADMAP.md` at the start of every session.

| File | Purpose |
|---|---|
| `BIBLE.md` | Style block, cast identity blocks, set geography, content rules, paths, budget |
| `SHOTLIST.md` | Plan against the bar grid |
| `CUTLIST.md` | What's on the timeline now |
| `ROADMAP.md` | Spend log, pending jobs, asset IDs, exports |
| `prompts.md` | Exact prompts of approved takes |
