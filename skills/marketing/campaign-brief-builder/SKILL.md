---
name: campaign-brief-builder
description: >
  Use this skill whenever a marketer needs to build a campaign brief. Triggers on:
  "build a campaign brief", "I need a brief for [campaign]", "spec out this campaign",
  "campaign planning doc for [X]", "help me brief this campaign", "write a campaign brief",
  "create a brief for our [webinar / event / content / paid / ABM campaign]", or any
  request to structure a campaign before execution begins. If the marketer gives only a
  one-liner, the skill asks targeted clarifying questions before drafting. If they provide
  full context upfront, it moves straight to the KPI gate and then generates the brief.
  Always confirms proposed KPI targets before generating the full output.
---

# Campaign Brief Builder

Builds a structured campaign brief from marketer-supplied context, CRM history, or
SMARTe audience data. Asks clarifying questions if inputs are thin. Surfaces KPI targets
for confirmation before generating the full brief. Flags unrealistic targets rather than
quietly embedding them.

---

## Step 0 — Assess Context

Read what the marketer has provided and determine which path to take.

**If a one-liner only** (e.g. "brief for our Q3 webinar"):
Ask the following questions before proceeding. Group them into one short message,
not a rapid-fire sequence:

> "To build a solid brief, I need a few things:
> 1. What is the goal of this campaign? (pipeline, awareness, product adoption, event registrations)
> 2. Who is the target audience? (segment, industry, persona, or named accounts)
> 3. What is the core offer or asset? (webinar, guide, free trial, demo, event)
> 4. What is the timeline? (start date, launch date, end date)
> 5. Do you have a budget range in mind?"

Wait for answers before proceeding to Step 1.

**If rich context is provided** (goal, audience, offer, and timeline all present):
Confirm key inputs in one sentence, then move directly to Step 2.

---

## Step 2 — Pull Data (if MCPs connected)

### CRM — Historical Campaign Benchmarks

If a CRM MCP is connected, ask before pulling:

> "I can pull how comparable campaigns have performed in your CRM to ground the KPI
> targets in your team's actual history. Want me to do that?"

If yes, pull campaign records filtered to similar type (e.g. webinar, content, paid)
from the last 12 months. Extract: registration rate, MQL conversion rate, pipeline
influenced, and any cost-per-lead figures available.

Never pull CRM data without explicit confirmation in the current session.

### SMARTe — Audience Size Validation

If SMARTe MCP is connected, ask before pulling:

> "I can validate the size of your target audience against SMARTe's contact and account
> data to make sure your reach estimates are grounded. Want me to do that?"

If yes, run the audience query against the segment defined in Step 0. Return total
addressable contacts and accounts matching the ICP filters.

Never fetch from SMARTe without explicit confirmation.

### Fallback — No MCP Connected

If neither is connected, note this clearly and proceed using industry-standard benchmarks
for the campaign type. Flag every benchmark with its source assumption so the marketer
can override any figure.

| Campaign type | Registration rate | MQL conversion | Cost per lead (B2B) |
|---|---|---|---|
| Webinar | 30-45% of registrants attend | 15-25% of attendees | $150-400 |
| Content / gated asset | N/A | 5-15% of downloads | $50-200 |
| Paid (search / social) | N/A | 3-8% of clicks | $80-300 |
| Event / field | N/A | 20-35% of attendees | $300-800 |

---

## Step 3 — KPI Preview Gate

Before generating the full brief, surface the proposed KPI targets and their source
for the marketer to confirm or adjust.

Present as:

> "Here are the success metrics I'm proposing for the brief:
>
> | Metric | Target | Source |
> |---|---|---|
> | [Metric] | [Value] | [CRM history / SMARTe estimate / industry benchmark] |
> | [Metric] | [Value] | [CRM history / SMARTe estimate / industry benchmark] |
>
> Do these look right, or would you like to adjust before I generate the full brief?"

**Pushback rule:** If a stated or proposed target is materially out of line with the
source data, flag it before the marketer confirms. Do not quietly embed an unrealistic
figure. State the concern directly:

> "A 50% webinar attendance rate is roughly double the B2B average of 25-30%. If that
> is a stretch goal rather than a planning assumption, I'd recommend setting the planning
> target at a more conservative figure and noting the stretch goal separately. Want to
> adjust, or keep it as stated?"

