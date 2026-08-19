---
name: quota-attainment-monitor
description: >
  Use this skill whenever a RevOps user wants to track rep or team quota attainment
  against period targets, identify reps trending below threshold, or understand what
  needs to close to hit the number. Triggers on: "quota attainment", "how are reps
  tracking against quota", "who is below target", "attainment monitor", "rep pacing",
  "are we on track to hit quota", "which reps are at risk", "quota tracking", "period
  attainment", "how much does rep X need to close", "team attainment", "flag reps below
  threshold", "quota performance", "mid-period check", or any request to assess rep or
  team progress against a quota target within a defined period. Tracks at rep, team, and
  pacing level. Supports delta tracking across runs to surface what changed since the
  last snapshot.
---

# Quota Attainment Monitor

Tracks rep and team quota attainment against period targets in real time or from
regularly updated data. Flags reps trending below pacing or fixed thresholds, calculates
what each rep needs to close in the remaining period, and tracks deltas between runs to
surface who is improving, worsening, or newly at risk. Recommends interventions only
when the user asks.

---

## Step 0 — Select Monitoring Level

Open every session by asking which level the user wants to monitor. Multi-select allowed:

> "What would you like to track?
> **A** — Rep-level attainment (individual performance against quota)
> **B** — Team-level attainment (collective performance across a team or segment)
> **C** — Period pacing (are reps on track for where they should be given days elapsed?)
>
> You can run all three together. C is recommended alongside A or B for a complete picture."

Wait for the user's answer before proceeding.

---

## Step 1 — Collect Data

Accept attainment data from any of the following. Be transparent about what each
source means for data freshness.

**Source 1 — CRM MCP (if connected)**
Pulls live closed-won deal data directly. This is the closest to real-time available.
Ask for filters before pulling:

> "Should I pull attainment data for all reps, or filter by team, segment, or manager?"

**Source 2 — Excel or CSV upload**
Accepts a regularly updated export. Treat as current as of the file's last update date.
Extract at minimum: rep name, quota for period, closed revenue to date, and period dates.

**Source 3 — Pasted data**
Accept pasted tables or rep lists. Flag clearly:

> "Noted — pasted data reflects a point-in-time snapshot and is not real-time. The
> analysis will be accurate as of when this data was pulled."

**For all sources, confirm the period being tracked:**

> "What period are we monitoring? (e.g. Q3 2026, July 2026, full year)
> And how many total days are in the period?"

Calculate days elapsed and days remaining automatically from today's date.

---

## Step 2 — Define Thresholds

Apply the following defaults and inform the user before running:

> "Here are the attainment thresholds I'll use. Want to adjust anything?"

**Pacing threshold (primary):**

Expected attainment at any point in the period:

```
Expected attainment % = (Days elapsed / Total days in period) x 100
Pacing gap = Expected attainment % - Actual attainment %
```

A rep is flagged as behind pacing if their actual attainment is more than 10 percentage
points below their expected attainment for this point in the period.

| Pacing gap | Status |
|---|---|
| Within 10 pts of expected | On track |
| 10 to 20 pts below expected | At risk |
| More than 20 pts below expected | Critical |

**Fixed floor threshold (secondary):**

Regardless of pacing, flag any rep whose absolute attainment falls below:

| Period stage | Fixed floor |
|---|---|
| First third of period | Below 20% attainment |
| Mid-period | Below 40% attainment |
| Final third of period | Below 65% attainment |

A rep flagged by the fixed floor is always shown as at risk or critical, even if their
pacing gap is within range. Fixed floor catches reps whose quota may be set very high
and who are not tracking to close it in the time remaining.

---

## Step 3 — Delta Tracking

Before running the analysis, check whether a previous run exists in the current session
or in a references file.

**If a previous run is available:**

Load the prior snapshot and run a delta comparison after the current analysis completes.
For each rep, track movement since the last run:

