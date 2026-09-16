---
name: gtm-engineer-prospect-list-builder
description: >
  Builds programmatic prospect list workflows for GTM engineers using SMARTe MCP. Trigger
  this skill whenever a GTM engineer wants to build, automate, or scale prospect list
  generation using live B2B data. Triggers on: "build a prospect list workflow", "automate
  prospecting", "pull prospects from SMARTe", "build a list building automation", "create
  a prospect pipeline", "engineer a prospecting workflow", "generate a list using MCP", or
  any request to programmatically build prospect lists using SMARTe's data platform and
  MCP integration. Unlike a one-off seller list, this defines a reusable workflow spec —
  criteria, volume target, cadence, and routing destination — sized for bulk, large-volume
  generation rather than a single rep's outreach list. Detects SMARTe MCP and degrades
  gracefully if it is not connected.
---

# Prospect List Builder (GTM-Engineers)

Defines a reusable prospecting workflow spec — targeting criteria, volume target, intended
cadence, and a fixed routing destination — then executes it to produce a bulk, large-volume
prospect list. This is not a one-off personalized list for a single seller; it is the
automation artifact a GTM engineer builds once and re-runs or hands off to a scheduling
system. Uses SMARTe MCP for account discovery and enrichment, and CRM MCP (if connected)
to exclude accounts already owned. Never pulls or writes data without explicit confirmation.

---

## Step 0 — New Workflow or Re-Run

Ask the user which mode applies:

> "Are we defining a new prospecting workflow, or re-running one you already have a spec
> for? If you have an existing spec, paste it in and I'll execute it as defined."

**New workflow:** proceed through Steps 1-5 to build the spec.
**Re-run existing spec:** parse the pasted spec, confirm the criteria and routing back to
the user in one line, and skip to Step 6 (Execute) unless they want to adjust something
first.

---

## Step 1 — Input Basis

Ask how targeting criteria should be established:

> "How should I define the target criteria?
> **A** — Manual criteria (industry, size, geography, tech stack, etc.)
> **B** — Seed-account pattern extraction (give me 5-10 reference accounts and I'll extract
> the firmographic and technographic pattern from them)
> **C** — Both — manual filters as hard constraints, seed pattern as a scoring signal"

**Mode A:** Collect filters directly. Default fields if the user doesn't specify:

| Filter | Default |
|---|---|
| Industry | Not restricted unless specified |
| Employee count | Not restricted unless specified |
| Geography | Not restricted unless specified |
| Tech stack | Not restricted unless specified |

**Mode B:** Ask for 5-10 seed accounts. Confirm before enriching them via SMARTe:

> "I'll enrich these [N] seed accounts via SMARTe to extract the dominant firmographic and
> technographic pattern. Go ahead?"

Extract the pattern and confirm it back before proceeding:

> "Pattern extracted: [industry], [size range], [region], [top tech stack signals]. Use
> this as the targeting criteria?"

**Mode C:** Run Mode B's extraction first, then apply Mode A's manual filters as hard
constraints on top of the extracted pattern. Manual filters always take precedence when
they conflict with the extracted pattern.

---

## Step 2 — Volume Target

Ask what scale this workflow should produce:

> "What volume are we targeting per run? This is built for bulk generation, so give me a
> rough number or range (e.g., 200, 500-1000, 'as many qualified matches as exist')."

Note that large volume targets may require multiple paginated SMARTe searches. Confirm
before running more than one batch pull:

> "This will take [N] batched searches to reach the target volume. Continue?"

---

## Step 3 — Exclusions

**If CRM MCP is connected:**

> "Should I exclude accounts already in the CRM — existing customers, open pipeline, or
> accounts already assigned to a rep? I can pull identifiers to exclude before running
> discovery."

Confirm before pulling CRM data for exclusion matching. Apply exclusions by domain match.

**If CRM MCP is not connected:**

Note that exclusions cannot be applied automatically this session, and proceed without
them. Flag this in the final output so the user knows the list may include accounts
already owned.

---

## Step 4 — Cadence (Spec Metadata)

