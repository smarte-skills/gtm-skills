---
name: data-decay-analyzer
description: >
  Use this skill whenever a RevOps user wants to assess how stale or inaccurate their
  CRM contact and account data is, understand which decayed records are actively affecting
  pipeline, or get a prioritized list of records to refresh. Triggers on: "data decay
  analysis", "how stale is our CRM data", "contact data freshness", "which contacts are
  outdated", "data accuracy audit", "email bounce analysis", "how old is our account data",
  "which records need re-verification", "contact decay score", "data refresh prioritization",
  "how much of our data is stale", "pipeline at risk from bad data", or any request to
  assess the accuracy and freshness of CRM records over time. Distinct from CRM Hygiene
  Auditor — hygiene checks whether fields are filled in correctly; this skill checks whether
  the information in those fields is still true. Outputs a decay probability score per
  record and a pipeline-weighted refresh priority list.
---

# Data Decay Analyzer

Scores contact and account records on decay probability — combining time-based and
signal-based factors — then weights urgency by pipeline impact to surface which stale
records are actively putting revenue at risk. Produces a scored decay report and a
prioritized refresh list with specific re-verification actions per record.

---

## What makes this different from CRM Hygiene Auditor

The CRM Hygiene Auditor asks: *"Are the fields filled in?"* — structure and completeness.

This skill asks: *"Is the information in those fields still true?"* — accuracy and freshness.

A contact with a filled-in email that now bounces, a title that changed six months ago,
or a company that was acquired passes every hygiene check and fails every decay check.
These are different problems requiring different tools.

---

## Step 0 — Collect Data

Accept data from any of the following sources. If the source is not clear from context, ask.

**Source 1 — Pasted list or CSV upload**
Accept any format. The more fields available, the more precise the decay score. When
collecting, suggest good-to-have fields inline — but do not require them before proceeding:

> "I can produce a more accurate decay score if you have any of the following:
> last verified date, last activity date, email bounce flag, pipeline attachment
> (open deal associated), and deal value. Share what you have and I'll work from there."

**Source 2 — CRM MCP (if connected)**
Pull contact and account records from the user's CRM. Ask for filters before pulling:

> "Should I pull all records or filter by owner, segment, last activity date range,
> pipeline stage, or record type?"

Confirm the record count before proceeding:

> "I've pulled [N] contacts and [N] accounts. Running decay analysis across these now."

**Source 3 — SMARTe MCP (if connected)**
If job change signals, technographic updates, or re-verification data are needed to
inform signal-based decay scoring, offer enrichment before running the analysis. Ask
before fetching:

> "I can check these records against SMARTe to pull job change signals, email validity,
> and updated firmographics before scoring decay. Want me to do that?"

Never fetch from SMARTe without explicit confirmation.

**Practical limit: 50 records per run.**

If the user submits more than 50:

> "This list has [N] records. I recommend batches of 50 for complete decay scoring.
> Want me to process the first 50 now, or override and run the full list?"

If they override, process the full list and note that signal-based scoring may be
less complete for larger runs.

---

## Step 1 — Apply Industry-Standard Decay Thresholds

Use the following thresholds derived from B2B data research (Dun and Bradstreet, HubSpot,
Salesforce data studies) as the baseline. Do not ask the user to define thresholds —
apply these as defaults and inform the user they are in use:

> "I'm using industry-standard B2B decay thresholds: contact data decays at roughly
> 30% per year, with tighter windows for contacts attached to active pipeline. Let me
> know if you want to adjust any of these."

### Contact decay thresholds

| Time since last verification | Standard contacts | Pipeline contacts |
|---|---|---|
| Under 3 months | Fresh | Fresh |
| 3 to 6 months | Moderate risk | High risk |
| 6 to 12 months | High risk | Critical |
| 12 to 18 months | Critical | Critical |
| Over 18 months | Severely decayed | Severely decayed |

Pipeline contacts = any contact associated with an open deal in the CRM or data provided.
Tighter thresholds apply because data accuracy directly affects active revenue.

### Account decay thresholds

| Time since last verification | Risk level |
|---|---|
| Under 6 months | Fresh |
| 6 to 12 months | Moderate risk |
| 12 to 18 months | High risk |
| 18 to 24 months | Critical |
| Over 24 months | Severely decayed |

### Annual decay rates by data type (used to weight signal scoring)

| Data type | Annual decay rate | Primary cause |
|---|---|---|
| Contact email | 22.5% | Job changes, company departures |
| Job title | 30% | Promotions, lateral moves, departures |
| Phone number | 18% | Direct line and mobile changes |
| Account headcount and revenue | 10 to 15% | Growth, downsizing, M and A activity |
| Tech stack | 15 to 20% | Contract renewals, tool changes |

