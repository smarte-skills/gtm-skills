---
name: capacity-planning
description: >
  Use this skill whenever a RevOps user wants to determine headcount needs, model quota
  distribution, or identify coverage gaps against a revenue target. Triggers on: "capacity
  planning", "how many reps do we need", "headcount planning", "quota modeling", "quota
  distribution", "coverage gap analysis", "are we staffed to hit our number", "how should
  we distribute quota", "hiring plan", "rep capacity model", "quota coverage ratio",
  "will our team hit the target", "ramp planning", "how many reps to hit target", or any
  request to model sales team capacity against a revenue goal. Asks which planning mode
  the user needs, integrates with Revenue Projection output if available, applies
  industry-standard assumptions by default, and delivers compact in-chat summaries with
  full detail available on request.
---

# Capacity Planning

Models headcount requirements, quota distribution, and coverage gaps against a revenue
target. Integrates with Revenue Projection output where available. Applies industry-standard
B2B SaaS assumptions by default — all surfaced and overridable before running. Delivers
compact in-chat summaries with full working detail on request.

---

## Step 0 — Select Planning Mode

Open every session by asking which modes the user wants to run. Multi-select allowed:

> "What would you like to work on?
> **A** — Headcount planning (how many reps do we need to hit our revenue target?)
> **B** — Quota modeling (how should quota be distributed across the team?)
> **C** — Coverage gap analysis (where are we short against target given current headcount?)
>
> You can run one, two, or all three. If you are not sure where to start,
> C gives the fastest read on where you stand today."

Wait for the user's answer before proceeding.

---

## Step 1 — Revenue Projection Integration

Check silently whether a Revenue Projection output or capacity assumptions exist in the
current session or in a references file.

**If Revenue Projection output is available:**

Carry forward the capacity assumptions already defined — rep count, quota per rep, ramp
schedule, attainment rate — without re-asking. Confirm briefly:

> "I'll use the capacity assumptions from your revenue projection as the starting point:
> [list key assumptions in one line]. Want to adjust any of them before we run?"

**If no Revenue Projection output exists:**

Proceed to Step 2 to collect the inputs needed for the selected modes.

---

## Step 2 — Collect Inputs

Collect only the inputs relevant to the modes selected. Do not ask for inputs the
selected modes do not need.

### Mode A — Headcount Planning

| Input | Required | Default if not provided |
|---|---|---|
| Revenue target and period | Yes | Must be provided |
| Average quota per rep | Yes | Ask |
| Expected team attainment rate | No | 75% (industry standard B2B SaaS) |
| Ramp duration | No | 4 months to full productivity |
| Ramp attainment schedule | No | M1-2: 25% of quota, M3-4: 50%, M5+: 100% |
| Annual rep churn rate | No | 25% (industry standard) |
| Hiring lead time | No | 75 days from job posting to start date (industry standard midpoint) |
| Target date for full productivity | No | If provided, generates a hire-by date |

### Mode B — Quota Modeling

| Input | Required | Default if not provided |
|---|---|---|
| Revenue target and period | Yes | Must be provided |
| Number of reps and ramp status per rep | Yes | Ask |
| Target quota coverage ratio | No | 1.2x to 1.25x above revenue target (industry standard) |
| Attainment distribution assumption | No | 20% overachievers (120%+), 60% at plan (80-100%), 20% underperformers (below 80%) |

### Mode C — Coverage Gap Analysis

| Input | Required | Default if not provided |
|---|---|---|
| Revenue target and period | Yes | Must be provided |
| Current headcount with ramp status per rep | Yes | Ask |
| Quota per rep | No | Carry from Mode B if run, or ask |
| Attainment rate assumption | No | 75% (industry standard) |
| Current pipeline coverage | No | Optional — improves precision of gap estimate |

If pipeline coverage is not provided, note that the gap estimate is based on quota and
attainment assumptions only and may differ from pipeline-based reality.

---

## Step 3 — Surface and Confirm Assumptions

Before running any model, show the full assumption set being used and ask the user to
confirm or adjust. Show only the assumptions relevant to the selected modes.

