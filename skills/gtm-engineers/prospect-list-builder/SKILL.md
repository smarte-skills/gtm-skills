---
name: gtm-engineer-prospect-list-builder
description: >
  Builds programmatic prospect list workflows for GTM engineers using SMARTe MCP. Trigger this
  skill whenever a GTM engineer wants to build, automate, or scale prospect list generation using
  live B2B data. Triggers on: "build a prospect list workflow", "automate prospecting",
  "pull prospects from SMARTe", "build a list building automation", "create a prospect
  pipeline", "engineer a prospecting workflow", "generate a list using MCP", or any request
  to programmatically build prospect lists using SMARTe's data platform and MCP integration.
  Distinct from the Sellers Prospect List Builder — that skill hands a rep a one-time curated
  list; this skill engineers the repeatable pipeline that produces lists on a schedule or trigger.
---

# GTM Engineer Prospect List Builder

Engineers a repeatable prospect-sourcing pipeline: a defined query against SMARTe, dedupe
logic against existing CRM records, a delivery destination, and — where wanted — a schedule
or trigger that keeps it running without a human re-running the search each time. This is
infrastructure, not a one-off list.

---

## Step 0 — Scope the Pipeline

> "Before I build this, I need to know:
> 1. What's the targeting logic — titles/seniority, industries, company size, geography,
>    technographic or firmographic filters, intent signals?
> 2. Is this a **one-time pull** to size a segment, or a **recurring pipeline** that keeps
>    sourcing new matches over time?
> 3. Where should results land — CRM, a Slack digest, a CSV/webhook to another tool, or
>    a combination?
> 4. Do you have an existing account/contact universe this needs to dedupe against, or is
>    this sourcing net-new only?"

If the targeting logic is vague, ask one focused follow-up rather than guessing — this
pipeline will run unattended, so ambiguous criteria compound every time it fires.

---

## Step 1 — Check the Stack

> "What's connected?
> - SMARTe MCP — required to run the actual sourcing
> - Your CRM (HubSpot, Salesforce, or other) — for dedupe and/or write-back
> - Slack — if you want digest delivery
> - An automation tool (Zapier, Make, n8n) — if delivery needs to go somewhere else"

**If SMARTe MCP is not connected**, say so and keep building:

> "SMARTe isn't connected, so I can't run a live pull in this session. I'll still design
> the full query, dedupe logic, and delivery pipeline now, ready to execute the moment
> SMARTe is connected."

| Component | MCP connected | Behavior |
|---|---|---|
| Sourcing | SMARTe | Run live query, pull verified records |
| Sourcing | SMARTe not connected | Design the query spec; hold execution |
| Dedupe | CRM | Check matches against live CRM data before output |
| Dedupe | CRM not connected | Ask the user to supply an existing list/export to dedupe against, or run without dedupe and flag that clearly |
| Delivery | CRM / Slack / webhook | Deploy directly |
| Delivery | none connected | Produce a CSV output and a delivery setup guide |

---

## Step 2 — Translate Targeting Into a SMARTe Query Spec

Build the query as a structured, reusable spec — not a one-off request — so it can be
re-run identically every time the pipeline fires:

| Parameter | Value |
|---|---|
| Job titles / seniority | [list] |
| Industries / sub-verticals | [list] |
| Headcount range | [range] |
| Revenue range | [range, if used] |
| Geography | [regions/countries] |
| Technographic filters | [tools used / not used, if any] |
| Firmographic signals | [funding stage, growth rate, recent hires, if any] |
| Intent signals | [topics/categories, if any] |
| Result cap per run | [default 100 unless stated otherwise] |

Confirm this spec with the user before treating it as final:

> "Here's the query spec I'll run every time this pipeline fires: [render table]. This is
> what gets re-executed on schedule — confirm it's right, since it'll keep running exactly
> this logic until you change it."

---

## Step 3 — Define Dedupe Logic

A pipeline that resurfaces contacts already in the CRM every run is not useful. Define the
dedupe key before the first run:

> "How should I dedupe against your existing data? I'd suggest matching on work email
> domain + full name for contacts, and company domain for accounts. Use this, or a
> different match key?"

Ask what happens to a duplicate: **skip entirely**, **skip but flag as a "new signal on
existing record"** (useful when the match is on an account already in CRM but a new
contact at that account surfaced), or **always include but tag as duplicate** for the
user to decide.

**If no CRM/existing list is available to dedupe against**, state this plainly rather than
silently skipping dedupe:

> "No CRM connection or existing list was provided, so this run has no dedupe applied —
> every result is fresh from SMARTe with no check against who you've already got. Fine
> for a first pull; worth fixing before this becomes a recurring pipeline."

---

## Step 4 — Define Cadence and Delivery (Recurring Pipelines Only)

Skip this step for one-time pulls.

