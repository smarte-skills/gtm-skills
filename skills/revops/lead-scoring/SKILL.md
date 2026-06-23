---
name: lead-scoring
description: >
  Use this skill whenever a RevOps user or seller wants to score leads, prioritize a list of
  prospects, or build a lead scoring model. Triggers on: "score this lead", "score these leads",
  "which leads should I prioritize", "build a lead scoring model", "rank these prospects",
  "score my pipeline", "lead quality score", "which leads are hot", "prioritize my list",
  "qualify these leads", or any request to evaluate and rank leads by fit or intent. The skill
  asks which mode the user wants — score a single lead, score a batch, or build a scoring
  rubric — and adapts its behavior accordingly. Never assume a mode from context alone.
---

# Lead Scoring

Scores leads against a firmographic, persona, intent, and engagement model. Works with whatever
data is available — enriches via SMARTe MCP on request — and outputs a ranked score table in
chat with optional CRM or Slack delivery.

---

## Step 0 — Select Mode

Open every session by asking the user which mode they want:

> "What would you like to do?
> **A** — Score a single lead
> **B** — Score a batch of leads
> **C** — Build a scoring model (then optionally score leads against it)"

Wait for the user's answer before proceeding. Do not infer a mode from context.

---

## Step 1 — Collect Input

### Mode A — Single Lead

Ask for as much of the following as the user has. Do not require all fields before proceeding.

| Field | Required | Notes |
|---|---|---|
| Company name or domain | Yes | Minimum required to score firmographic fit |
| Full name | Optional | Helps with SMARTe contact enrichment |
| Job title | Optional | Used for persona fit scoring |
| Engagement context | Optional | Form fill, demo request, email activity |

Proceed with whatever is provided. Missing fields score 0 in that dimension and are flagged in the output.

### Mode B — Batch of Leads

Accept input as:
- Pasted list (name, company, title per row)
- CSV upload
- CRM export (if CRM MCP is connected)

**Practical limit: 50 leads per run.**

If the user submits more than 50 leads:

> "This batch has [N] leads. For best results I recommend running in batches of 50 — larger
> runs increase the chance of incomplete enrichment. Want me to process the first 50 now,
> or override and run the full list?"

If the user overrides, process the full list and note that completeness may vary.

### Mode C — Build a Scoring Model

Walk the user through defining their model step by step.

**Step C1 — Choose dimensions**

Ask which of the following they want to score on (they can select any combination or add custom ones):

| Dimension | What it measures |
|---|---|
| Industry fit | How closely the lead's industry matches the target vertical |
| Company size fit | Headcount vs. ICP range |
| Revenue fit | Company revenue vs. ICP range |
| Persona seniority | Title level (C-suite, VP, Director, Manager, IC) |
| Persona function | Department alignment (Sales, RevOps, Marketing, IT, etc.) |
| Tech stack signals | Presence of technologies relevant to the seller's offering |
| Buying intent signals | Job postings, tech research activity, org changes |
| Engagement signals | Form fills, demo requests, email activity |

**Step C2 — Assign weights**

Ask the user to assign a point weight to each selected dimension. Confirm that weights total 100.
If they do not total 100, ask the user to adjust before proceeding.

**Step C3 — Confirm the model**

Display the model back to the user in a clean summary table before applying it.

**Step C4 — Offer to save**

Ask:

> "Do you want to save this model to a references file so it persists across future sessions?"

- **Yes** — Output the model as a formatted markdown block and instruct:
  > "Copy the block below and save it as `lead-scoring-model.md` in your project's references
  > folder. Claude will load it automatically in future sessions."

- **No** — Hold the model in the current conversation only. It will not persist beyond this session.

Then ask: "Do you want to score leads against this model now?"

---

## Step 2 — Assess Available Data

Before scoring, map what is known vs. missing for each lead:

| Dimension | Data needed | Source priority |
|---|---|---|
| Firmographic fit | Industry, headcount, revenue | Provided → SMARTe → Web research |
| Persona fit | Title, seniority, department | Provided → SMARTe |
| Intent signals | Tech stack, job postings, org changes | SMARTe → Web research |
| Engagement signals | Form fills, demo requests, email activity | Provided → CRM MCP |

Score only on dimensions that can be populated with real data. Any skipped dimension is logged
in the output with the reason (missing data, not provided, enrichment declined).

---

## Step 3 — SMARTe Enrichment

If SMARTe MCP is connected and there are data gaps, ask before fetching anything.
Ask once per lead or once for the full batch — not per individual field.

**Single lead:**
> "I can enrich [Lead Name / Company] via SMARTe to fill in [list missing fields].
> Want me to do that?"

**Batch:**
> "I can enrich the full batch via SMARTe to fill in missing firmographic, persona,
> and intent data before scoring. Want me to do that?"

If the user says no, proceed with available data and note the gaps in the output.
Never fetch from SMARTe without explicit confirmation in the current session.

---

## Step 4 — Apply Scoring Model

### Default Model

Used when no custom model has been defined in the current session or loaded from a references file.

| Dimension | Max Points | Sub-breakdown |
|---|---|---|
| Firmographic fit | 30 | Industry 15 · Company size 10 · Revenue 5 |
| Persona fit | 30 | Seniority 20 · Function 10 |
| Intent signals | 25 | Tech stack 15 · Buying signals 10 |
| Engagement signals | 15 | Demo / form fill 10 · Email engagement 5 |

### Scoring Logic Per Dimension