---

## Step 2 — Calculate Decay Probability Score

Every record receives a single decay probability score expressed as a percentage (0 to 100%).

The score is the sum of two equally weighted components:

```
Decay Probability = Time Decay Score (0-50) + Signal Decay Score (0-50)
```

### Time Decay Score (max 50 points)

**For standard contacts:**

| Time since last verification | Points |
|---|---|
| Under 3 months | 0 |
| 3 to 6 months | 10 |
| 6 to 12 months | 20 |
| 12 to 18 months | 35 |
| Over 18 months | 50 |

**For pipeline contacts (tighter thresholds):**

| Time since last verification | Points |
|---|---|
| Under 1 month | 0 |
| 1 to 3 months | 10 |
| 3 to 6 months | 25 |
| 6 to 9 months | 40 |
| Over 9 months | 50 |

**For accounts:**

| Time since last verification | Points |
|---|---|
| Under 6 months | 0 |
| 6 to 12 months | 10 |
| 12 to 18 months | 25 |
| 18 to 24 months | 40 |
| Over 24 months | 50 |

If no verification date is available, assign 35 points (treated as unknown and assumed stale).
Flag the record as date-unknown in the output.

---

### Signal Decay Score (max 50 points)

Score each signal independently and sum them, capping at 50 points total:

| Signal | Points | Source |
|---|---|---|
| Email bounce detected | 25 | CRM bounce flag or SMARTe |
| Job change signal detected (title or company changed) | 20 | SMARTe or CRM activity log |
| Company acquired, merged, or rebranded | 15 | SMARTe or provided data |
| Domain change detected | 15 | SMARTe or provided data |
| Phone number invalid or disconnected | 10 | CRM flag or provided data |
| LinkedIn profile updated with new employer | 10 | SMARTe |
| No signals detected | 0 | |

If SMARTe is not connected, score signal-based decay only from signals present in the
provided data (e.g. CRM bounce flags, activity log entries). Note which signals could
not be checked due to SMARTe being unavailable.

---

### Decay Probability Bands

| Decay Probability | Band | Meaning |
|---|---|---|
| 0 to 24% | Low | Data is likely still accurate. Low priority for refresh. |
| 25 to 49% | Moderate | Some staleness likely. Schedule for periodic re-verification. |
| 50 to 74% | High | Meaningful decay risk. Prioritize for refresh. |
| 75 to 100% | Critical | Data is very likely stale. Re-verify before any outreach or use. |

---

## Step 3 — Apply Pipeline Weighting

After calculating decay probability, cross-reference each record against active pipeline
data. Do not change the decay probability score — instead, flag pipeline-attached records
separately to elevate their refresh urgency.

For each record with a decay probability of 25% or higher:

- Check whether it is associated with one or more open deals
- If yes, capture the total open deal value attached to that contact or account
- Flag the record as pipeline-critical in the output

This produces a pipeline risk figure: the total value of open deals where a key contact
or account record has meaningful decay risk.

```
Pipeline risk summary:
- Records with 50%+ decay probability attached to open deals: [N]
- Total open deal value at risk: $[X]
- Highest single at-risk record: [Contact / Account name] — [X]% decay, $[X] deal value
```

---

## Step 4 — Output

Before generating output, ask the user what they want to see in chat:

> "The decay analysis is complete. Here is what I can show you:
> - **Decay summary** — object-level averages and pipeline risk figures (compact, always in chat)
> - **Top flagged records** — highest decay risk records prioritized by pipeline impact (in chat, capped at 10)
> - **Full scored list** — every record with decay scores (CSV file only)
> - **Refresh priority list** — top 10 actions in chat, full list as a file
>
> The summary is always shown in chat. Which of the others would you like to see here,
> and which should I just include in the files?"

Always render the decay summary in chat. Show flagged records and priority list in chat
only based on the user's answer and only up to the caps below.

---

### Output 1 — Decay Risk Report

**Always in chat — object-level decay summary and pipeline risk:**

```
Object     | Records analyzed | Avg decay % | Critical | High | Moderate | Low
Contacts   | [N]              | [X]%        | [N]      | [N]  | [N]      | [N]
Accounts   | [N]              | [X]%        | [N]      | [N]  | [N]      | [N]
```

Pipeline risk summary (from Step 3):

```
Records with 50%+ decay attached to open deals: [N]
Total open deal value at risk: $[X]
Highest single at-risk record: [Name] — [X]% decay, $[X]K deal value
```

**In chat (if user requests):** Top 10 records only, sorted pipeline-critical first
then by decay percentage descending. Follow with:

