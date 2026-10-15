# SharePoint Skills by Anand Vijayaragavan

Skills-only plugin. Nothing is hosted and nothing signs in to your tenant: your agent follows a skill, produces files (HTML/PDF), and you upload them to SharePoint yourself.

| Skill | What it does |
|---|---|
| team-newsletter-publisher | Filled Team Newsletter Word file -> designed HTML page and/or PDF (PnP PR #74, pending merge) |
| campaign-story | Animated, narrated B2B campaign / customer story (HTML) |
| narrated-story-animation | Cinematic narrated story animation (HTML) |
| topic-explainer | Interactive explainer dashboard for a topic |
| flashcards-dashboard | Flashcard learning dashboard from a source file |
| document-browser | Live-linked document browser for a SharePoint library |

Invoke with `/skill-name` or just describe the task.

## Source and credit
All skills are maintained in the PnP community repo [pnp/sharepoint-skills](https://github.com/pnp/sharepoint-skills) (MIT, Microsoft 365 Community), which stays the master copy. Each skill folder has a `SOURCE.md` with the exact ref. Refresh with `scripts/sync-skills.sh`.
