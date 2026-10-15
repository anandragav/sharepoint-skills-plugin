---
name: team-dashboard
description: |-
  Turn a filled Team Newsletter Lite Word file into an interactive HTML dashboard
  with KPI tiles, a hero metric, metric cards, a featured story panel, news cards,
  an events table, and a live countdown to the next event. Same 13-field extraction
  as the newsletter publisher, but the output is data-forward widgets instead of a
  published page. Save the HTML to SharePoint/OneDrive (or Copilot Creations).

  Use when the user says:
  - "make a dashboard from this newsletter"
  - "turn this into a dashboard"
  - "create KPI cards from this Word file"
  - "build the team dashboard"
  - "make metrics from the newsletter form"
---
# Team Dashboard from Newsletter Lite

## When to use
Use for a filled Word document based on `Team_Newsletter_Lite_Template` when the
user wants an interactive, data-forward HTML dashboard rather than a published
newsletter page. Do not use for the full Team Newsletter template, content
drafting, or unrelated documents.

## Inputs
- One filled Team Newsletter Lite `.docx` file.
- An optional hero image (`.jpg`, `.jpeg`, or `.png`) in the same folder.

## Steps
1. Read the Word document and extract these fields exactly as written:
   `IssueMonth`, `IssueSummary`, `FeaturedTitle`, `FeaturedBody`,
   `FeaturedAction`, `News1_Title`, `News1_Body`, `News2_Title`, `News2_Body`,
   `Event1_DateTime`, `Event1_Title`, and `NextDeadline`.
   - Read them under the fixed headings: `DEPARTMENT NEWSLETTER`,
     `1 · Featured story`, `2 · Latest news`, `3 · Coming up`, and
     `Deadline for next issue:`.
   - Treat blank fields and unfilled placeholders as empty.
   - Format an IssueMonth date as `Month Year` only. Do not rewrite any other
     text.

2. Find the hero image in the same folder as the Word file.
   - Prefer the newest `.jpg`, `.jpeg`, or `.png` whose name contains `hero`,
     case-insensitively.
   - Otherwise choose the newest image file in that folder.
   - Do not use the embedded Word-image reference.
   - Embed via the file-output image manifest (`{img:hero}`), not a remote
     SharePoint URL, so the image loads in SharePoint's viewer.

3. Build the HTML from `dashboard-template.html`.
   - Keep its styling and structure.
   - Replace field tokens, remove optional blocks for empty fields, and renumber
     sections if a whole section is removed.
   - The template includes these dashboard widgets beyond the newsletter fields:
     - **Hero KPI tile** (spans two columns): label, value, subtext, and a
       progress bar. The skill should populate `HeroKpi_Label`,
       `HeroKpi_Value`, `HeroKpi_Sub`, and `HeroKpi_Pct` from the most
       meaningful numeric signal in the document (e.g. a count, percentage, or
       the featured story's implied metric). If no numeric signal exists, remove
       the hero KPI tile and let the four smaller KPI slots carry any available
       numbers, or remove those too.
     - **Four KPI slots** (`Kpi2`–`Kpi4` plus the hero): each has a label,
       value, and subtext. Auto-tone values that start with `+` or `up` green,
       and `-` or `down` red, via the template's script.
     - **Live countdown**: the template renders a days/hours/minutes countdown
       to `Event1_DateTime` and flips to an "expired" style when the date
       passes. No extra work needed beyond filling the event date.
   - Do not shrink fonts or compress content to force a single viewport.

4. Validate before saving.
   - Confirm no unreplaced field tokens remain.
   - Confirm every populated field appears in the HTML.
   - Confirm empty optional blocks were removed, not left blank.
   - Confirm the countdown element has a valid target date when an event date
     exists.
   - Confirm no external scripts, stylesheets, fonts, or image URL
     dependencies (inline CSS/JS and the embedded hero only).
   - Confirm no direct localStorage/sessionStorage access outside a
     try/catch safe wrapper (the template's countdown uses none, which is fine).

5. Save the finished HTML.
   - Prefer saving beside the source Word file when writable; otherwise use the
     site's `Copilot Creations` folder or the current site's primary Documents
     library.
   - Save as `Team-Dashboard-<Month>-<Year>.html`.
   - Never overwrite an existing output; add `-v2`, `-v3`, and so on.
   - If access is denied, retry in the primary Documents library or ask for a
     destination.

## Output format
Reply in 2–4 lines:
- Link the HTML file created.
- State `Image: included (<file name>)`, or state that no image was found and
  name the folder where one should be uploaded.
- List fields hidden because they were empty, if any.
- State that the dashboard includes KPI tiles, the featured story, news cards,
  the events table, and the live countdown.

## Quality checklist
- [ ] Real `.html` file saved in SharePoint/OneDrive or Copilot Creations.
- [ ] All 13 newsletter fields extracted exactly as written; IssueMonth formatted
      as Month Year.
- [ ] Hero KPI populated from a real numeric signal, or removed when none exists.
- [ ] Empty blocks removed, not left blank; sections renumbered.
- [ ] Countdown targets Event1_DateTime and handles past dates.
- [ ] KPI auto-toning works for +/- values.
- [ ] No unreplaced field tokens remain.
- [ ] No external dependencies; works in SharePoint sandboxed preview.
- [ ] Hero image embedded via manifest when found.
- [ ] If tools fail or return empty, say so plainly — don't invent content.
