---
name: account-prioritization
description: >
  Use this skill whenever a RevOps user wants to prioritize accounts for outreach, expansion,
  renewal, or upsell. Triggers on: "which accounts should we focus on", "prioritize these
  accounts", "rank our accounts", "account prioritization", "which prospects should reps
  work this quarter", "which customers are expansion ready", "tier our accounts", "who
  should we go after first", "account ranking", "which accounts have the most intent",
  "renewal prioritization", "expansion prioritization", "which accounts are at risk",
  "prioritize my book of business", or any request to rank or segment accounts by
  opportunity, urgency, or likelihood to close or expand. Covers both net-new prospects
  and existing customers. Layers intent, engagement, pipeline, account health, and timing
  signals on top of ICP fit to produce a ranked list and tiered segmentation.
---

# Account Prioritization

Ranks and tiers accounts by combining ICP fit with dynamic signals — intent, engagement,
pipeline status, account health, and timing. Works across net-new and existing accounts,
adapts to available data and connected MCPs, and delivers a ranked list with specific
recommended actions alongside a tiered segmentation summary.

---

## Step 0 — Select Mode

Open every session by asking which book of accounts the user is prioritizing:

> "Which accounts are we prioritizing?
> **A** — Net-new prospects (which accounts to pursue for new business)
> **B** — Existing accounts (which customers to focus on for expansion, upsell, or renewal)
> **C** — Both (prioritize across the full book)"

Wait for the user's answer before proceeding.

---

## Step 1 — Establish ICP Fit as the Base Layer

Account prioritization builds on fit first, then layers dynamic signals on top. Handle
ICP fit in one of the following ways depending on context:

**If an ICP definition or ICP Scorer output exists in this session or in a references file:**
Load the fit scores silently and use them as the base layer. Do not re-run the ICP Scorer.
Confirm briefly:

> "I'll use your existing ICP definition as the fit baseline and layer prioritization
> signals on top."

**If no ICP definition exists:**
Ask the user:

> "Do you have an ICP definition to work from? If not, I can build a quick fit baseline
> from your account data before layering in signals."

- If they have one: load it and proceed.
- If not: run a lightweight inline fit assessment (industry, size, geo, tech stack) before
  proceeding to signal scoring. Use the ICP Scorer skill logic for this step.

---

## Step 2 — Present Signal Framework and Allow Adjustments

Before scoring, show the user the full signal set and ask if they want to adjust anything.

> "Here are the signals I'll use to prioritize your accounts. Let me know if you want
> to change the weight of any category or remove one from the model."

| Signal Category | Default Weight | Signals included | Primary source | Mode |
|---|---|---|---|---|
| ICP / Fit | 30 points | Firmographic and technographic match | References / ICP Scorer | Both |
| Intent | 25 points | Active research, job postings, tech stack changes, org changes | SMARTe MCP | Net-new |
| Engagement | 20 points | Email opens, website visits, content downloads, demo requests | CRM MCP | Both |
| Pipeline / Account health | 15 points | Pipeline: deal stage, days in stage, last activity. Health: usage, NPS, support volume | CRM MCP | Pipeline for new biz, health for expansion |
| Timing | 10 points | Renewal date proximity, fiscal year end, recent funding round | CRM / SMARTe | Both |

**If the user adjusts weights:** Apply the new weights. Confirm that the total still equals
100 before proceeding. If it does not, ask the user to adjust.

**If a category cannot be populated** (no data available, no MCP connected): redistribute
its weight proportionally across the remaining categories. Always inform the user when a
redistribution has happened:

> "Intent signals are unavailable (SMARTe not connected), so those 25 points have been
> redistributed proportionally across the other categories."

---

## Step 3 — Collect Account Data

Accept accounts from any of the following sources. If the source is not clear from
context, ask.

**Source 1 — Pasted list or CSV upload**
Accept any format. Extract company name, and pull additional fields (deal stage, last
activity, renewal date, NPS, assigned rep) from whatever is available in the data.

**Source 2 — CRM MCP (if connected)**
Pull account records from the user's CRM. Ask for filters before pulling:

> "Should I pull all accounts or filter by segment, owner, deal stage, renewal window,
> or account status?"

**Source 3 — SMARTe MCP (if connected)**
If intent or technographic signals are missing, offer enrichment. Ask before fetching:

> "I can enrich these accounts via SMARTe to pull intent signals, org changes, and
> technographic updates before scoring. Want me to do that?"