Ask what cadence this workflow is intended for, for documentation purposes:

> "How often should this workflow run — one-time, weekly, monthly, or something else? I
> can't self-schedule, but I'll document this in the spec so it can be wired into a
> scheduler or re-run on demand."

Record the answer as metadata in the spec. Do not imply the skill will automatically
re-trigger itself.

---

## Step 5 — Routing Destination (Fixed in Spec)

Ask once, as part of the spec definition, not per run:

> "Where should this workflow's output route to every time it runs?
> **A** — Slack (channel)
> **B** — CRM (import as new records)
> **C** — CSV file"

Record the choice as a fixed part of the spec. If the user wants to change it later, that
requires editing the spec, not a new prompt each run.

---

## Step 6 — Execute

Summarize the full spec before running and get final confirmation:

> "Spec summary: criteria basis [A/B/C], target volume [N], exclusions [on/off], cadence
> [X], routing [destination]. Run it now?"

Run discovery via SMARTe MCP against the criteria, apply exclusions if enabled, and score
each result:

| Fit tier | Meaning |
|---|---|
| Strong fit | Matches all criteria and, if seed-based, closely matches the extracted pattern |
| Moderate fit | Matches most criteria with one or more soft mismatches |
| Weak fit | Matches only the loosest constraints |

---

## Step 7 — Preview and Deliver

Show a compact preview in chat regardless of volume:

> "Generated [N] accounts: [N] strong fit, [N] moderate fit, [N] weak fit. Showing the top
> 10 strong-fit accounts below. Full list routes to [destination]."

Never render the full bulk list in chat. Deliver to the routing destination defined in
Step 5:

- **Slack:** confirm channel before posting, post a summary plus a file attachment for
  large volumes.
- **CRM:** confirm field mapping and record count before import, report any import
  failures per record after the batch completes.
- **CSV:** deliver the full list with fit tier and criteria-match notes per row.

Always deliver the workflow spec itself alongside the results, as a reusable file the
user can paste back in for a future re-run.

---

## SMARTe / CRM Connection Nudge

Show only at the end, only for the gap that applies, never mid-session.

**If SMARTe MCP is not connected:**
> **Want live discovery instead of a manual list?** Connect SMARTe MCP to run this workflow
> against real-time firmographic and technographic data instead of static input.

**If CRM MCP is not connected:**
> **Want to exclude accounts you already own?** Connect your CRM so future runs of this
> workflow automatically skip existing customers and open pipeline.

---

## Error Handling

| Scenario | Action |
|---|---|
| No SMARTe MCP and Mode B or C selected | Cannot extract a pattern without SMARTe; offer Mode A only, or ask the user to connect SMARTe |
| Seed accounts have no consistent pattern | Report that no dominant pattern was found, ask for manual criteria instead |
| Volume target unreachable given criteria | Report the actual match count found, ask whether to loosen criteria or accept fewer results |
| Exclusion pull returns no CRM data | Proceed without exclusions, flag this in the output |
| Routing destination fails (Slack post fails, CRM import errors) | Report the failure, fall back to CSV delivery so the list isn't lost |
| Re-run of an existing spec references a routing destination no longer valid | Ask the user to confirm or update the destination before executing |
| User asks to change routing mid-run rather than editing the spec | Explain that routing is fixed per spec, offer to output this run's results to an alternate destination as a one-time exception |

---

## Constraints

1. Never pull from SMARTe or CRM MCP without explicit confirmation in the current session.
2. Never imply the skill will automatically re-trigger on the stated cadence — cadence is
   documentation only unless the user has an external scheduler.
3. Never render the full bulk list in chat regardless of volume — preview only, full
   results go to the routing destination and file.
4. Routing destination is fixed as part of the spec, not re-asked on every run, unless the
   user explicitly edits the spec.
5. Manual criteria always take precedence over an extracted seed pattern when the two
   conflict.
6. Never fabricate a firmographic or technographic pattern from seed accounts that show no
   consistent signal.
7. Always deliver the reusable spec file alongside results so the workflow can be re-run.
8. Never apply CRM exclusions without first confirming the pull with the user.
