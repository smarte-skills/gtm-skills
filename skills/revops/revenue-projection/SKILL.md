---
name: revenue-projection
description: >
  Use this skill whenever a RevOps user wants to forecast or project revenue for a future
  period. Triggers on: "revenue projection", "forecast this quarter", "project our revenue",
  "what's our pipeline coverage", "run a forecast", "best case worst case revenue",
  "capacity-based forecast", "what can we close this quarter", "model our revenue",
  "scenario planning for revenue", "pipeline forecast", "how much can we expect to close",
  "project next quarter revenue", "annual revenue model", or any request to estimate future
  revenue from pipeline, historical, capacity, or scenario data. The skill inventories
  available data first, recommends which projection models are possible, then executes
  the chosen model with transparent assumptions the user can override.
---

# Revenue Projection

Projects revenue from pipeline, historical, capacity, or scenario data. Inventories what
the user has first, recommends which models are possible, surfaces all assumptions before
running, and delivers an in-chat projection with optional Slack or CRM delivery.

---

## Step 0 — Data Inventory

Open every session by asking what data the user has available. Do not ask which model
they want — the model recommendation follows from the data.

> "What data do you have to work with? Share what's available and I'll tell you which
> projections we can run:
> - Open pipeline (deals with stage, value, probability, and close date)
> - Historical deal data (won and lost deals with close dates and values)
> - Team or capacity data (rep count, quota targets, hire dates, ramp timelines)
> - A rough description (I can work directionally from estimates — lower confidence)
>
> Share as much or as little as you have. I'll map the options from there."

Wait for the user's response before recommending any model.

---

## Step 1 — Recommend Projection Models

Based on what the user shares, map available data to the models that are actually runnable.
Present only what is possible — do not list models the data cannot support.

| Data available | Models possible |
|---|---|
| Open pipeline only | Pipeline-based projection |
| Historical deal data only | Trend-based projection |
| Team and capacity data only | Capacity-based projection |
| Pipeline and historical data | Pipeline-based, trend-based, and scenario modeling |
| All three data types | All four models |
| Description or estimates only | Directional projection (flagged as low confidence) |

Present the recommendation clearly:

> "Based on what you have, here's what we can run: [list available models with one-line
> explanation of each]. Which would you like — or want me to run all of them?"

If the user selects multiple models, ask how they want the output presented:

> "You've selected [N] models. Would you prefer:
> - A combined summary table showing the headline number from each model side by side
> - Full detail on each model in sequence
>
> The combined summary is usually clearest for sharing with leadership. Full detail
> is better if you want to show your working."

If the user does not specify, default to the combined summary table with an offer
to expand any individual model on request.

If the user has a description only, proceed but flag every output as directional rather
than data-driven.

---

## Step 2 — Time Horizon

If the projection period is not already clear from context, ask:

> "What period are you projecting for — rest of this quarter, next quarter, full year,
> or a custom window?"

If the user has already mentioned a period in the conversation, infer it and confirm briefly
rather than asking again.

---

## Step 3 — Collect Data

Accept data from any of the following sources. If the source is not clear from context, ask.

**Source 1 — Pasted data or CSV upload**
Accept any format. Extract the relevant fields for the chosen model — deal stage, value,
close date, probability, rep name, hire date, quota — from whatever is provided.

**Source 2 — CRM MCP (if connected)**
Pull data from the user's CRM. Ask for filters before pulling:

> "Should I pull the full pipeline, or filter by rep, segment, close date range, or
> deal stage?"

**Source 3 — SMARTe MCP (if connected)**
Less central for projection, but useful for enriching account quality signals on pipeline
deals — particularly for adjusting confidence on high-value deals. Ask before fetching:

> "I can enrich the accounts in your pipeline via SMARTe to assess ICP fit and buying
> signals, which can inform confidence adjustments on key deals. Want me to do that?"

Never fetch from SMARTe without explicit confirmation.

**Source 4 — Described estimates (fallback)**
If no structured data is available, work from the user's description. Flag all outputs
as directional and recommend pulling real data for a more reliable projection.

---

## Step 4 — Surface and Confirm Assumptions

Before running any model, show the full assumption set being used and ask the user to
confirm or adjust. Never run a projection silently on assumptions the user has not seen.

### Default Assumptions

**Win rate (used in pipeline and trend-based models)**