Never fetch from SMARTe without explicit confirmation.

**Practical limit: 50 accounts per run.**

If the user submits more than 50:

> "This list has [N] accounts. I recommend batches of 50 for complete scoring. Want me
> to process the first 50 now, or override and run the full list?"

If they override, process the full list and note that completeness may vary.

---

## Step 4 — Apply Scoring Model

Score each account across all available signal categories. Score only on categories
that can be populated — flag and redistribute weight for any that cannot.

### ICP / Fit (max 30)

Apply the fit score from the ICP definition or inline fit assessment. Map the ICP Scorer
band to the 30-point scale:

| ICP Band | Points |
|---|---|
| Strong fit (80-100) | 30 |
| Good fit (60-79) | 22 |
| Partial fit (40-59) | 12 |
| Poor fit (below 40) | 3 |

---

### Intent Signals (max 25) — SMARTe MCP

| Signal | Points |
|---|---|
| Active job postings in target function + tech research activity | 25 |
| Active job postings in target function only | 17 |
| Tech stack change or org restructure detected | 15 |
| Mild intent signal (one weak indicator) | 7 |
| No signal detected | 0 (flagged) |

If SMARTe is not connected: score 0 for all accounts in this category and redistribute
the 25 points.

---

### Engagement Signals (max 20) — CRM MCP

| Signal | Points |
|---|---|
| Demo requested or meeting booked in last 30 days | 20 |
| Form fill or content download in last 30 days | 14 |
| Email open or website visit in last 30 days | 8 |
| No engagement in last 60 days | 3 |
| No engagement data available | 0 (flagged) |

---

### Pipeline / Account Health (max 15)

**For net-new accounts (pipeline signals):**

| Signal | Points |
|---|---|
| Active deal at Stage 3 or Stage 4 | 15 |
| Active deal at Stage 2 | 10 |
| Active deal at Stage 1 or deal stalled 30+ days | 5 |
| No active deal | 0 |

**For existing accounts (health signals):**

| Signal | Points |
|---|---|
| High usage + NPS above 8 + no open support issues | 15 |
| Moderate usage + NPS 6-8 | 10 |
| Low usage or NPS below 6 | 5 |
| At-risk signals (declining usage, high support volume) | 2 |
| No health data available | 0 (flagged) |

---

### Timing Signals (max 10)

| Signal | Points |
|---|---|
| Renewal within 60 days or fiscal year end within 90 days | 10 |
| Renewal within 90-180 days | 7 |
| Recent funding round (expansion signal for net-new) | 7 |
| Renewal beyond 180 days, no timing trigger | 2 |
| No timing data available | 0 (flagged) |

---

### Score Tiers

| Tier | Score Range | What it means |
|---|---|---|
| Tier 1 — Work Now | 75 - 100 | Strong fit and active signals. Engage immediately. |
| Tier 2 — Nurture | 50 - 74 | Good fit, signals warming. Keep active and monitor closely. |
| Tier 3 — Monitor | Below 50 | Weak fit or cold signals. Deprioritize until signals change. |

---

## Step 5 — Recommended Actions

By default, generate a specific recommended action per account based on the top signal
and account context. Before outputting, ask:

> "For recommended actions, I'll default to specific next steps per account based on the
> signals I've found (e.g. 'Rep dark for 14 days — send re-engagement sequence' or
> 'Renewal in 45 days — schedule EBR now'). Want to keep it specific, or prefer a
> simpler category label (e.g. 'Re-engage', 'Schedule renewal call')?"

**If specific (default):**
Generate a one-line action per account grounded in the top signal, the account's stage,
and the time context. Examples:

- "Intent spike detected — assign to rep and trigger outbound sequence this week"
- "Deal stalled at Stage 2 for 18 days — send champion a value recap and propose next step"
- "Renewal in 52 days, usage declining — schedule health check call before renewal conversation"
- "Funding round closed last month — reach out with expansion pitch before budget is allocated"
- "No engagement in 90 days, fit is strong — re-enter with new trigger or persona"

**If category-level:**
Use short, clean action labels: Engage now, Re-engage, Schedule renewal, Expansion pitch,
Health check, Monitor.

---

## Step 6 — Output

Render both outputs in sequence in chat.

### Output 1 — Prioritized Ranked List

