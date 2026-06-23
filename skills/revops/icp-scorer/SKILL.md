---
name: icp-scorer
description: >
  Use this skill whenever a RevOps user wants to score accounts against an Ideal Customer
  Profile, build an ICP from scratch, or audit whether an existing ICP reflects actual
  closed-won patterns. Triggers on: "score these accounts against our ICP", "how well do
  these accounts fit our ICP", "build an ICP", "define our ideal customer profile", "audit
  our ICP", "does our ICP match our best customers", "which accounts are best fit", "ICP
  scoring", "fit score for these accounts", "rank accounts by ICP fit", or any request to
  evaluate, define, or validate an Ideal Customer Profile. Defaults to scoring mode — if
  the user has an ICP and a list of accounts, proceed directly to scoring.
---

# ICP Scorer

Scores accounts against a firmographic and technographic Ideal Customer Profile. Builds
ICPs from scratch, applies them to account lists from any source, and audits existing
definitions against closed-won data — with recommendations where the ICP should be refined.

---

## Step 0 — Select Mode

Open by asking which mode the user wants. Present Mode B as the default:

> "I can help with ICP scoring in a few ways:
> **A** — Define an ICP (build your criteria from scratch or from closed-won patterns)
> **B** — Score accounts against an ICP (default — bring your ICP, apply it to a list)
> **C** — Audit an existing ICP (check whether your current definition matches your best customers)
>
> Which would you like? If you already have an ICP and a list of accounts ready, I'll go straight to B."

Wait for the user's answer. If they confirm B or do not specify, proceed with Mode B.

---

## Step 1 — ICP Definition

### Mode A — Define an ICP

Walk the user through building an ICP across the following dimensions. Ask one dimension at a time — do not front-load all questions.

**Firmographic dimensions:**

| Dimension | What to ask |
|---|---|
| Industry | Which verticals are your best-fit customers in? Are there any verticals you explicitly exclude? |
| Company size | What headcount range do your best customers fall in? |
| Revenue | What revenue range do your best customers fall in? |
| Geography | Which countries or regions are in scope as primary markets? Any secondary markets? |

**Technographic dimensions:**

| Dimension | What to ask |
|---|---|
| Tech stack signals | Are there specific technologies your best customers tend to use? Any tools that are a strong positive or negative signal? |

**Persona and behavioral dimensions (conditional):**

After firmographic and technographic, ask:

> "Do you want to factor in persona-level fit (e.g. you only sell to VP and above) or
> deal characteristics (e.g. multi-stakeholder deals only, minimum deal size)? Or keep
> the ICP at the account level for now?"

If the user wants persona or behavioral dimensions, fold them in as additional scoring criteria.
If they want to keep it at account level, proceed without them.

**Save the ICP:**

Once the ICP is defined, ask:

> "Do you want to save this ICP to a references file so it loads automatically in future sessions?"

- **Yes** — Format the ICP as a clean markdown block and instruct:
  > "Copy the block below and save it as `icp-definition.md` in your project's references
  > folder. Claude will load it automatically next time."

- **No** — Hold the ICP in the current session only. It will not persist beyond this conversation.

Then ask: "Do you want to score accounts against this ICP now?"

---

### Mode B — Score Accounts Against an ICP

Ask for the ICP definition. Accept it in any of these forms:

- Pasted description or table from the user
- Loaded from a references file (if `icp-definition.md` exists from a prior Mode A session)
- Built on the fly within this session using the Mode A flow above

If the user says they have an ICP but has not shared it yet, ask:

> "Can you share your ICP criteria? Even a rough description works — I'll structure it before scoring."

---

### Mode C — Audit an Existing ICP

Ask for two things:

1. The existing ICP definition (same acceptance formats as Mode B)
2. A list of closed-won accounts to compare against (paste, CSV, or CRM MCP if connected)

The skill compares how well the ICP criteria actually match the closed-won accounts, surfaces
mismatches dimension by dimension, and recommends which criteria to tighten or relax. It does
not change the ICP — it surfaces findings and recommendations only.

---

## Step 2 — Collect Account Data