| Default | Source |
|---|---|
| 25% | Industry-standard B2B average |

If historical deal data is available, derive the win rate from it instead of using the default.
Show the derived rate to the user before applying it.

**Stage probabilities (used in pipeline-based model)**

| Stage | Default Probability |
|---|---|
| Stage 1 — Awareness / Qualification | 10% |
| Stage 2 — Discovery / Scoping | 25% |
| Stage 3 — Proposal / Evaluation | 50% |
| Stage 4 — Negotiation / Closing | 75% |
| Closed Won | 100% |

Adjust stage labels to match whatever stage names appear in the user's data.

**Average deal size**
Derived from the data if available. If not, ask the user to provide it.

**Ramp assumptions (used in capacity-based model)**

| Assumption | Default | Source |
|---|---|---|
| Ramp duration | 4 months to full productivity | Industry standard B2B SaaS |
| Month 1-2 attainment | 25% of quota | Industry standard |
| Month 3-4 attainment | 50% of quota | Industry standard |
| Month 5 onwards | 100% of quota | Industry standard |

**Scenario variance thresholds (used in scenario modeling)**

| Scenario | Win Rate | Stage Probability Adjustment | Attainment |
|---|---|---|---|
| Best case | 35% | +10 percentage points across all stages | 110% of quota |
| Base case | 25% | Standard probabilities | 85% of quota |
| Worst case | 15% | -10 percentage points across all stages | 70% of quota |

These are industry-standard B2B variance ranges. Inform the user:

> "I'm using industry-standard scenario ranges: best case at 35% win rate, base at 25%,
> worst at 15%, with proportional stage probability and attainment adjustments. Want to
> change any of these before I run?"

Wait for confirmation or changes before proceeding.

---

## Step 5 — Run Projection

### Pipeline-Based Projection

**Weighted pipeline:**
For each open deal closing within the projection window:

```
Weighted value = Deal value x Stage probability
```

Sum all weighted values to produce the weighted pipeline total.

**Commit forecast:**
Sum of all deals at Stage 4 probability (75%) or higher.

**Upside:**
Sum of all deals at Stage 2 and Stage 3 (25-50% probability) that could pull forward.

```
Pipeline Summary
- Total open pipeline (in window): $[X]
- Weighted pipeline:               $[X]
- Commit (75%+ probability):       $[X]
- Upside (25-50% probability):     $[X]
- Pipeline coverage ratio:         [X]x (weighted pipeline / quota target)
```

---

### Trend-Based Projection

```
Projected revenue = Historical win rate x Current pipeline volume x Average deal size
                    adjusted for average cycle length vs. projection window length
```

If the pipeline cycle length is longer than the projection window, apply a partial-period
adjustment to avoid overstating what can realistically close in the window.

```
Trend Projection
- Historical win rate:          [X]%
- Pipeline entering window:     $[X]
- Average deal size:            $[X]
- Average cycle length:         [X] days
- Projection window:            [X] days
- Cycle length adjustment:      [X]%
- Projected revenue:            $[X]
```

---

### Capacity-Based Projection

For each rep, calculate expected contribution based on their ramp status:

```
Fully ramped rep:    Quota x Attainment %
Ramping rep (M1-2):  Quota x 25%
Ramping rep (M3-4):  Quota x 50%
```

Sum across all reps to produce the team projection.

```
Capacity Projection
Rep Name     | Status        | Quota   | Attainment | Projected
[Rep A]      | Fully ramped  | $[X]    | 85%        | $[X]
[Rep B]      | Ramping M2    | $[X]    | 25%        | $[X]
[Rep C]      | Ramping M4    | $[X]    | 50%        | $[X]
Team total   |               | $[X]    |            | $[X]
```

---

### Scenario Modeling

Run all three scenarios side by side using the confirmed assumption thresholds:

```
Scenario Comparison — [Period]

                        | Best Case | Base Case | Worst Case
Win rate applied        | 35%       | 25%       | 15%
Weighted pipeline       | $[X]      | $[X]      | $[X]
Projected revenue       | $[X]      | $[X]      | $[X]
vs. Quota target        | [+/- %]   | [+/- %]   | [+/- %]
Pipeline coverage       | [X]x      | [X]x      | [X]x
```

Follow the table with a one-paragraph plain-language read of what the scenarios imply
for the team's current position.

---

