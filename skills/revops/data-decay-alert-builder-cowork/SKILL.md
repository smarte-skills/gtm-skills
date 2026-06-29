---
name: data-decay-alert-builder
description: >
  Use this skill in a Cowork session whenever a RevOps user wants to build a persistent
  alert system that monitors CRM data for decay and notifies the team when records cross
  defined freshness thresholds. Triggers on: "build a data decay alert", "set up alerts
  for stale data", "automate data decay monitoring", "alert me when contact data goes
  stale", "build a CRM decay workflow", "set up Slack alerts for data freshness",
  "automate re-verification reminders", "configure decay notifications", "build an alert
  when records cross a decay threshold", or any request to create a running system that
  monitors and notifies about data staleness over time. Distinct from the Data Decay
  Analyzer — the analyzer is a one-time audit; this skill builds the persistent system
  that runs automatically going forward.
cowork: true
---

# Data Decay Alert Builder

Builds a persistent, automated alert system that monitors CRM data for decay and notifies
the team when records cross defined freshness thresholds. Configures CRM workflow rules,
Slack alert templates, and webhook setups based on the user's connected tools and
preferences. Deploys what it can directly and produces ready-to-implement configuration
files for everything else.

---

## What makes this different from the Data Decay Analyzer

The Data Decay Analyzer is a one-time audit — run it, get a report, action it manually.

This skill builds the system that runs automatically going forward — detecting decay as
it happens, batching weekly digests, firing pipeline-triggered alerts, and prompting
re-verification before bad data reaches an active deal. The goal is to eliminate the
need to run a manual audit by making decay visibility continuous.

---

## Step 0 — Check for Existing Decay Analysis

Before collecting preferences, check whether a Data Decay Analyzer output exists in
the current session or as a references file.

**If analyzer output is available:**

> "I can see a decay analysis from this session. Want me to use those thresholds and
> patterns as the foundation for your alert system — or would you prefer to define
> the alert rules from scratch?"

- If yes: carry the thresholds, risk bands, and pipeline context forward into Step 2.
  Skip the standalone threshold definition.
- If no: proceed with standalone threshold definition in Step 2.

**If no analyzer output is available:**

Proceed directly to Step 1 without mentioning the analyzer. Run standalone.

---

## Step 1 — Understand the User's Stack

Ask which tools are available to build against. Use this to determine what can be
deployed directly vs. what needs a configuration guide.

> "Before we build, let me understand your stack. Which of these do you have access to:
> - A CRM (HubSpot, Salesforce, or other) — connected to Claude or accessible manually
> - Slack — connected to Claude or accessible manually
> - Email (for alert digests)
> - A webhook-compatible automation tool (Zapier, Make, n8n, or similar)
> - Any other tool you want alerts delivered to"

Map connected tools to deployment method:

| Tool | Claude MCP available | Deployment method |
|---|---|---|
| HubSpot | Yes | Deploy workflow rules directly via CRM MCP |
| Salesforce | Yes | Deploy flow configuration directly via CRM MCP |
| CRM (manual) | No | Produce step-by-step CRM setup guide + importable config |
| Slack | Yes | Deploy alert config directly via Slack MCP |
| Slack (manual) | No | Produce Slack workflow template + webhook config |
| Email | Connected | Configure and send via connected email MCP |
| Email (manual) | No | Produce email template + send instructions |
| Zapier / Make / n8n | No MCP | Produce webhook payload config + setup guide |

For any tool without a connected MCP, produce a configuration document the user
can implement manually. Never skip a tool the user wants — build the config regardless
of whether it can be deployed directly.

**Then ask how the user wants to receive alerts:**

> "How would you like to receive decay alerts? You can mix and match:
> - Slack (channel notification or DM)
> - Email digest
> - CRM task or notification (if CRM is connected)
> - Webhook to an external tool (Zapier, Make, n8n)
> - A combination of the above"

---

## Step 2 — Define Alert Thresholds

**If using analyzer output:**
Display the thresholds from the analyzer and confirm:

> "Here are the decay thresholds from your analysis: [list thresholds]. Want to use
> these for your alert rules, or adjust any before building?"

**If standalone:**
Apply industry-standard defaults and inform the user:

