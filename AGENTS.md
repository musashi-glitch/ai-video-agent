# AGENTS

This repo is a set of skills and playbooks for making AI video in Kino with fal.

1. Read `skills/video-pipeline/SKILL.md` first, every session. It sets the order of work and links the other skills.
2. Read `projects/<show>/BIBLE.md` and `ROADMAP.md` for the show you're working on. Show rules override the defaults.
3. Check `ROADMAP.md` for PENDING jobs before generating anything (`skills/fal-job-recovery`).
4. Use only the models in `playbooks/models.md`. Never switch models silently; quote the price before each batch.
5. Stop and show after each section.

## Editing this repo
- Keep skills generic. Show-specific names, media IDs, likenesses, budgets and paths go only in `projects/<show>/` (gitignored).
- Each skill is `skills/<name>/SKILL.md` with `name` and `description` frontmatter. Keep descriptions trigger-oriented.
- When a session learns something durable (a model setting, a camera lesson), add it to the matching skill or playbook, not a show file.