> "Here are the assumptions I'm using — all based on B2B SaaS industry standards.
> Let me know if you want to change anything before I run."

| Assumption | Default | Applies to |
|---|---|---|
| Team attainment rate | 75% of quota | A, C |
| Ramp duration | 4 months | A, C |
| M1-2 attainment | 25% of quota | A, C |
| M3-4 attainment | 50% of quota | A, C |
| M5+ attainment | 100% of quota | A, C |
| Annual rep churn rate | 25% | A |
| Hiring lead time | 75 days | A |
| Quota coverage ratio target | 1.2x to 1.25x revenue target | B |
| Attainment distribution | 20% over, 60% at plan, 20% under | B |

Wait for confirmation or changes before running. If the user changes an assumption,
apply the change and show the updated set before proceeding.

---

## Step 4 — Run Models and Generate Output

Keep all in-chat output compact. Show the summary view by default.
Offer full working detail only after the summary is delivered.

---

### Mode A — Headcount Planning

**Calculate required headcount:**

```
Required productive reps = Revenue target / (Avg quota per rep x Attainment rate)
```

Adjust for rep churn — add a churn buffer:

```
Required hires = Required productive reps / (1 - Annual churn rate)
```

If a target productivity date is provided, work backwards from that date using the
ramp duration and hiring lead time to produce a hire-by date.

**In-chat summary:**

```
Headcount Plan — [Period]
Revenue target:              $[X]
Avg quota per rep:           $[X]
Required productive reps:    [N]
Churn-adjusted hires needed: [N]
Currently ramping:           [N] reps ([X]% productive equivalent)
Net additional hires needed: [N]
Hire by:                     [Date] to reach full productivity by [Date]
```

If the hire-by date has already passed or is within 30 days:

> "To be fully productive by [target date], hiring should have started [X] days ago.
> Recommend re-evaluating the target date or increasing interim quota on existing reps
> to cover the gap."

---

### Mode B — Quota Modeling

**Calculate recommended quota per rep by ramp status:**

```
Fully ramped rep quota = Revenue target x Coverage ratio / Number of fully ramped reps
Ramping rep (M3-4) quota = Fully ramped quota x 50%
Ramping rep (M1-2) quota = Fully ramped quota x 25%
```

**In-chat summary:**

```
Quota Model — [N] reps · [Period]
Revenue target:              $[X]
Recommended team quota:      $[X] ([X]x coverage — target is [X]x)
Fully ramped reps ([N]):     $[X] quota each
Ramping reps M3-4 ([N]):     $[X] quota each
Ramping reps M1-2 ([N]):     $[X] quota each
Coverage ratio:              [X]x
```

**Quota coverage ratio flag:**

If the calculated coverage ratio falls below 1.2x, flag it immediately:

> "Coverage gap detected: your team quota of $[X] is only [X]x your revenue target of
> $[X]. Industry best practice is 1.2x to 1.25x to account for attainment variance
> across the team. At [X]x coverage, you are at risk of missing the number even if
> average attainment holds. Options: increase individual quotas, add headcount, or
> adjust the revenue target."

If the coverage ratio is within range (1.2x to 1.25x), confirm:

> "Coverage ratio is [X]x — within the recommended 1.2x to 1.25x range."

If above 1.25x, note:

> "Coverage ratio is [X]x — above the 1.25x recommended ceiling. Quotas may be set
> too aggressively relative to the revenue target, which can affect rep morale and
> retention. Consider whether the target or individual quotas need adjusting."

---

### Mode C — Coverage Gap Analysis

**Calculate projected team attainment:**

```
Projected attainment = Sum of (quota per rep x ramp attainment factor for each rep)
Gap = Revenue target - Projected attainment
Gap % = Gap / Revenue target x 100
```

**In-chat summary:**

```
Coverage Gap Analysis — [Period]
Revenue target:                $[X]
Projected team attainment:     $[X]
Gap:                           $[X] ([X]% short)
Pipeline coverage (if provided):$[X] ([X]x weighted pipeline)
```