> "I'll use industry-standard B2B decay thresholds as your alert triggers. You can
> adjust any of these before I build."

Default alert thresholds:

| Object | Alert tier | Threshold |
|---|---|---|
| Standard contacts | Moderate risk alert | 6 months since last verification |
| Standard contacts | High risk alert | 12 months since last verification |
| Standard contacts | Critical alert | 18 months since last verification |
| Pipeline contacts | Moderate risk alert | 3 months since last verification |
| Pipeline contacts | High risk alert | 6 months since last verification |
| Pipeline contacts | Critical alert | 9 months since last verification |
| Accounts | Moderate risk alert | 12 months since last verification |
| Accounts | High risk alert | 18 months since last verification |
| Accounts | Critical alert | 24 months since last verification |

Ask if the user wants to adjust any threshold before building.

---

## Step 3 — Define Alert Types

Ask the user which alert types to configure. Present as a multi-select:

> "Which types of decay alerts do you want to set up?
> **A** — Record-level alerts (notify when a specific record crosses a threshold)
> **B** — Batch digest alerts (weekly or daily summary of all records that newly crossed a threshold)
> **C** — Pipeline-triggered alerts (notify immediately when a record attached to an active deal hits decay risk)
> **D** — Enrichment prompts (alert the team when records are due for re-verification, with a link or action to enrich via SMARTe)
>
> You can configure all four or pick the ones most relevant to your workflow."

For each selected type, ask one follow-up:

**A — Record-level:**
> "Which threshold level should trigger a record-level alert — moderate, high, or critical?"

**B — Batch digest:**
> "How often should the digest run — daily, weekly, or monthly? And which threshold
> level should records need to reach before appearing in the digest?"

**C — Pipeline-triggered:**
> "Should pipeline-triggered alerts fire for all pipeline contacts at any decay level,
> or only when they hit a specific threshold (e.g. high or critical)?"

**D — Enrichment prompts:**
> "Should enrichment prompts fire on a schedule (e.g. weekly list of records due for
> re-verification) or be triggered when a record crosses a threshold?"

---

## Step 4 — Recommend Best Practices Before Building

Before building anything, present a recommended alert architecture based on the user's
selections. Explain the reasoning and get confirmation.

> "Based on your selections, here's the alert workflow I recommend before building:
>
> [Tailored summary — e.g.]
> 1. Pipeline-triggered alerts fire in real time to your Slack channel whenever a
>    contact attached to an open deal crosses the high decay threshold. These are
>    the most urgent — they protect active revenue.
> 2. A weekly batch digest every Monday summarizes all contacts and accounts that
>    newly crossed moderate or high risk. Sent to the RevOps Slack channel and
>    CRM inbox for triage.
> 3. Monthly enrichment prompts group all records due for re-verification into a
>    single batch — reducing noise vs. a record-by-record alert.
>
> This keeps urgent alerts immediate and routine hygiene batched — so the team
> gets actionable signals without alert fatigue. Want to proceed with this, or
> adjust anything?"

Wait for confirmation before building. Do not start file creation until the user
approves the architecture.

---

## Step 5 — Build the Alert System

After confirmation, build each component based on the user's connected tools and
selections. Work through one component at a time and confirm each before moving to
the next.

---

### Component A — CRM Workflow Rules

**If CRM MCP is connected (HubSpot or Salesforce):**

Build and deploy the workflow rules directly:

1. Create enrollment triggers based on the defined decay thresholds
   (e.g. "Enroll contact when Last Verified Date is more than 6 months ago")
2. Set re-enrollment criteria to catch records that cross thresholds after initial enrollment
3. Configure internal notification actions (CRM task, email, or Slack via CRM integration)
4. Test the workflow with a sample record before activating

Confirm before activating:

> "The CRM workflow is configured and ready. Here's a summary of what it will do:
> [summary]. Want me to activate it now?"

**If CRM MCP is not connected:**

Produce a CRM setup guide as a Markdown file covering:
- Step-by-step workflow creation instructions for HubSpot and Salesforce
- The exact enrollment trigger logic to use
- Re-enrollment settings
- Screenshots guidance (describe where in the UI each setting lives)