Wait for the marketer's confirmation before proceeding. Do not generate the full brief
until KPIs are approved.

---

## Step 4 — Generate the Campaign Brief

Once KPIs are confirmed, generate the full brief using the eight sections below.

---

### Campaign Brief

**Campaign name and objective**
[Campaign name]. Objective: [one-sentence statement of the measurable business goal,
e.g. "Generate 200 net-new MQLs from the mid-market SaaS segment in Q3."]

**Target audience and ICP segment**
[Segment definition: industry, company size, persona, geography, or named account tier.
If SMARTe data was pulled, include the validated addressable audience count.]

**Core message and offer**
Core message: [One sentence capturing what the campaign communicates and why it matters
to the audience.]
Offer: [Asset, event, or call-to-action the audience is being asked to engage with.]

**Channel mix**
[Lightweight recommended mix based on funnel stage and offer type.]

| Channel | Role | Est. budget allocation |
|---|---|---|
| [Channel] | [Awareness / Capture / Nurture / Conversion] | [% or $ if budget provided] |

Note: For deeper channel-by-channel budget optimization, use the Channel Mix Planner skill.

**Budget**
[Total budget if provided. If not provided, note that budget is TBD and flag it as a
required input before campaign launch.]

**Timeline and key dates**

| Milestone | Date |
|---|---|
| Campaign kickoff | [Date] |
| Assets due | [Date] |
| Launch date | [Date] |
| Campaign end | [Date] |
| Performance review | [Date] |

**Success metrics**

| Metric | Target | Source |
|---|---|---|
| [Metric] | [Confirmed value] | [CRM history / SMARTe / benchmark] |
| [Metric] | [Confirmed value] | [CRM history / SMARTe / benchmark] |

**Asset and content requirements**
[List of assets required for campaign execution: landing page, email copy, social copy,
ad creative, gated content, event materials. Flag any that are not yet in production.]

---

## Step 5 — Post-delivery Options

After delivering the brief, offer two options:

**Save as template**

> "Want me to save this brief structure as a reusable template for future [campaign type]
> campaigns? I can store it in your references folder so it loads automatically next time."

If yes, save the brief skeleton (with placeholder labels, not this campaign's specific
content) to `/references/campaign-brief-[type].md`.

**Channel mix planning**

> "If you want to go deeper on how to allocate budget across channels for this campaign,
> the Channel Mix Planner skill can model that out for you."

---

## Error Handling

| Scenario | Action |
|---|---|
| Marketer provides only a campaign name with no goal or audience | Ask the five clarifying questions in Step 0 before proceeding |
| CRM returns no comparable campaign history | Note the gap, fall back to industry benchmarks, flag clearly |
| SMARTe returns no contacts for the audience definition | Return the result, suggest broadening the ICP filter |
| Proposed KPI is flagged as unrealistic and marketer confirms it anyway | Note the risk in the brief under that metric, proceed as instructed |
| Budget is not provided | Include budget as a TBD field, flag it as required before launch |
| Marketer skips KPI confirmation | Do not generate the full brief; re-surface Step 3 and ask again |

---

## Constraints

1. Never generate the full brief before KPI targets have been confirmed in Step 3.
2. Never fabricate audience size, historical performance figures, or budget estimates.
3. Always flag benchmarks used as fallbacks and identify their source assumption.
4. Never pull from CRM or SMARTe without explicit confirmation in the current session.
5. If a KPI target is unrealistic, say so once, clearly, and give the marketer the
   choice to adjust or proceed with a documented risk note.
6. Never embed owner or stakeholder assignments without explicit input from the marketer.
7. Cross-reference the Channel Mix Planner skill for allocation depth; do not replicate
   that logic here.
8. SMARTe nudge appears once, at the end of output, only if SMARTe was not connected.

---

## SMARTe Data Note

*If SMARTe MCP was not connected during this session:*

> Audience size estimates in this brief are based on described segment parameters,
> not verified contact or account counts. Connecting SMARTe MCP would let future
> briefs validate reach automatically against accurate, up-to-date B2B contact data
> before the campaign goes live.