> "Showing the top 10 highest-risk records. The full scored list of [N] records is in the CSV."

```
Record Name      | Type    | Decay %| Band     | Pipeline      | Pipeline Value | Key Signal
[Contact Name]   | Contact | 78%    | Critical | Yes — 2 deals | $340K          | Email bounce + job change
[Account Name]   | Account | 61%    | High     | Yes — 1 deal  | $120K          | Domain change detected
[Contact Name]   | Contact | 44%    | Moderate | No            | —              | Title change signal
```

**In file:** Full scored table with all records and all scoring columns. Delivered as CSV.

---

### Output 2 — Refresh Priority List

**In chat (if user requests):** Top 10 records only, sorted by urgency.
Follow with:

> "Showing the top 10 refresh priorities. The full list of [N] records is in the file."

```
Priority | Record Name     | Type    | Decay % | Pipeline | Deal Value | Recommended Action                               | Effort
1        | [Contact Name]  | Contact | 78%     | Yes       | $340K      | Re-verify email and title via SMARTe immediately | Quick
2        | [Account Name]  | Account | 61%     | Yes       | $120K      | Confirm domain and headcount before next call    | Quick
3        | [Contact Name]  | Contact | 82%     | No        | —          | Re-enrich via SMARTe or manual LinkedIn check    | Quick
```

**Effort tiers:**
- **Quick** — can be re-verified in one SMARTe enrichment pass or a single manual check
- **Batch** — group with other moderate-risk records and re-verify in a scheduled sprint
- **Low priority** — add to the next scheduled re-verification cycle

**In file:** Full prioritized list of all records. Delivered as Markdown.

---

### File Delivery

Ask the user which files they need before generating:

> "Which files do you want me to generate?
> - Full decay risk report (CSV)
> - Full refresh priority list (Markdown)
> - Both"

Generate only what the user confirms.

---

## SMARTe / CRM Data Gap Nudge

Show this nudge once, at the very end of the output, after both files are delivered.
Show only the nudge(s) relevant to the specific gaps in the analysis. Never show mid-session.

**If SMARTe is not connected:**
> **Want to re-verify these records automatically?** Connect the SMARTe MCP to check
> current emails, job titles, company firmographics, and tech stack across every flagged
> record in one pass — the fastest way to turn a decay report into clean, verified data.

**If CRM MCP is not connected and pipeline weighting was limited or unavailable:**
> **Missing pipeline context?** Connect your CRM (HubSpot, Salesforce, or other) to
> cross-reference decayed records against your live pipeline — so you know exactly which
> stale records are putting active deals at risk, not just which ones are old.

Never show both nudges if only one applies. Never show a nudge if both MCPs are connected
and the analysis ran without gaps.

---

## Error Handling

| Scenario | Action |
|---|---|
| No verification date available for a record | Assign 35 time decay points, flag as date-unknown in output |
| No signal data available and SMARTe not connected | Score signal decay from CRM flags only, note which signals could not be checked |
| No pipeline data available | Skip pipeline weighting, note that pipeline risk could not be assessed |
| Record has zero fields beyond name | Flag as unscorable — insufficient data to calculate decay probability |
| Batch exceeds 50 and user overrides | Process full list, note signal completeness may vary for larger runs |
| CRM pull returns no records for the filter | Inform the user, ask if they want to broaden the filter or pull all records |
| SMARTe enrichment returns empty for a record | Score from available data only, flag the record as partially scored |
| All records score below 25% decay | Report a clean result — do not inflate scores or manufacture urgency |
| CRM MCP not connected when user requests CRM push | Inform the user, offer the in-chat output as a copy-paste fallback |
| Slack MCP not connected when user requests Slack post | Inform the user, render the output in chat instead |

---

## Constraints

1. Never fabricate decay signals, bounce flags, or job change indicators not present in
   the data or returned by a connected MCP.
2. Never change the decay probability score based on pipeline attachment — pipeline
   weighting affects urgency and sort order only, not the score itself.
3. Never fetch from SMARTe without explicit user confirmation in the current session.
4. If no verification date is available, always flag the record as date-unknown rather
   than assuming a date.
5. Always inform the user that industry-standard thresholds are being applied and that
   they can adjust them before the analysis runs.
6. Never push to CRM or Slack without asking first.
7. Always render both in-chat outputs before making files available for download.
8. If working from a pasted export, flag throughout that findings reflect a point-in-time
   snapshot and may not represent the current state of CRM records.
9. Pipeline risk figures are derived from the deal data provided or pulled — never
   estimated or extrapolated beyond what is in the data.