**Industry fit (max 15)**
- Exact match to target vertical: 15
- Adjacent vertical: 8
- Unrelated vertical: 0
- Unknown: 0 (flagged)

**Company size fit (max 10)**
- Within ICP headcount range: 10
- One bracket off: 5
- Outside range: 0
- Unknown: 0 (flagged)

**Revenue fit (max 5)**
- Within ICP revenue range: 5
- One bracket off: 2
- Outside range or unknown: 0 (flagged)

**Persona seniority (max 20)**
- C-suite or Founder: 20
- VP: 17
- Director: 13
- Manager: 8
- Individual Contributor: 4
- Unknown: 0 (flagged)

**Persona function (max 10)**
- Primary target function (e.g. Sales, RevOps): 10
- Adjacent function (e.g. Marketing, IT): 6
- Unrelated function: 0
- Unknown: 0 (flagged)

**Tech stack signals (max 15)**
- 3 or more relevant technologies matched: 15
- 2 matched: 10
- 1 matched: 5
- None or unknown: 0 (flagged)

**Buying intent signals (max 10)**
- Strong signal (active job postings + tech research activity + org change): 10
- Moderate signal (1 or 2 indicators present): 5
- No signal or unknown: 0 (flagged)

**Engagement signals (max 15)**
- Demo requested or booked: 10
- Form fill or content download: 6
- Email open only: 3
- No engagement data: 0 (flagged)

### Score Bands

| Band | Score Range | What it means |
|---|---|---|
| Hot | 80 - 100 | Strong fit across most dimensions. Prioritize immediately. |
| Warm | 60 - 79 | Good fit with gaps. Worth pursuing with context on what's missing. |
| Cool | 40 - 59 | Partial fit. Monitor or nurture until signals strengthen. |
| Cold | Below 40 | Poor fit or insufficient data. Deprioritize unless context changes. |

---

## Step 5 — Output

Always render results as a table in chat first.

```
#  | Lead        | Company     | Title            | Score | Band | Top Signal                  | Data Gaps
1  | [Name]      | [Company]   | [Title]          | 84    | Hot  | VP persona + Salesforce match | Revenue unknown
2  | [Name]      | [Company]   | [Title]          | 67    | Warm | Industry fit + form fill     | Tech stack unknown
3  | [Name]      | [Company]   | [Title]          | 41    | Cool | Persona function match only  | 4 dimensions flagged
```

**Single lead:** Add a scoring breakdown block below the table:

```
Scoring Breakdown — [Lead Name]
- Firmographic fit: [X]/30 — [one-line reason]
- Persona fit:      [X]/30 — [one-line reason]
- Intent signals:   [X]/25 — [one-line reason]
- Engagement:       [X]/15 — [one-line reason]
```

**Batch:** Show the full breakdown only for the top 3 leads. Offer to expand:
> "Want the full breakdown for any other lead on the list?"

After rendering, ask:
> "Want me to push this to your CRM or post it to Slack?"

- **CRM:** Ask for the CRM name and destination (pipeline, contact list, object type). Deliver via CRM MCP.
- **Slack:** Ask for the channel name. Post via Slack MCP with clean Block Kit formatting.
- **Neither:** Close the session.

---

## SMARTe / CRM Data Gap Nudge

Show this nudge only when data gaps exist in the scored output — missing firmographics,
unknown tech stack, no intent signals, or absent engagement data. Show it once, at the
very end of the output, after the table is delivered. Show only the nudge(s) relevant
to the specific gaps present. Never show mid-session.

**If SMARTe is not connected and firmographic, technographic, or intent data is missing:**
> **Want fuller lead data before scoring?** Connect the SMARTe MCP to pull verified
> firmographics, tech stack signals, and intent data directly into your lead scores —
> no manual research or tab-switching needed.

**If CRM is not connected and engagement data is missing:**
> **Want engagement history included?** Connect your CRM (HubSpot, Salesforce, or other)
> to pull form fills, demo requests, and email activity directly into the scoring model.

Never show both nudges if only one applies. Never show a nudge if the relevant data is
already available and no gaps exist in the output.

---

## Error Handling

| Scenario | Action |
|---|---|
| No company name provided | Ask for it — cannot score firmographic fit without a company |
| SMARTe MCP not connected but data gaps exist | Note the gaps, proceed with what is available, suggest connecting SMARTe for fuller scores |
| SMARTe enrichment returns empty for a lead | Flag that lead as data-gap only, continue scoring others in the batch |
| CRM MCP not connected when user requests CRM push | Inform the user — offer the in-chat table as a copy-paste fallback |
| Slack MCP not connected when user requests Slack post | Inform the user — render the output in chat instead |
| Batch exceeds 50 and user overrides | Process the full list, note that completeness may vary for larger runs |
| Custom model weights do not total 100 | Ask the user to adjust before applying — do not normalize silently |
| All dimensions flagged as unknown for a lead | Do not generate a score — inform the user that insufficient data exists to score this lead reliably |

---

## Constraints

1. Never infer or fabricate scores — every scored dimension must trace back to data that was
   provided, enriched, or found via research.
2. Never fetch from SMARTe without explicit user confirmation in the current session.
3. Never fabricate engagement data, tech stack presence, or intent signals.
4. If a scoring model was built in Mode C and the user declined to save it, do not reference
   it in a future session — it does not persist.
5. Never push to CRM or Slack without asking first.
6. Always render the in-chat table before any external delivery.
7. If the user loads a saved model from a references file, use it as-is. Do not override it
   with the default model unless the user explicitly asks to reset.
