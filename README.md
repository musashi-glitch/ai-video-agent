# AI Video Agent

Skills and playbooks that give coding agents (Claude Code, Codex, etc.) a consistent, repeatable workflow for making AI video from images:

**stills → image-to-video → lip-sync → cut to music → export**

Without this, each new agent session picks different models, prompts and processes. With it, every session follows the same locked pipeline, logs every dollar, and never re-pays for a job that timed out.

Built around [Kino](https://kino.ai) (editor + MCP tools) and [fal](https://fal.ai) (generation).

## What's inside
| Path | What |
|---|---|
| `skills/video-pipeline` | **Start here.** Session start, per-section workflow, hard rules |
| `skills/stills` | Start frames, character sheets and swaps (Nano Banana) |
| `skills/motion-kling` | Animate stills (Kling v3 Pro), prompt pattern, negatives |
| `skills/lipsync` | Singing/talking shots (MiniMax), audio slices, sync check |
| `skills/fal-job-recovery` | Timeouts and interrupts without losing or re-paying jobs |
| `skills/timeline-placement` | Place, swap, trim, retime and mute clips in Kino |
| `skills/spend-log` | ROADMAP spend/asset log format |
| `skills/export-to-twitter` | Highest-quality X/Twitter export |
| `playbooks/` | Models, prompt patterns, camera moves |
| `tools/` | Lip-sync lag checker |
| `projects/_example/` | Template show folder: BIBLE, shot list, cut list, ROADMAP, prompts |

## Requirements
- Kino desktop with its MCP server connected to your agent
- fal access (through Kino's `fal` tool)
- `ffmpeg`/`ffprobe`, `python3`, `bash`

## Install
```
git clone https://github.com/<you>/ai-video-agent ~/code/ai-video-agent
cd ~/code/ai-video-agent && ./install.sh
```
`install.sh` symlinks each skill into `~/.agents/skills/` and `~/.claude/skills/`, so a `git pull` updates every agent. Existing entries with the same name are moved to `*.bak-<timestamp>`, never deleted.

## Start a show
```
cp -R projects/_example projects/my-show
```
Fill in `projects/my-show/BIBLE.md` (style block, cast, set, rules, paths, budget). Everything under `projects/` except `_example` is gitignored, and so are media files and `stills/ slices/ backups/ versions/ renders/` everywhere.

Then tell your agent: *"Use the video-pipeline skill for projects/my-show."*

## Contributing
Keep skills generic: no show names, media IDs or likenesses. Add durable lessons to the matching skill or playbook.

## License
MIT