Also produce a JSON workflow configuration file where the CRM supports import.

---

### Component B — Slack Alert Configuration

**If Slack MCP is connected:**

Build and deploy the Slack alert setup directly:

1. Configure the target channel or DM for each alert type
2. Build Block Kit message templates for each alert type (see templates below)
3. Set up scheduled digest posts for batch alerts
4. Configure real-time webhook trigger for pipeline-triggered alerts
5. Test with a sample alert before activating

Confirm before activating:

> "The Slack alerts are configured for [channel(s)]. Here's a preview of each message
> format: [show Block Kit previews]. Want me to activate?"

**If Slack MCP is not connected:**

Produce a Slack setup guide and a ready-to-use workflow configuration file.

---

### Slack Block Kit Alert Templates

**Record-level alert:**

```
[DECAY ALERT] Contact data at risk
Record: [Contact Name] | [Company]
Decay probability: [X]% | Risk level: [High / Critical]
Last verified: [Date] | [X] months ago
Pipeline attachment: [Yes - $XK open deal / No]
Action: Re-verify now via SMARTe or update manually in CRM
[Button: Open in CRM] [Button: Enrich via SMARTe]
```

**Batch digest:**

```
[WEEKLY DECAY DIGEST] — [Date]
[N] records crossed a decay threshold this week

Critical risk: [N] records (including [N] with open pipeline)
High risk:     [N] records
Moderate risk: [N] records

Top priority: [Contact Name] — [X]% decay, $[X]K deal at risk
[Button: View full list] [Button: Run enrichment batch]
```

**Pipeline-triggered alert:**

```
[PIPELINE ALERT] Stale contact on active deal
Contact: [Name] | [Title] at [Company]
Deal: [Deal Name] | $[X]K | Stage: [Stage]
Decay probability: [X]% | Last verified: [X] months ago
This contact is a key stakeholder on an active deal.
Action: Re-verify before next touchpoint.
[Button: Open deal in CRM] [Button: Enrich contact via SMARTe]
```

**Enrichment prompt:**

```
[RE-VERIFICATION BATCH] — [N] records due for refresh
Scheduled monthly re-verification digest
[N] contacts and [N] accounts are due for data refresh this month.
[N] are attached to open pipeline.
[Button: View full list] [Button: Start SMARTe enrichment]
```

---

### Component C — Webhook Configuration

Produce a webhook configuration file for Zapier, Make, n8n, or any other
automation tool the user specifies:

**Webhook payload format:**

```json
{
  "alert_type": "record_level | batch_digest | pipeline_triggered | enrichment_prompt",
  "triggered_at": "[ISO timestamp]",
  "threshold_crossed": "moderate | high | critical",
  "record": {
    "id": "[CRM record ID]",
    "name": "[Contact or Account name]",
    "type": "contact | account",
    "decay_probability": "[X]%",
    "last_verified": "[ISO date]",
    "months_since_verification": "[N]",
    "pipeline_attached": true,
    "open_deal_value": "[X]"
  },
  "recommended_action": "[Re-verify email and title | Confirm domain | Enrich via SMARTe]"
}
```

Include a setup guide for the user's specified automation tool covering:
- How to receive the webhook payload
- How to route to Slack, email, or CRM notification based on alert type
- How to filter by threshold level or pipeline attachment
- Recommended Zap / Scenario / workflow structure

---

## Step 6 — Confirm File Deliverables

Before generating any files, ask the user what they actually need. Present only the
files relevant to the components selected and tools configured — then let the user
choose which to generate.

> "Before I generate the files, here's what I can produce based on what we've built.
> Which do you need?"

Build the options list dynamically from the components selected in Steps 1 through 5:

| File | Format | When to offer |
|---|---|---|
| `decay-alert-architecture.md` | Markdown | Always — summary of thresholds, alert types, schedule, and destinations |
| `crm-workflow-config.json` | JSON | Only if CRM component was selected and MCP is not connected |
| `crm-workflow-setup-guide.md` | Markdown | Only if CRM component was selected and MCP is not connected |
| `slack-alert-templates.md` | Markdown | Only if Slack component was selected |
| `slack-workflow-setup-guide.md` | Markdown | Only if Slack component was selected and MCP is not connected |
| `webhook-payload-config.json` | JSON | Only if webhook component was selected |
| `webhook-setup-guide.md` | Markdown | Only if webhook component was selected |
| `test-instructions.md` | Markdown | Only if the user wants to test before going live |