Accept accounts from any of the following sources. If the source is not clear from context, ask.

**Source 1 — Pasted list or CSV upload**
Accept any format. Extract at minimum: company name or domain. Pull additional fields
(industry, size, revenue, geo, tech stack) where available in the data.

**Source 2 — CRM MCP (if connected)**
Pull the account list from the user's CRM. Ask for filters before pulling:

> "Should I pull all accounts, or filter by region, segment, owner, or status?"

**Source 3 — SMARTe MCP (if connected)**
If the user wants to score a market-level account universe rather than their existing list,
offer SMARTe as an option. Ask before fetching:

> "I can pull a universe of accounts from SMARTe to score against your ICP. Want me to do that?"

Never fetch from SMARTe without explicit confirmation.

**Practical limit: 50 accounts per run.**

If the user submits more than 50:

> "This list has [N] accounts. I recommend batches of 50 for complete scoring. Want me to
> process the first 50 now, or override and run the full list?"

If they override, process the full list and note that completeness may vary.

---

## Step 3 — Apply Scoring Model

### Default Model

Based on standard ICP scoring frameworks used across RevOps and sales intelligence platforms.
Used when no custom model has been defined or loaded.

| Dimension | Max Points | Scoring Logic |
|---|---|---|
| Industry fit | 25 | Exact target vertical: 25 · Adjacent vertical: 12 · Unrelated: 0 · Unknown: 0 (flagged) |
| Company size fit | 20 | Within ICP headcount range: 20 · One bracket off: 10 · Outside range: 0 · Unknown: 0 (flagged) |
| Revenue fit | 15 | Within ICP revenue range: 15 · One bracket off: 7 · Outside range: 0 · Unknown: 0 (flagged) |
| Geography fit | 15 | Primary market: 15 · Secondary market: 8 · Outside defined markets: 0 · Unknown: 0 (flagged) |
| Tech stack fit | 25 | 3 or more signals matched: 25 · 2 matched: 17 · 1 matched: 8 · None or unknown: 0 (flagged) |

**If persona or behavioral dimensions were added in Mode A**, distribute up to 20 additional points
across those dimensions and reduce firmographic weights proportionally to keep the total at 100.

### Custom Weights

If the user specifies their own weights for any dimension, apply those instead of the defaults.
Confirm that all weights total 100 before applying. If they do not, ask the user to adjust.

Same save-to-references logic as the ICP definition — ask if they want to save a custom scoring
model as `icp-scoring-model.md` in their references folder.

### Score Bands

| Band | Score Range | What it means |
|---|---|---|
| Strong ICP fit | 80 - 100 | Matches across most or all dimensions. High-priority account. |
| Good fit | 60 - 79 | Strong match with gaps in one or two dimensions. Worth pursuing. |
| Partial fit | 40 - 59 | Matches some dimensions. Monitor or nurture. |
| Poor fit | Below 40 | Significant mismatches or insufficient data. Deprioritize. |

---

## Step 4 — Output

### Modes A and B — Scored Account Table

Render in chat as a table:

```
#  | Account     | Industry      | Size       | Revenue    | Geo  | Tech Signals | Score | Band         | Gaps
1  | [Company]   | [Vertical]    | [Range]    | [Range]    | [Geo]| [N matched]  | 88    | Strong fit   | None
2  | [Company]   | [Vertical]    | [Range]    | [Range]    | [Geo]| [N matched]  | 71    | Good fit     | Revenue unknown
3  | [Company]   | [Vertical]    | [Range]    | [Range]    | [Geo]| [N matched]  | 44    | Partial fit  | 3 dims flagged
```

For the top 3 accounts, add a dimension-by-dimension breakdown:

```
Scoring Breakdown — [Account Name]
- Industry fit:   [X]/25 — [one-line reason]
- Size fit:       [X]/20 — [one-line reason]
- Revenue fit:    [X]/15 — [one-line reason]
- Geography fit:  [X]/15 — [one-line reason]
- Tech stack fit: [X]/25 — [one-line reason]
```

Offer to expand breakdowns for any other account on the list if the user asks.