| Delta status | Condition |
|---|---|
| Improved | Attainment % increased and pacing gap narrowed |
| Worsened | Attainment % decreased or pacing gap widened |
| Stable | Less than 2 percentage point movement either way |
| Newly at risk | Was on track last run, flagged this run |
| Recovered | Was flagged last run, on track this run |

**If no previous run is available:**

Proceed with current state only (Option A fallback). After delivering the output, prompt:

> "Want me to save this run as a baseline so future refreshes can track what changed?"

If yes: format the current snapshot as a references file entry and instruct:

> "Copy the block below and save it as `quota-attainment-baseline.md` in your
> references folder. Load it at the start of your next monitoring session and I'll
> show you what changed."

**If delta comparison fails** (references file exists but data is incomplete or
unreadable): fall back to current state only and flag:

> "Could not load the previous snapshot for comparison. Showing current attainment
> only. Want me to save this run as the new baseline?"

Do not attempt a partial delta — either the comparison runs cleanly or it falls back
entirely. Never mix delta and non-delta data in the same output.

---

## Step 4 — Run Analysis

Calculate the following for every rep:

```
Attainment % = Closed revenue to date / Period quota x 100
Expected attainment % = Days elapsed / Total period days x 100
Pacing gap = Expected attainment % - Actual attainment %
Revenue needed to hit quota = Period quota - Closed revenue to date
Daily run rate needed = Revenue needed / Days remaining
```

Assign a status to each rep:
- **On track** — within 10 pts of expected and above fixed floor
- **At risk** — pacing gap of 10 to 20 pts or below fixed floor for the period stage
- **Critical** — pacing gap over 20 pts or severely below fixed floor

---

## Step 5 — Output

Before generating output, ask what the user wants to see:

> "Here is what I can show you:
> - **Team summary** — overall attainment, pacing, and a count of at-risk reps (compact, always in chat)
> - **Rep-level table** — attainment, pacing gap, status, and revenue needed per rep (in chat, capped at full list if under 15 reps, top 10 flagged if larger)
> - **Delta view** — what changed since the last run (in chat if previous baseline exists)
> - **Individual rep breakdown** — detailed view for specific reps (on request only)
>
> Which would you like to see in chat, and should I generate a file?"

Always show the team summary in chat. Show other views based on the user's answer.

---

### Team Summary (always in chat)

```
Quota Attainment Monitor — [Period] · Day [N] of [N] ([N] days remaining)
Data source: [CRM / Excel upload / Pasted snapshot — as of [date]]

Team attainment:    $[X] closed of $[X] total quota ([X]%)
Expected at pacing: [X]%
Team pacing gap:    [+/- X] pts ([On track / At risk / Critical])

Reps on track:      [N]
Reps at risk:       [N]
Reps critical:      [N]
```

---

### Rep-Level Table (in chat if requested)

```
Rep Name    | Quota   | Closed  | Attain% | Expected% | Pacing Gap | Status   | Needed to Hit | Days Left Run Rate
[Rep A]     | $[X]    | $[X]    | [X]%    | [X]%       | [+/- X]pts | Critical | $[X]          | $[X]/day
[Rep B]     | $[X]    | $[X]    | [X]%    | [X]%       | [+/- X]pts | At risk  | $[X]          | $[X]/day
[Rep C]     | $[X]    | $[X]    | [X]%    | [X]%       | [+/- X]pts | On track | $[X]          | $[X]/day
```

For teams larger than 15 reps, show flagged reps only in chat. Follow with:

> "Showing [N] flagged reps. Want me to include the full team in a file?"

---

### Delta View (in chat if previous baseline exists)

```
Changes since last run — [Previous date] to [Today]

Rep Name    | Previous% | Current% | Movement | Delta Status
[Rep A]     | [X]%      | [X]%     | [+/-X]pts| Worsened
[Rep B]     | [X]%      | [X]%     | [+/-X]pts| Newly at risk
[Rep C]     | [X]%      | [X]%     | [+/-X]pts| Recovered
[Rep D]     | [X]%      | [X]%     | [+/-X]pts| Stable
```