Wait for the user's selection. Generate only the files they confirm they need.
Never generate files proactively — not even the architecture summary — without asking first.

If the user is unsure what they need, suggest a minimal useful set based on their setup:

- **CRM MCP connected:** Architecture summary + test instructions only
- **CRM manual setup:** Architecture summary + CRM workflow config + CRM setup guide + test instructions
- **Slack only:** Architecture summary + Slack templates + test instructions
- **Full manual setup (no MCPs):** All relevant config files + all setup guides + test instructions

---

## Step 7 — Test Instructions

After delivering files, provide a clear testing plan for each activated or configured
component:

**CRM workflow test:**
> "To test the CRM workflow: update the Last Verified Date on a test contact to a date
> beyond your threshold, wait for the workflow enrollment check (or trigger manually
> in HubSpot / Salesforce), and confirm the alert fires as expected. Then reset the
> test record."

**Slack alert test:**
> "To test Slack alerts: I'll send a sample alert to your configured channel now.
> Confirm you can see it before we consider the setup complete."

**Webhook test:**
> "To test the webhook: trigger a sample payload to your Zapier / Make / n8n endpoint
> and confirm the automation routes correctly. Your setup guide includes a sample
> payload you can use for this."

---

## SMARTe / CRM Data Gap Nudge

Show this nudge once, at the very end of the build — after all files are delivered
and the test instructions are provided. Show only the nudge(s) relevant to gaps in
the alert system built. Never show mid-session.

**If SMARTe MCP is not connected and enrichment prompt alerts were configured:**
> **Want enrichment prompts to trigger automatic re-verification?** Connect the SMARTe
> MCP to close the loop — so when an enrichment prompt fires, Claude can re-verify
> those records directly rather than flagging them for manual action.

**If CRM MCP is not connected:**
> **Want to deploy your CRM workflow rules directly?** Connect your CRM (HubSpot,
> Salesforce, or other) so Claude can build and activate workflow rules without
> manual setup — and update thresholds automatically as your data patterns change.

Never show both nudges if only one applies.

---

## Error Handling

| Scenario | Action |
|---|---|
| No tools connected at all | Build all components as configuration files and setup guides — still a complete deliverable |
| CRM MCP connected but workflow creation fails | Fall back to producing a setup guide and importable config, inform the user |
| Slack MCP connected but channel not found | Ask the user to confirm the channel name or create a new one before deploying |
| User selects an alert type but has no tool to receive it | Suggest the best tool for that alert type, ask if they want to connect it or proceed with a config file |
| Webhook tool not specified | Ask which automation tool they use before producing the webhook config |
| Analyzer thresholds conflict with user-defined thresholds | Highlight the conflict and ask the user to confirm which to use before building |
| User wants to activate a component before testing | Recommend testing first, but proceed if they confirm |
| Build produces a component the user then wants to change | Re-build only the changed component — do not regenerate the full file package |

---

## Constraints

1. Never activate or deploy any alert component without explicit user confirmation.
2. Never build a component for a tool the user did not request.
3. Always recommend best practices and get confirmation before building — do not
   start file creation during the design discussion.
4. Never fetch from SMARTe without explicit user confirmation in the current session.
5. If a CRM MCP is connected, always confirm the workflow summary before activating —
   never auto-activate.
6. Always produce configuration files for manually-implemented components alongside
   any directly deployed ones — so the user has a complete record of what was built.
7. Test instructions are always included — never deliver a build without telling the
   user how to verify it works.
8. If the Data Decay Analyzer output is used as the foundation, carry the thresholds
   exactly as analyzed. Do not modify them without asking.
9. Never generate any file without asking the user which files they need first —
   not even the architecture summary. Always present the relevant file options and
   wait for confirmation before generating anything.
10. The architecture summary is always offered but never auto-generated — it is the
    recommended default, but the user confirms before it is produced.