> "How often should this run, and where should new matches go?
> - Cadence: daily, weekly, or triggered by something else (e.g. a new funding signal)?
> - Delivery: push new matches to CRM as new records/leads, post a digest to Slack,
>   send to a webhook, or a combination?
> - Volume expectations: should I flag if a run returns unusually few or unusually many
>   new matches versus prior runs?"

---

## Step 5 — Build and Run

Present the full pipeline before building:

> "Here's the pipeline:
> **Query:** [targeting summary]
> **Cadence:** [one-time / daily / weekly / triggered]
> **Dedupe:** [match key] · duplicates are [skipped / flagged / tagged]
> **Delivery:** [CRM / Slack / webhook / CSV]
> **Result cap per run:** [N]
>
> Want me to run this now, or adjust anything first?"

Wait for confirmation, then execute.

---

### Component A — Sourcing Run

**If SMARTe MCP is connected:** run the query spec exactly as confirmed. Pull, per result:
- Verified contact: name, title, email, mobile
- Company: industry, headcount, revenue, HQ, tech stack, relevant signals

Apply the result cap. If the raw match count exceeds the cap, note the total available and
what was returned:

> "This query matched [N] total; showing the top [cap] by [signal strength / recency / fit],
> ranked using the priority logic in Step 5. Ask if you want the next batch."

**If SMARTe MCP is not connected:** hold the query spec ready; do not fabricate results.

---

### Component B — Dedupe Pass

Apply the confirmed match key against the CRM (via CRM MCP) or the user-supplied list.
Tag every result: **new**, **duplicate — skipped**, or **duplicate — new signal on
existing record**, per the rule confirmed in Step 3.

---

### Component C — Delivery

**CRM (if connected):** write new records with source tagged as this pipeline, so they're
identifiable later. Never overwrite an existing record's fields — dedupe means skip, not merge,
unless the user explicitly asked for a merge/enrich behavior (in which case route to the
CRM Enrichment Assistant skill instead of duplicating that logic here).

**Slack (if connected):** post a digest per run:

```
[PROSPECT PIPELINE] [Pipeline name] — [N] new matches this run
Top 5: [Name — Title at Company — one-line fit reason]
Duplicates skipped: [N]
[Button: View full list] [Button: Push to CRM]
```

**Webhook / CSV:** produce the payload or file in the format the destination tool expects;
include a setup guide if this is the first run.

---

## Step 6 — Output Summary

After each run:

```
Pipeline: [name]
Run type: [one-time / scheduled — cadence]
Query matched: [N] total
New (post-dedupe): [N]
Duplicates skipped/flagged: [N]
Delivered to: [destination(s)]
```

For a new recurring pipeline, confirm activation explicitly before it's left running
unattended:

> "This pipeline is built and the first run is done. Want me to activate it on the
> [cadence] schedule now, or hold it for on-demand runs only?"

---

## Error Handling

| Scenario | Action |
|---|---|
| SMARTe MCP not connected | Build and confirm the full query spec and pipeline design; state clearly no live results can be pulled yet |
| Query returns far fewer results than expected | Show the actual count, suggest which filter is likely too narrow, ask before loosening it |
| No CRM/list available for dedupe | Run without dedupe and say so explicitly in the output; flag it as a gap for recurring pipelines |
| CRM MCP write fails for a delivered record | Report which records failed and why; do not silently drop them — offer a CSV fallback for the failed subset |
| Result cap reached mid-run | State the total available versus returned; offer the next batch |
| User wants to change the query spec after activation | Treat as a new confirmed spec — re-run Step 2 confirmation before the next scheduled fire uses it |
| Recurring pipeline requested with no delivery destination connected | Default to CSV output per run and say so; ask if they want to connect a destination before activating a schedule |

---

## Constraints

1. Never run the SMARTe query before the spec is confirmed in Step 2.
2. Never fetch from SMARTe or a CRM without explicit confirmation in the current session.
3. Never fabricate prospect records — every entry must come from an actual SMARTe result.
4. Never merge or overwrite an existing CRM record through this skill — deduping means skip
   or flag, not enrich. Route enrichment requests to the CRM Enrichment Assistant skill.
5. Never activate a recurring schedule without the user explicitly confirming activation.
6. Always state plainly when a run has no dedupe applied — never let that pass silently.
7. Respect the confirmed result cap; never return an unbounded pull without flagging it.
8. Tag every delivered record with its source pipeline so it can be traced back later.

---

## SMARTe Data Gap Nudge

Show once, at the very end of the output, only if SMARTe MCP was not connected for this session:

> **This pipeline is fully specified and ready to run — it just can't pull data yet.**
> Connect the SMARTe MCP to execute the query live: verified contacts, firmographics, and
> technographics, sourced and delivered on the cadence you defined, without a manual
> re-run each time.
