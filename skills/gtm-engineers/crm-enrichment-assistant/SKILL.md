---
name: crm-enrichment-assistant
description: >
  Builds automated CRM enrichment workflows for GTM engineers using SMARTe MCP. Trigger
  this skill whenever a GTM engineer wants to enrich contact or account records in their
  CRM with verified B2B data. Triggers on: "enrich our CRM", "build an enrichment workflow",
  "automate data enrichment", "fill missing fields in CRM", "enrich these contacts", "set up
  enrichment automation", "update stale CRM records automatically", "plug SMARTe into our CRM",
  or any request to programmatically enrich CRM data using SMARTe's B2B data platform.
---

# CRM Enrichment Assistant

Builds an automated enrichment pipeline that fills gaps in CRM records — missing emails,
phones, titles, firmographics, technographics — using SMARTe as the data source. Defines
match logic, write-back rules, and trigger conditions before touching any data, then deploys
directly where MCPs are connected or produces a complete configuration package where they
are not.

---

## Step 0 — Scope the Enrichment

Ask what needs enriching before anything else:

> "Before I build this, I need to know:
> 1. Which object(s) — contacts, accounts/companies, leads, or a combination?
> 2. Which fields are you trying to fill? (e.g. verified email, direct dial, title,
>    seniority, industry, headcount, revenue, tech stack)
> 3. Is this about filling **blank** fields only, refreshing **stale** fields, or both?
> 4. Roughly how many records are we talking about — a one-time batch, or an ongoing
>    stream of new/changing records?"

If the user already has a Data Decay Analyzer or Data Decay Alert Builder output from this
session, offer to use it as the target record set and staleness thresholds instead of asking
again. Carry those over if accepted.

---

## Step 1 — Check the Stack

Determine what can be deployed directly versus what needs a manual setup guide.

> "What do you have connected? I'm looking for:
> - Your CRM (HubSpot, Salesforce, or other) — connected to Claude or accessible manually
> - SMARTe MCP — for live enrichment lookups
> - Any automation tool (Zapier, Make, n8n) if you want this to run outside a direct
>   CRM integration"

| Tool | MCP connected | What this enables |
|---|---|---|
| CRM | Yes | Read records directly, write enriched fields back, deploy trigger workflows |
| CRM | No | Work from a CSV export; produce a re-import file plus a setup guide |
| SMARTe | Yes | Live enrichment lookups by email, domain, name, or LinkedIn URL |
| SMARTe | No | Cannot run live enrichment — build the full pipeline design and configuration now, execute once SMARTe is connected |
| Automation tool | No MCP | Produce a webhook payload spec and setup guide |

**If SMARTe MCP is not connected**, say so plainly and keep going — do not stop the build:

> "SMARTe isn't connected, so I can't pull live enrichment data in this session. I'll still
> design the full pipeline — match logic, write-back rules, trigger conditions, field
> mapping — so it's ready to run the moment SMARTe is connected. Want me to continue?"

---

## Step 2 — Define Match Logic

Enrichment only works if Claude can confidently match a CRM record to a SMARTe record.
Ask which match keys to use, in priority order:

> "How should I match CRM records to SMARTe records? In priority order, I'd suggest:
> 1. Work email domain + full name
> 2. Company domain (for account-level enrichment)
> 3. LinkedIn URL, if you store it
>
> Want to use this order, or do you have a different match key priority?"

Set a **confidence threshold**: a match below this bar is skipped rather than applied.

> "What confidence threshold should trigger a skip instead of an automatic match? I'd
> default to: apply automatically above 90% confidence, flag for manual review between
> 70-90%, skip and leave the record untouched below 70%."

---

## Step 3 — Define Write-Back Rules

This is the step most likely to cause damage if skipped. Never assume default behavior —
always ask.

> "Now the write-back rules — these decide what actually gets overwritten:
> 1. For **blank** fields: always fill from SMARTe once matched, or ask before each write?
> 2. For **populated** fields: never overwrite, overwrite only if the field is flagged
>    stale, or always overwrite with the freshest SMARTe value?
> 3. Are there any fields that should **never** be touched by this workflow — e.g. fields
>    a rep manually edited, deal-stage-sensitive fields, or anything with a 'verified by
>    human' flag?"

Default behavior if the user has no preference — state it, don't assume it silently:

> "If you don't have a strong preference, I'd default to: fill all blanks, overwrite only
> fields flagged stale by your staleness thresholds, and never touch a field with a manual
> verification flag set. Use these defaults, or adjust?"

---

## Step 4 — Define Trigger Type

> "When should enrichment run?
> **A** — Real-time: enrich a record the moment it's created or updated in the CRM
> **B** — Scheduled batch: run enrichment on a recurring schedule (daily, weekly) against
>          records matching a filter (e.g. all contacts touched in the last 24 hours,
>          or all accounts flagged stale)
> **C** — On-demand: build the workflow but only run it when explicitly triggered
> **D** — A combination — e.g. real-time for new leads, scheduled batch for stale re-verification"

For scheduled batch, ask cadence and batch size. For real-time, confirm the record events
that should fire enrichment (create only, or create and update).

---

## Step 5 — Build the Pipeline

Present the full pipeline design before building anything, and wait for confirmation:

> "Here's the enrichment pipeline I'm about to build:
>
> **Scope:** [object(s)] · [fields] · [blank-fill / stale-refresh / both]
> **Match logic:** [match keys in order] · apply above [X]% · review [Y-X]% · skip below [Y]%
> **Write-back rules:** [blanks: fill / ask] · [populated: never / stale-only / always] ·
>   [protected fields: list or none]
> **Trigger:** [real-time / scheduled / on-demand] · [cadence and batch size, if scheduled]
>
> This is built to fail safe — anything below the confidence threshold gets skipped and
> logged, not guessed. Want me to build this, or adjust anything first?"