```
#  | Account   | Mode      | Tier | Score | Top Signal              | Recommended Action                        | Gaps
1  | [Company] | Net-new   | T1   | 91    | Intent spike + fit match| Assign rep, trigger outbound this week    | None
2  | [Company] | Expansion | T1   | 86    | Renewal in 48 days      | Schedule EBR before renewal conversation  | NPS unknown
3  | [Company] | Net-new   | T2   | 68    | Stage 2 deal, 12 days   | Send champion value recap + propose step  | Intent unknown
4  | [Company] | Expansion | T2   | 61    | Moderate usage, NPS 7   | Expansion pitch — usage trending steady   | Timing unknown
5  | [Company] | Net-new   | T3   | 44    | Weak fit, no signals    | Monitor — revisit next quarter            | 3 dims flagged
```

---

### Output 2 — Tiered Segmentation Summary

```
Tier 1 — Work Now:   [N] accounts · Avg score [X] · Top shared signal: [Signal]
Tier 2 — Nurture:    [N] accounts · Avg score [X] · Top shared signal: [Signal]
Tier 3 — Monitor:    [N] accounts · Avg score [X] · Top shared signal: [Signal]
```

Follow with a one-paragraph summary of the most important pattern across all tiers — what
the prioritization reveals about where the biggest opportunity or risk sits right now.

---

### Delivery

After both outputs are rendered, ask:

> "Want me to push this to your CRM or post it to Slack?"

- **CRM:** Ask for the CRM name and target object (account record, task, list view, custom
  field). Deliver via CRM MCP.
- **Slack:** Ask for the channel name. Post via Slack MCP with clean Block Kit formatting.
- **Neither:** Close the session.

---

## SMARTe / CRM Data Gap Nudge

Show this nudge only when signal categories were missing or redistributed due to
unavailable data or disconnected MCPs. Show it once, at the very end of the output,
after both tables are delivered. Show only the nudge(s) relevant to the specific gaps
present. Never show mid-session.

**If SMARTe is not connected and intent or technographic signals were unavailable:**
> **Missing intent signals?** Connect the SMARTe MCP to pull active research activity,
> job postings, org changes, and tech stack signals across your accounts — the signals
> most likely to reveal which accounts are in-market right now.

**If CRM is not connected and engagement, pipeline, health, or timing data was unavailable:**
> **Missing engagement and timing data?** Connect your CRM (HubSpot, Salesforce, or other)
> to bring in deal stage, last activity, account health scores, and renewal dates — so
> every prioritization signal can be scored rather than flagged as a gap.

Never show both nudges if only one applies. Never show a nudge if all signal categories
were fully populated.

---

## Error Handling

| Scenario | Action |
|---|---|
| No account data provided | Ask for at minimum a list of company names — cannot prioritize without a starting set |
| ICP definition missing and user declines inline assessment | Score ICP fit as 0 across all accounts, flag clearly, redistribute weight |
| All signal categories unavailable | Do not generate a score — inform the user that insufficient data exists to prioritize reliably |
| Custom weights do not total 100 | Ask the user to adjust before applying — do not normalize silently |
| Batch exceeds 50 and user overrides | Process the full list, note that completeness may vary |
| CRM pull returns no accounts | Inform the user, ask if they want to paste a list manually |
| SMARTe enrichment returns empty for an account | Flag that account's intent score as 0, redistribute weight for that account only |
| CRM MCP not connected when user requests CRM push | Inform the user, offer the in-chat table as a copy-paste fallback |
| Slack MCP not connected when user requests Slack post | Inform the user, render the output in chat instead |
| Mode C selected but account type unknown for some accounts | Ask the user to clarify which accounts are net-new vs. existing before scoring |

---

## Constraints

1. Never fabricate intent signals, engagement activity, NPS scores, or renewal dates not
   present in the data or returned by a connected MCP.
2. Always inform the user when a signal category weight has been redistributed due to
   missing data — never redistribute silently.
3. Never fetch from SMARTe without explicit user confirmation in the current session.
4. Specific recommended actions must be grounded in a real signal — never generate a
   generic action dressed up as specific.
5. If an ICP definition exists from a prior session, load it silently. Do not re-run the
   ICP Scorer unless the user asks.
6. Never push to CRM or Slack without asking first.
7. Always render both in-chat outputs before any external delivery.
8. If the user switches from specific to category-level actions mid-session, apply the
   change to all remaining accounts — do not mix formats in the same output.