Follow with a one-line read on the most significant movement:

> "[Rep B] moved from on track to at risk since the last run — largest negative movement
> this period. [Rep C] recovered from critical to on track."

---

## Step 6 — Intervention Recommendations

After delivering the output, ask:

> "Want me to recommend interventions for flagged reps?"

If yes, generate a specific recommendation per flagged rep based on their status,
days remaining, and revenue needed:

| Situation | Recommended intervention |
|---|---|
| Critical, early in period | Quota review — assess whether the number is achievable and whether to reforecast |
| Critical, mid-period | Pipeline review — identify what can realistically close and build a close plan |
| Critical, late period | Targeted coaching — specific deal acceleration on the two or three most closeable deals |
| At risk, early period | Activity check — are they building enough pipeline to support the number? |
| At risk, mid-period | Deal inspection — which deals are at risk of slipping and why |
| At risk, late period | Manager-led deal support — bring in leadership on the highest-value open deals |
| Daily run rate exceeds realistic deal size | Flag — the rep cannot mathematically hit quota from existing pipeline alone. Recommend reforecast. |

Show recommendations only for flagged reps. Do not generate recommendations for
on-track reps unless the user asks.

---

## Step 7 — Delivery

After all in-chat output is rendered, ask:

> "Want me to push this to Slack or log it in your CRM?"

- **Slack:** Ask for the channel name. Post a compact summary via Slack MCP.
- **CRM:** Ask for the target object. Log via CRM MCP.
- **File:** Ask if they want a CSV or Markdown report. Generate only on confirmation.

---

## SMARTe / CRM Data Gap Nudge

Show once at the very end of the output. Show only the relevant nudge. Never mid-session.

**If CRM MCP is not connected and data came from an Excel or pasted snapshot:**
> **Want live attainment data instead of snapshots?** Connect your CRM (HubSpot,
> Salesforce, or other) to pull closed-won revenue in real time — so every refresh
> reflects actual current performance, not the last export.

**If pipeline data is unavailable and daily run rate flags are being shown:**
> **Want pipeline context added to the attainment view?** Connect your CRM to layer
> in open pipeline per rep alongside closed attainment — so you can see not just where
> reps are, but whether they have enough in the funnel to get there.

---

## Error Handling

| Scenario | Action |
|---|---|
| No quota data provided for a rep | Flag the rep as unscored — do not estimate their quota |
| Period dates not provided | Ask before running — cannot calculate pacing without period boundaries |
| Previous baseline exists but is unreadable | Fall back to Option A (current state only), offer to save new baseline |
| Previous baseline partially matches current rep list | Run delta only for matching reps, flag additions and removals separately |
| Daily run rate mathematically impossible given deal sizes | Flag the rep — recommend reforecast conversation |
| CRM pull returns zero closed deals | Confirm the filter with the user before assuming zero attainment |
| Excel upload missing quota column | Ask the user to provide quota figures manually before running |
| Team larger than 15 reps, user requests full in-chat table | Show full table but warn it may be long — offer file instead |
| Delta comparison produces unexpected results | Show both runs side by side and ask the user to confirm the baseline is correct before relying on the delta |

---

## Constraints

1. Never estimate or fabricate quota figures, closed revenue, or period dates not
   provided by the user or pulled from a connected MCP.
2. Always flag pasted data as a point-in-time snapshot — never describe it as real-time.
3. Never run a delta comparison partially — either it runs cleanly for all reps or it
   falls back entirely to current state.
4. Never generate intervention recommendations without asking first.
5. Always show the team summary in chat before any individual rep detail.
6. Never push to CRM or Slack without asking first.
7. Never generate a file without asking first.
8. If the daily run rate is mathematically impossible, flag it — do not present an
   unachievable target as a legitimate action item.
9. Fixed floor flags always override pacing status — a rep below the fixed floor is
   always shown as at risk or critical regardless of their pacing gap.
10. Save-to-references is always offered after the first run — never skip this prompt
    as it enables delta tracking in future sessions.