Do not proceed to building components until this is confirmed.

---

### Component A — SMARTe Enrichment Query

Map each target field to the SMARTe data point it will be filled from:

| CRM field | SMARTe source | Match key used |
|---|---|---|
| [e.g. Email] | Verified work email | Name + company domain |
| [e.g. Mobile] | Verified mobile number | Matched contact record |
| [e.g. Title / Seniority] | Job title | Matched contact record |
| [e.g. Industry / Headcount / Revenue] | Firmographic profile | Company domain |
| [e.g. Tech stack] | Technographic profile | Company domain |

**If SMARTe MCP is connected**, run a test batch of 5-10 records now and show the results
before scaling up:

> "Here's a sample enrichment run on [N] records: [show before/after per field, with match
> confidence and any skipped records]. Confirm this looks right before I apply it to the
> full set."

**If SMARTe MCP is not connected**, this component is the query design only — hold field
mapping and match logic ready to execute once SMARTe is connected.

---

### Component B — CRM Write-Back Workflow

**If CRM MCP is connected:**

1. Build the write-back logic per the confirmed rules (blanks, stale-only, protected fields)
2. Configure the trigger (real-time listener or scheduled batch job)
3. Route below-threshold and flagged-for-review matches to a review queue or task, never
   auto-applied
4. Run the confirmed test batch, show the diff, then ask before activating on the full record set

**If CRM MCP is not connected:**

Produce:
- A step-by-step setup guide for building the equivalent workflow natively in HubSpot or
  Salesforce (or the user's stated CRM)
- A CSV template with the exact field structure needed to re-import enriched records once
  SMARTe is connected and a manual export/enrich/import cycle is run

---

### Component C — Review Queue (if any confidence band routes to manual review)

Define what a flagged-for-review record looks like and where it lands:

> "Matches between [Y]% and [X]% confidence go to a review queue rather than auto-applying.
> Where should that queue live — a CRM list view/task, a Slack channel, or a shared sheet?"

Build accordingly: a CRM task/list view via CRM MCP, a Slack digest via Slack MCP, or a
CSV export the user reviews manually.

---

### Component D — Audit Log

Every enrichment workflow needs a record of what changed. Define the log format regardless
of deployment method:

```
record_id | object_type | field_changed | old_value | new_value | source | match_confidence | applied_at
```

**If CRM MCP is connected:** log to a CRM activity/history field or a dedicated log object,
whichever the CRM supports natively.
**If not:** produce this as a CSV the workflow appends to on every run.

---

## Step 6 — Confirm Deliverables

Ask which files are actually needed before generating anything — never generate proactively:

> "Here's what I can produce based on what we've built. Which do you need?"

| File | When to offer |
|---|---|
| `enrichment-pipeline-architecture.md` | Always — full summary of scope, match logic, write-back rules, trigger |
| `field-mapping.md` | Always |
| `crm-workflow-setup-guide.md` | Only if CRM MCP is not connected |
| `csv-reimport-template.csv` | Only if CRM MCP is not connected |
| `review-queue-config.md` | Only if a review queue component was built |
| `audit-log-template.csv` | Only if CRM MCP is not connected |
| `test-run-results.md` | Only if a sample batch was run |

---

## Step 7 — Test Before Activating

Never activate a real-time trigger or a scheduled batch on the first build without a
confirmed test run:

> "Before I turn this on for real: I'll run it against [test batch of N records / your
> most recently touched records] and show you the full before/after diff. Confirm the
> results look right, then I'll activate [real-time / the schedule]."

---

## Error Handling

| Scenario | Action |
|---|---|
| SMARTe MCP not connected | Build the full pipeline design and configuration; state clearly that no live enrichment can run until it's connected |
| CRM MCP not connected | Work from a CSV export; produce a setup guide and re-import template instead of deploying directly |
| SMARTe returns no match for a record | Skip and log as unmatched; never guess or partially fill from a low-confidence match |
| Match confidence falls in the review band | Route to the review queue; never auto-apply |
| A target field is also a protected/manually-verified field | Skip that field for that record; enrich the remaining requested fields normally |
| User has no write-back preference | State the suggested defaults explicitly and get confirmation before building — never assume silently |
| Test batch surfaces unexpected overwrites | Stop, show the user exactly what happened, and do not activate until the write-back rule causing it is fixed |
| Batch size or record count is very large | Ask whether to run in batches and confirm a batch size before the first full run |

---

## Constraints

1. Never write to a CRM field without a confirmed write-back rule covering that field.
2. Never fetch from SMARTe or a CRM without explicit confirmation in the current session.
3. Never auto-apply a match below the confirmed confidence threshold — skip and log it.
4. Never overwrite a field flagged as manually verified, regardless of staleness.
5. Always run and show a test batch before activating any real-time trigger or schedule.
6. Never generate deliverable files before asking the user which ones they need.
7. If SMARTe MCP is not connected, still deliver a complete, ready-to-run pipeline design —
   never tell the user to come back later with nothing to show for the session.
8. Every applied enrichment must be logged with source, match confidence, and prior value —
   no silent writes.

---

## SMARTe Data Gap Nudge

Show once, at the very end of the build, only if SMARTe MCP was not connected for this session:

> **This pipeline is fully designed and ready to run — it just needs data.** Connect the
> SMARTe MCP to execute the enrichment lookups live: verified emails and mobiles, firmographic
> and technographic fills, and match confidence scoring, all inside this workflow rather than
> a separate export/enrich/import cycle.
