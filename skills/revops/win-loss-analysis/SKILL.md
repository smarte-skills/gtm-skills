---
name: conversion-analysis
description: >
  Use this skill whenever a RevOps user wants to understand why deals were won or lost,
  find patterns across a set of deals, or compare two groups of deals against each other.
  Triggers on: "why did we lose this deal", "win/loss analysis", "analyze this lost deal",
  "what are our win patterns", "why are we losing to [competitor]", "loss analysis",
  "win rate by segment", "analyze our closed deals", "what's causing churn in our pipeline",
  "compare won vs lost deals", "conversion analysis", "deal debrief", "why did we win this",
  "pattern in our losses", or any request to understand deal outcomes at a specific, trend,
  or comparative level. The skill identifies win/loss reasons from available signals first,
  then offers to validate findings with the user's own perspective.
---

# Conversion Analysis (Win/Loss)

Analyzes deal outcomes at the individual, pattern, or cohort level. Derives win and loss
reasons from available signals — CRM data, call notes, deal history, and SMARTe enrichment
where connected — then surfaces structured findings with optional delivery to Slack or CRM.

---

## Step 0 — Select Mode

Open every session by asking which level the user wants to work at:

> "What would you like to analyze?
> **A** — A specific deal (understand why one deal was won or lost)
> **B** — A batch of deals (find win/loss patterns across multiple deals)
> **C** — Two groups of deals (compare won vs. lost, segment vs. segment, or period vs. period)"

Wait for the user's answer before proceeding. Do not infer a mode from context.

---

## Step 1 — Collect Deal Data

Accept deal data from any of the following. Do not require a single format — work with whatever is provided.

**Accepted sources:**

| Source | What to extract |
|---|---|
| Pasted deal notes or summaries | Close reason, competitor mentioned, deal size, key objections, stage reached, champion signals |
| CRM export or CRM MCP | Deal stage history, close reason field, deal value, rep owner, account firmographics, contact role |
| Call transcripts or meeting notes | Objection language, sentiment signals, decision-maker involvement, competitor mentions, stall reasons |
| Mixed input | Combine all available sources — flag any gaps |

**If CRM MCP is connected**, ask before pulling:

> "Should I pull deal records from your CRM? If so, what filters should I apply — time period,
> rep, segment, deal stage, or outcome?"

**For Mode A (single deal):**
Ask for whatever the user has on that deal — even rough notes work. The more context provided,
the more precise the analysis. The skill will note where data is thin.

**For Mode B (batch):**
Same 50-deal practical limit as other skills. If more than 50 deals are submitted:

> "This batch has [N] deals. I recommend running in batches of 50 for complete analysis.
> Want me to process the first 50 now, or override and run the full set?"

**For Mode C (cohort):**
Ask the user to define the two groups being compared:

> "How would you like to split the two groups?
> - Won vs. lost
> - Segment A vs. Segment B (e.g. Enterprise vs. Mid-Market)
> - Period A vs. Period B (e.g. Q1 vs. Q2)
> - Rep A vs. Rep B
> - Something else?"

Collect deal data for both groups before proceeding to analysis.

---

## Step 2 — SMARTe Enrichment

If SMARTe MCP is connected and deal records are missing firmographic or technographic context,
offer enrichment before analysis. Ask once per session:

> "I can enrich the accounts in these deals via SMARTe to add firmographic and technographic
> context (industry, size, tech stack) before analyzing. Want me to do that?"

**If SMARTe is connected**, the analysis can factor in:
- Account firmographic fit vs. ICP (were these good-fit accounts to begin with?)
- Technographic signals (did the account's tech stack align with the product's typical buyer?)
- Org-level buying signals at the time of the deal

**If SMARTe is not connected**, the analysis derives factors purely from the data provided:
- Deal stage progression and stall points
- Close reasons and objection language
- Competitor mentions
- Deal size and cycle length patterns
- Rep and persona signals from CRM or notes

Never fetch from SMARTe without explicit confirmation.

---

## Step 3 — Analyze

The skill identifies win and loss reasons on its own from whatever signals are available in the data.
Do not ask the user what they think happened before producing findings — that comes at the end.

### Factors the skill looks for:

**Deal-level signals:**
- Stage where the deal stalled or closed
- Gap between deal creation and close date vs. typical cycle length
- Whether a clear champion was identified and engaged
- Objections surfaced in notes or transcripts
- Competitor named or implied
- Pricing friction signals
- Stakeholder breadth (single-threaded vs. multi-threaded)
- Next steps defined or absent at key stages

**Pattern-level signals (Mode B and C):**
- Win rate by rep, segment, industry, deal size, or geography
- Common stage where losses cluster
- Most frequently cited close reasons across lost deals
- Competitor win/loss ratio where competitor data is present
- Deal size distribution across won vs. lost
- Cycle length differences between won and lost deals

**SMARTe-enriched signals (if connected):**
- ICP fit score of won vs. lost accounts (were wins better ICP fits?)
- Tech stack alignment patterns across won deals
- Industry or size concentration in wins vs. losses

### Confidence flagging:

If the data is thin for a factor, note it rather than inferring beyond the evidence:

> "[Factor] — insufficient data to conclude. Recommend pulling [specific data point] from CRM to validate."

---

## Step 4 — Output

### Mode A — Deal-Level Breakdown

Render in chat as a structured brief:

```
Win/Loss Brief — [Deal Name / Account]
Outcome: [Won / Lost]

What happened:
[2-3 sentence plain-language summary of the deal trajectory]

Key factors identified:
- [Factor 1]: [One-line explanation with evidence from the data]
- [Factor 2]: [One-line explanation with evidence from the data]
- [Factor 3]: [One-line explanation with evidence from the data]

Where it turned:
[The stage or moment where the deal was most likely decided, based on available signals]

What to do differently:
[1-2 concrete, specific recommendations for the next similar deal — not generic advice]

Data gaps:
[Any factors that could not be assessed due to missing data]
```

---

### Mode B — Pattern Analysis

Render in chat as a trends table followed by key findings:

```
Win/Loss Pattern Analysis — [N] deals · [Date range if available]

Metric                        | Won Deals     | Lost Deals    | Gap
Total deals                   | [N]           | [N]           |
Average deal size             | [$]           | [$]           | [+/- %]
Average cycle length          | [X days]      | [X days]      | [+/- days]
Most common stage at close    | [Stage]       | [Stage]       |
Single-threaded deals         | [%]           | [%]           | [+/- pts]
Competitor mentioned          | [%]           | [%]           | [+/- pts]
```

Followed by key findings in plain language:

```
Key Findings:

1. [Most significant pattern — state the finding and what it implies]
2. [Second pattern]
3. [Third pattern]

Where losses are clustering:
[Stage or condition where the most losses occur, with supporting data]

Top recommendation:
[One specific, high-leverage action for the RevOps or sales team based on the patterns]
```

---

### Mode C — Cohort Comparison

Render as a side-by-side comparison report:

```
Cohort Comparison — [Group A] vs. [Group B]

Metric                   | [Group A]     | [Group B]     | Difference
Win rate                 | [%]           | [%]           | [+/- pts]
Average deal size        | [$]           | [$]           | [+/- %]
Average cycle length     | [X days]      | [X days]      | [+/- days]
Champion identified      | [%]           | [%]           | [+/- pts]
Multi-threaded           | [%]           | [%]           | [+/- pts]
Competitor involvement   | [%]           | [%]           | [+/- pts]
Top loss reason          | [Reason]      | [Reason]      |
```

Followed by a cohort summary:

```
What the comparison shows:
[2-3 sentences on the most meaningful differences between the two groups]

Where Group [A/B] has a structural advantage:
[Specific dimension and why it matters]

Recommended action:
[One concrete step to close the gap or replicate the stronger cohort's pattern]
```

---

## Step 5 — Offer Reflection

After delivering any output, ask:

> "I've surfaced what the data shows. Do you want to walk me through what you think happened?
> I can compare your read against the data and flag where they align or diverge."

If the user says yes, listen to their account and respond with:
- Where their read matches the data
- Where the data tells a different or more nuanced story
- Any factors they raised that the data cannot confirm or deny

This step is optional and does not change the findings already delivered.

---

## Step 6 — Delivery

After all output is rendered, ask:

> "Want me to push this to your CRM or post it to Slack?"

- **CRM:** Ask for the CRM name and target (deal record, activity note, custom report object).
  Deliver via CRM MCP.
- **Slack:** Ask for the channel name. Post via Slack MCP with clean Block Kit formatting.
- **Neither:** Close the session.

---

## SMARTe / CRM Data Gap Nudge

Show this nudge only when deal or account data gaps limited the depth of the analysis —
missing firmographics, absent tech stack context, or deal records that had to be provided
manually. Show it once, at the very end of the output, after findings are delivered. Show
only the nudge(s) relevant to the specific gaps present. Never show mid-session.

**If SMARTe is not connected and account-level firmographic or technographic context
is missing from the deal analysis:**
> **Want deeper account context for your win/loss analysis?** Connect the SMARTe MCP
> to layer in firmographic fit, tech stack signals, and ICP alignment across your deals —
> so you can see not just what happened, but whether these were the right accounts to
> begin with.

**If CRM is not connected and deal records, stage history, or close reasons had to be
provided manually:**
> **Want full deal history pulled automatically?** Connect your CRM (HubSpot, Salesforce,
> or other) to bring stage-by-stage progression, close reasons, and rep activity directly
> into the analysis — no copy-pasting needed.

Never show both nudges if only one applies. Never show a nudge if the relevant data is
already available and the analysis is complete without gaps.

---

## Error Handling

| Scenario | Action |
|---|---|
| No deal data provided | Ask for at minimum a close reason and account name — cannot analyze without any signal |
| Deal notes too sparse to derive factors | Flag which factors could not be assessed, deliver partial analysis with clear data gap callouts |
| CRM pull returns no deal records | Inform the user, ask if they want to paste data manually instead |
| Competitor not named in data | Note competitor involvement as unknown — do not infer a competitor |
| Batch exceeds 50 and user overrides | Process the full batch, note that completeness may vary |
| Mode C groups are too small for patterns | Flag that groups under 5 deals produce low-confidence patterns — recommend expanding the date range or scope |
| SMARTe enrichment returns empty for an account | Flag the account as data-gap only, continue analysis on others |
| CRM MCP not connected when user requests CRM push | Inform the user, offer the in-chat output as a copy-paste fallback |
| Slack MCP not connected when user requests Slack post | Inform the user, render the output in chat instead |

---

## Constraints

1. Never fabricate deal outcomes, competitor names, or objection language not present in the data.
2. Never assign a win or loss reason without evidence from the data — flag uncertainty explicitly.
3. Never fetch from SMARTe without explicit user confirmation in the current session.
4. The reflection step in Step 5 is always offered after analysis — never before.
5. Recommendations must be specific to the deal or pattern analyzed — no generic sales advice.
6. Never push to CRM or Slack without asking first.
7. Always render the in-chat output before any external delivery.
8. If data is thin, deliver a partial analysis with clear gap callouts rather than padding with assumptions.
