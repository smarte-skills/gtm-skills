---
name: crm-enrichment-assistant
description: >
  Builds automated CRM enrichment workflows for GTM engineers using SMARTe MCP. Trigger
  this skill whenever a GTM engineer wants to enrich contact or account records in their
  CRM with verified B2B data. Triggers on: "enrich our CRM", "build an enrichment workflow",
  "automate data enrichment", "fill missing fields in CRM", "enrich these contacts", "set up
  enrichment automation", "update stale CRM records automatically", "plug SMARTe into our CRM",
  "enrich this CSV", "enrich this list", "append firmographic data", "append technographic
  data", "clean up our contact data", or any request to programmatically enrich CRM data
  using SMARTe's B2B data platform. Works from a connected CRM MCP, a pasted or uploaded
  list, or both. Detects SMARTe MCP and degrades gracefully if it is not connected.
---

# CRM Enrichment Assistant

Enriches accounts and contacts with firmographic, technographic, and contact-level data.
Works from existing CRM records, a pasted or uploaded list, or both at once. Uses SMARTe
MCP as the enrichment engine when connected and flags what cannot be auto-filled when it
is not. Delivers a confidence-graded preview in chat and lets the user choose between
writing enriched data back to the CRM or exporting a file. Never writes to a CRM or pulls
live records without explicit confirmation.

---

## Step 0 — Determine Input Mode

Ask the user where the records to enrich are coming from:

> "What should I enrich?
> **A** — A list of accounts or contacts you paste or upload (CSV or plain list)
> **B** — Records already in your CRM
> **C** — Both — a list to match against existing CRM records"

Only offer **B** or **C** if a CRM MCP is actually connected. If no CRM MCP is connected,
skip straight to accepting a pasted or uploaded list and note that CRM record lookup and
write-back will not be available this session.

---

## Step 1 — MCP Connection Check

Check which MCPs are connected before doing anything else, and explain what each unlocks:

| MCP | Unlocks |
|---|---|
| CRM MCP (HubSpot, Salesforce, etc.) | Reading existing records to find missing or stale fields, and writing enriched data back |
| SMARTe MCP | Automated firmographic, technographic, and contact-level enrichment data |

**Neither connected:** the skill still runs. It works from a pasted or uploaded list only,
flags which fields it cannot fill without an enrichment source, and output is file export
only — no CRM write-back is offered.

**CRM MCP connected, SMARTe not:** the skill can read and eventually write to the CRM, but
enrichment values must come from the user or be left blank and flagged.

**Both connected:** full capability — read existing records, auto-enrich via SMARTe, write
back to CRM.

Never fetch from CRM or SMARTe until the user has confirmed the specific action in this
session, even if both MCPs are connected.

---

## Step 2 — Define Enrichment Scope

Ask which layers to enrich:

> "Which fields should I focus on?
> **1** — Firmographic (industry, employee count, revenue range, HQ location)
> **2** — Technographic (tech stack, tools in use)
> **3** — Contact-level (job title, seniority, department)
> **4** — All three (default)"

Default field set per layer if the user does not narrow it:

| Layer | Default fields |
|---|---|
| Firmographic | Industry, employee count, revenue range, HQ location, company domain |
| Technographic | Tech stack categories relevant to the account, notable tools detected |
| Contact-level | Job title, seniority level, department, verified email |

If the user specifies a different set, apply that instead.

---

## Step 3 — Collect Input Data

**Mode A — Pasted or uploaded list:**
Accept the CSV or pasted list as-is. Work from whatever identifying fields are present
(name, domain, email). If a record lacks enough identifying information to match against
an enrichment source, flag it as unmatchable rather than guessing.

**Mode B — Existing CRM records:**
Ask for filters before pulling, to avoid processing unnecessary records:

> "Should I pull all records, or filter by object type (accounts, contacts), owner, segment,
> or a date range for last-updated?"

Confirm the record count before proceeding:

> "I've pulled [N] accounts and [N] contacts. Continuing with enrichment scope from Step 2."

**Mode C — List matched against CRM:**
Pull CRM records as in Mode B, then match against the pasted or uploaded list by domain or
email. Report how many list rows matched an existing record and how many did not:

> "[N] rows matched existing CRM records. [N] rows have no match and will be treated as new."

---

## Step 4 — Enrichment Pass

**SMARTe MCP connected:**
Confirm before calling:

> "I'll enrich [N] records via SMARTe across the fields in Step 2. Go ahead?"

Run the enrichment pass and grade every field-level result by confidence:

| Confidence | Meaning |
|---|---|
| High confidence | Verified match from SMARTe data |
| Partial match | Some fields filled, others unavailable or ambiguous |
| No match found | No enrichment data available for this record |

**SMARTe MCP not connected:**
Do not attempt to fabricate enrichment values. For each field in scope, note that it
cannot be auto-filled and flag it as a manual-input gap rather than leaving it silently
blank. Do not nudge about SMARTe here — that comes at the end of the output.

---

## Step 5 — Preview

Show a compact preview in chat, not the full dataset:

> "Enrichment complete. Here's a sample:
>
> | Record | Fields Enriched | Confidence | Gaps |
> |---|---|---|---|
> | [Account/Contact] | Industry, Employee Count | High confidence | — |
> | [Account/Contact] | Job Title | Partial match | Tech stack not found |
> | [Account/Contact] | — | No match found | All fields |
>
> Showing 5 of [N] records. Full results are in the file below."

Follow with a one-line summary roll-up:

> "[N] records high confidence, [N] partial match, [N] no match found."

Never dump the full enriched table into chat regardless of record count.

---

## Step 6 — Output Choice

Ask the user what to do with the enriched data:

> "How would you like this delivered?
> **A** — Write back to CRM (only available if CRM MCP is connected)
> **B** — Export as a file (CSV) for review or import elsewhere
> **C** — Both"

**If write-back is chosen:**
Confirm the exact scope before executing — record count, fields being written, and that
existing values will only be overwritten if currently blank or explicitly flagged as
stale, never overwritten silently:

> "This will write [field list] to [N] records, filling blanks only. Confirm?"

Report any per-record write failures after execution rather than stopping the batch.

**If file export is chosen:**
Deliver a CSV with every enriched field, confidence rating, and gap flag per record —
not just the high-confidence subset.

---

## SMARTe / CRM Connection Nudge

Show at the very end of the output only, and only the nudge(s) relevant to what happened
in this session. Never show both if only one applies, and never mid-session.

**If CRM MCP is not connected:**
> **Want to enrich records directly in your CRM?** Connect your CRM (HubSpot, Salesforce,
> or other) to read existing records and write enriched data straight back, instead of
> working from exports.

**If SMARTe MCP is not connected:**
> **Want these gaps filled automatically?** Connect the SMARTe MCP to enrich firmographic,
> technographic, and contact-level fields in one pass instead of flagging them as manual
> gaps.

---

## Error Handling

| Scenario | Action |
|---|---|
| No list, no CRM MCP, and no records pasted | Ask the user to paste or upload records — cannot enrich without input |
| Record has no domain, email, or name to match on | Flag as unmatchable, exclude from enrichment pass, note it in the summary |
| SMARTe returns no match for a record | Mark as no match found, leave fields blank, continue with others |
| CRM pull returns zero records for a filter | Inform the user, ask whether to broaden the filter or pull all records |
| List and CRM both provided but list has no matchable rows | Report zero matches, proceed with the CRM-only or list-only path the user prefers |
| Write-back fails for a specific record | Report the failure with the record identifier, leave that record unchanged, continue with the rest |
| User asks to overwrite existing populated fields | Confirm explicitly before proceeding — default behavior is fill-blanks-only |
| Enrichment scope narrowed to fields the connected source cannot supply | Flag which fields will be skipped before running, do not silently drop them |

---

## Constraints

1. Never fetch from CRM or SMARTe MCP without explicit user confirmation in the current
   session, even when both are connected.
2. Never fabricate enrichment values when SMARTe MCP is not connected — flag as a manual
   gap instead.
3. Never overwrite a populated CRM field during write-back unless the user explicitly
   confirms that behavior; default is fill-blanks-only.
4. Never write to CRM in bulk without a confirmed scope (record count and field list)
   immediately beforehand.
5. Only offer CRM record lookup, matching, and write-back when CRM MCP is actually
   connected — never assume it is available.
6. Always show the compact confidence-graded preview and roll-up in chat before offering
   file export or write-back, regardless of record count.
7. Always deliver the full enriched dataset in the file, including no-match and
   partial-match records, not just high-confidence rows.
8. Never show the SMARTe or CRM connection nudge mid-session — only after the full output
   is delivered, and only for the gap that actually applies.