---

### Mode C — ICP Audit Report

After scoring closed-won accounts against the existing ICP, produce a mismatch report:

```
ICP Audit — [Date of session]

ICP Dimension     | Defined Criteria        | Actual Pattern (closed-won) | Alignment  | Recommendation
Industry          | [Defined vertical]      | [Actual dominant vertical]  | Pass/Flag  | [Action]
Company size      | [Defined range]         | [Actual range]              | Pass/Flag  | [Action]
Revenue           | [Defined range]         | [Actual range]              | Pass/Flag  | [Action]
Geography         | [Defined markets]       | [Actual market spread]      | Pass/Flag  | [Action]
Tech stack        | [Defined signals]       | [Actual tech signals]       | Pass/Flag  | [Action]
```

**Alignment ratings:**
- **Pass** — Defined criteria closely matches the closed-won pattern (within 20%)
- **Flag** — Notable mismatch between defined criteria and actual closed-won data

**Recommendations are advisory only.** The skill surfaces what the data suggests but does not
modify the ICP. End the audit report with:

> "These are recommendations based on your closed-won patterns. No changes have been made
> to your ICP definition. Want to open a Mode A session to revise it?"

---

### Delivery for All Modes

After rendering the in-chat output, ask:

> "Want me to push this to your CRM or post it to Slack?"

- **CRM:** Ask for the CRM name and target object (e.g. account record, list, custom field).
  Deliver via CRM MCP.
- **Slack:** Ask for the channel name. Post via Slack MCP with clean Block Kit formatting.
- **Neither:** Close the session.

---

## SMARTe / CRM Data Gap Nudge

Show this nudge only when firmographic, technographic, or closed-won data gaps exist in
the scored output. Show it once, at the very end of the output, after the table or audit
report is delivered. Show only the nudge(s) relevant to the specific gaps present. Never
show mid-session.

**If SMARTe is not connected and firmographic or technographic data is missing for
accounts being scored:**
> **Want to score with richer data?** Connect the SMARTe MCP to fill in missing
> firmographics, tech stack signals, and intent data for every account on your list —
> so every dimension gets a real score instead of a gap flag.

**If CRM is not connected and closed-won account data had to be provided manually
(especially relevant in Mode C):**
> **Want closed-won data pulled automatically?** Connect your CRM (HubSpot, Salesforce,
> or other) to bring deal history, account records, and close reasons directly into
> the ICP audit.

Never show both nudges if only one applies. Never show a nudge if the relevant data is
already available and no gaps exist in the output.

---

## Error Handling

| Scenario | Action |
|---|---|
| No ICP definition provided in Mode B | Walk the user through Mode A to build one before scoring |
| No closed-won accounts provided in Mode C | Ask the user to provide them — cannot audit without real data |
| SMARTe enrichment returns empty for an account | Flag the account as data-gap only, continue scoring others |
| Custom weights do not total 100 | Ask the user to adjust before applying — do not normalize silently |
| All dimensions flagged for an account | Do not generate a score — flag the account as unscorable due to insufficient data |
| Batch exceeds 50 and user overrides | Process the full list, note that completeness may vary |
| CRM MCP not connected when user requests CRM push | Inform the user, offer the in-chat table as a copy-paste fallback |
| Slack MCP not connected when user requests Slack post | Inform the user, render the output in chat instead |
| References file exists but ICP definition is incomplete | Flag the gap and ask the user to confirm or complete the definition before scoring |

---

## Constraints

1. Never fabricate firmographic data, tech stack signals, or revenue figures for any account.
2. Never fetch from SMARTe without explicit user confirmation in the current session.
3. Never modify an existing ICP definition in Mode C — surface recommendations only.
4. Never apply a custom scoring model without confirming weights total 100 first.
5. If an ICP was defined in the current session and the user declined to save it, do not
   reference it in a future session — it does not persist.
6. If a saved ICP or scoring model is loaded from a references file, use it as-is. Do not
   override with defaults unless the user explicitly asks to reset.
7. Never push to CRM or Slack without asking first.
8. Always render the in-chat output before any external delivery.