## Step 6 — Output

Always render the projection in chat first. When multiple models are run, default to
the combined summary table unless the user asked for full detail:

**Combined summary table (default for multiple models):**

```
Model                  | Projected Revenue | vs. Quota | Key assumption
Pipeline-based         | $[X]              | [+/- %]   | Weighted at stage probabilities
Trend-based            | $[X]              | [+/- %]   | [X]% historical win rate
Capacity-based         | $[X]              | [+/- %]   | [N] reps at [X]% attainment
Scenario — Best case   | $[X]              | [+/- %]   | 35% win rate
Scenario — Base case   | $[X]              | [+/- %]   | 25% win rate
Scenario — Worst case  | $[X]              | [+/- %]   | 15% win rate
```

Show only the rows relevant to the models actually run. Follow with:

> "Want the full working detail for any of these models?"

**If the user asked for full detail on a specific model:** render that model's full
output table below the summary. Do not render full detail for all models unless the
user explicitly asks for it.

After delivering output, suggest the most relevant format based on context:

**If the user mentioned leadership, board, or exec review:**
> "Want me to add a 2-3 sentence narrative above the table — a plain-language read
> of what the numbers mean for the business?"

**If internal tracking:**
The table is sufficient. Ask:

> "Want me to push this to Slack or log it in your CRM?"

**Delivery options:**
- **Slack:** Ask for the channel name. Post via Slack MCP with clean Block Kit formatting.
- **CRM:** Ask for the CRM name and target object (forecast record, note, custom report).
  Deliver via CRM MCP.
- **Neither:** Close the session.

---

## SMARTe / CRM Data Gap Nudge

Show this nudge only when data gaps limited the quality of the projection — pipeline data
had to be estimated, historical deal data was unavailable, or account quality on key deals
is unknown. Show it once, at the very end of the output. Show only the nudge(s) relevant
to the specific gaps present. Never show mid-session.

**If SMARTe is not connected and pipeline deal quality or account signals are missing:**
> **Want confidence signals on your pipeline deals?** Connect the SMARTe MCP to layer
> in ICP fit scores and buying signals across your open deals — so your projection
> reflects not just deal size and stage, but how likely those accounts are to actually close.

**If CRM is not connected and pipeline or historical data had to be provided manually:**
> **Want your pipeline and deal history pulled automatically?** Connect your CRM
> (HubSpot, Salesforce, or other) to bring open deals, stage history, and closed deal
> data directly into the projection — no exports or copy-pasting needed.

Never show both nudges if only one applies. Never show a nudge if the relevant data is
already available and the projection is complete without gaps.

---

## Error Handling

| Scenario | Action |
|---|---|
| No data provided of any kind | Ask the user for at minimum a description to work directionally |
| Pipeline data has no close dates | Cannot filter to projection window — ask the user to provide estimated close dates or project on full pipeline with a caveat |
| Historical data covers fewer than 10 deals | Flag that win rate derived from small samples is low confidence — recommend using the industry default or expanding the data window |
| Capacity data missing hire dates or ramp status | Ask the user to clarify which reps are fully ramped vs. ramping before running capacity model |
| Scenario model requested but no pipeline data | Cannot run scenario model without pipeline — recommend pipeline-based model first |
| CRM pull returns no open deals | Inform the user, ask if they want to paste pipeline data manually |
| SMARTe enrichment returns empty for pipeline accounts | Flag those accounts as unscored, continue projection without quality adjustment |
| User skips assumption confirmation | Re-surface the assumption set and ask again — do not run a projection on unconfirmed assumptions |
| Projection window shorter than average deal cycle | Flag the mismatch — note that the projection may understate potential if deals slip into the next period |

---

## Constraints

1. Never run a projection without surfacing assumptions to the user first.
2. Never fabricate deal values, win rates, or rep quota figures not present in the data.
3. Always flag directional projections clearly — any output based on estimates rather
   than real data must be labeled as directional throughout.
4. If historical data is available, derive win rate from it rather than using the default.
   Show the derived rate before applying it.
5. Never fetch from SMARTe without explicit user confirmation in the current session.
6. Never push to CRM or Slack without asking first.
7. Always render the in-chat output before any external delivery.
8. If the user changes scenario thresholds, confirm the new values before re-running.
9. Scenario model requires pipeline data — do not run it on capacity or description data alone.