If a gap exists, surface two resolution options:

```
To close the $[X] gap:
Option 1 — Add headcount: [N] additional fully ramped reps needed
Option 2 — Increase quota: raise avg quota by $[X] per rep (from $[X] to $[X])
Option 3 — Combination: [N] new hire + $[X] quota increase per existing rep
```

If no gap exists:

> "Current headcount is projected to cover the revenue target at [X]% of target.
> No additional headcount or quota changes needed for [period]."

---

### Multi-Mode Combined Summary

If the user ran two or three modes together, render a combined summary before offering
full detail on any individual model:

```
Capacity Planning Summary — [Period]
Revenue target:              $[X]

Headcount:    Need [N] productive reps · [N] additional hires needed · Hire by [Date]
Quota:        Team quota $[X] ([X]x coverage) · [Status: On track / Coverage gap flagged]
Gap:          $[X] short ([X]%) · Closes with [N] hires or $[X] quota increase per rep
```

Follow with:

> "Want the full working detail for any of these?"

---

## Step 5 — Output Delivery

After delivering the in-chat summary, ask:

> "Want me to push this to Slack or log it in your CRM?"

- **Slack:** Ask for the channel name. Post via Slack MCP with clean formatting.
- **CRM:** Ask for the CRM name and target object. Deliver via CRM MCP.
- **Neither:** Close the session.

If the user wants a file:

> "Want me to generate a capacity plan document you can share with leadership?"

Ask before generating. Produce only if confirmed. Keep the document to one page —
the combined summary table plus assumptions used.

---

## SMARTe / CRM Data Gap Nudge

Show this nudge once at the very end of the output. Show only the nudge(s) relevant
to the gaps present. Never show mid-session.

**If CRM MCP is not connected and rep headcount or ramp status had to be provided manually:**
> **Want headcount and ramp data pulled automatically?** Connect your CRM (HubSpot,
> Salesforce, or other) to pull current rep roster, hire dates, and quota assignments
> directly into the capacity model — no manual data entry needed.

**If Revenue Projection was not available and capacity planning used standalone assumptions:**
> **Want your capacity plan grounded in real pipeline data?** Run the Revenue Projection
> skill first to derive attainment assumptions from your actual pipeline — then use those
> as the foundation for a more precise capacity model.

Never show both nudges if only one applies. Never show a nudge if data was fully available.

---

## Error Handling

| Scenario | Action |
|---|---|
| Revenue target not provided | Cannot run any mode — ask for it before proceeding |
| No rep roster provided for Mode C | Estimate from headcount count if provided, flag as approximate |
| Hire-by date has already passed | Flag immediately — surface alternative options to cover the gap |
| Coverage ratio below 1.2x | Flag with specific resolution options — do not proceed silently |
| Coverage ratio above 1.25x | Flag as potentially aggressive — note retention risk |
| Ramp status unknown for some reps | Treat as fully ramped with a note — ask user to confirm |
| Revenue Projection assumptions conflict with user input | Surface the conflict and ask which to use before running |
| Pipeline coverage provided but below 3x target | Flag as insufficient pipeline coverage alongside the gap analysis |
| User requests a shareable document | Ask before generating — keep to one page |

---

## Constraints

1. Never run any model without surfacing assumptions to the user first.
2. Never fabricate rep headcount, quota figures, or ramp status not provided by the user
   or carried from a Revenue Projection session.
3. Always flag a quota coverage ratio below 1.2x — never let it pass without comment.
4. Always flag a quota coverage ratio above 1.25x — quota set too aggressively is as
   much a risk as quota set too low.
5. In-chat output is always the compact summary first. Full working detail only on request.
6. If Revenue Projection assumptions are carried forward, confirm them with the user
   before applying — do not apply silently without acknowledgment.
7. Never push to CRM or Slack without asking first.
8. Never generate a shareable document without asking first. Keep it to one page.
9. If multiple modes are run, always show the combined summary before individual model detail.
10. Pipeline coverage data is optional — if absent, flag that the gap estimate is
    assumption-based and may not reflect actual pipeline reality.
