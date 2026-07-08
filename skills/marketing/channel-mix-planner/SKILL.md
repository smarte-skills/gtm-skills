---
name: channel-mix-planner
description: >
  Use this skill whenever a marketer needs to decide which channels to use for a campaign
  and how to allocate budget across them. Triggers on: "which channels should I use for
  this campaign", "help me plan my channel mix", "how should I split my budget", "what
  channels work for [goal / audience / offer type]", "channel strategy for [campaign]",
  "where should I spend my campaign budget", or any request to recommend and allocate
  across marketing channels. Works standalone or as a follow-on from the Campaign Brief
  Builder. Always confirms the proposed channel list and split before generating the
  full rationale and allocation output.
---

# Channel Mix Planner

Recommends a ranked channel mix and budget allocation based on campaign goal, funnel
stage, and offer type. Grounds recommendations in CRM performance history where available
and flags concentration risk before the marketer commits to a plan.

---

## Step 0 — Assess Context

**If the marketer is coming from a Campaign Brief:**
Extract goal, funnel stage, offer type, target audience, and budget directly from the
brief. Confirm the inputs in one sentence, then move to Step 2.

**If the marketer arrives without a brief:**
Ask before proceeding:

> "To recommend the right channel mix, I need a few inputs:
> 1. What is the campaign goal? (pipeline, awareness, event registrations, product adoption)
> 2. What funnel stage is this targeting? (TOFU / awareness, MOFU / consideration, BOFU / conversion)
> 3. What is the core offer or asset? (webinar, gated content, demo, free trial, event)
> 4. Who is the target audience? (segment, industry, persona, or named accounts)
> 5. What is the total campaign budget, if known?"

If no brief exists and these questions are answered, note that the Campaign Brief Builder
skill can build a full brief from these inputs before channel planning begins.

---

## Step 1 — Map Funnel Stage and Offer Type to Channels

Use the table below to generate the initial channel shortlist. Select the top three to
five channels with the strongest fit for the stated goal, funnel stage, and offer type.
Rank by fit, not by channel familiarity.

| Funnel stage | Offer type | Recommended channels (in fit order) |
|---|---|---|
| TOFU | Gated content / report | LinkedIn sponsored content, content syndication, SEO / organic, display |
| TOFU | Webinar | LinkedIn, email to house list, partner co-promotion |
| TOFU | Event or field | LinkedIn, paid social, partner channels, direct outreach |
| MOFU | Case study / demo offer | LinkedIn retargeting, branded paid search, email nurture |
| MOFU | Webinar (educational) | Email nurture, LinkedIn, organic social |
| MOFU | Comparison / review content | Branded paid search, G2 / review platforms, retargeting |
| BOFU | Demo or free trial | Branded paid search, LinkedIn retargeting, direct outreach (SDR) |
| BOFU | Proposal / pricing page | Branded paid search, direct outreach, email sequence |
| BOFU | Event (executive / field) | Direct outreach, LinkedIn, account-specific email |

If the funnel stage or offer type does not match a row exactly, select the closest fit
and flag the assumption to the marketer.

---

## Step 2 — Pull CRM Data (if connected)

If a CRM MCP is connected, ask before pulling:

> "I can pull your historical CPL and pipeline contribution by channel from your CRM to
> ground the allocation in your team's actual performance. Want me to do that?"

If yes, pull campaign records from the last 12 months. Extract per channel:
cost per lead, pipeline influenced, and conversion rate from lead to opportunity.
Use this data to adjust the benchmark allocation in Step 3.

Never pull CRM data without explicit confirmation in the current session.

If CRM is not connected or the marketer declines, use the benchmark CPL table in
Step 4 and flag every figure as a benchmark estimate.

---

## Step 3 — Preview Gate

Before generating the full output, surface the proposed channel list and budget split
in a compact preview for the marketer to confirm or adjust:

> "Here is the proposed channel mix for this campaign:
>
> | Rank | Channel | Budget allocation | Rationale (one line) |
> |---|---|---|---|
> | 1 | [Channel] | [% or $] | [One-line fit reason] |
> | 2 | [Channel] | [% or $] | [One-line fit reason] |
> | 3 | [Channel] | [% or $] | [One-line fit reason] |
>
> Does this look right, or would you like to adjust before I generate the full plan?"

**Concentration pushback rule:** If any single channel is allocated more than 70% of
the total budget, flag it before the marketer confirms:

> "[Channel] is carrying [X]% of the total budget. Concentrating more than 70% of spend
> in one channel increases performance risk if that channel underdelivers. A typical
> B2B mix distributes lead volume across at least two to three channels. Want to adjust
> the split, or keep it as stated?"

If the marketer confirms the concentrated split, note the risk in the final output and
proceed as instructed.

Wait for explicit confirmation before generating the full output.

---

## Step 4 — Generate the Channel Mix Plan

Once the preview is confirmed, generate the full output across four sections.

---

### Recommended Channel List

Ranked by fit for this campaign's goal, funnel stage, and offer type.

| Rank | Channel | Fit rationale |
|---|---|---|
| 1 | [Channel] | [Why this channel fits this goal, stage, and offer] |
| 2 | [Channel] | [Why this channel fits this goal, stage, and offer] |
| 3 | [Channel] | [Why this channel fits this goal, stage, and offer] |
| 4 | [Channel] | [Why this channel fits this goal, stage, and offer (if applicable)] |
| 5 | [Channel] | [Why this channel fits this goal, stage, and offer (if applicable)] |

---

### Budget Allocation Table

| Channel | Allocation | Budget ($) | Expected CPL | Est. leads |
|---|---|---|---|---|
| [Channel] | [%] | [$] | [$] | [N] |
| [Channel] | [%] | [$] | [$] | [N] |
| [Channel] | [%] | [$] | [$] | [N] |
| Total | 100% | [$] | | [N] |

If budget was not provided, the allocation column shows percentage only. Budget ($),
expected CPL, and estimated leads columns are left blank with a note to populate once
budget is confirmed.

---

### Rationale by Channel

For each recommended channel, a short paragraph covering: why it fits this funnel stage
and offer type, what role it plays in the overall mix (reach, capture, nurture, or
conversion), and any execution considerations specific to this campaign.

---

### Benchmark CPL Reference

| Channel | B2B benchmark CPL | Source basis |
|---|---|---|
| LinkedIn sponsored content | $80-200 | B2B industry average |
| LinkedIn lead gen forms | $60-150 | B2B industry average |
| Google paid search (branded) | $30-80 | B2B industry average |
| Google paid search (non-branded) | $50-150 | B2B industry average |
| Content syndication | $40-100 | B2B industry average |
| Display / programmatic | $20-60 | B2B industry average |
| Email (house list) | $5-20 | B2B industry average |
| Email (rented / partner list) | $30-80 | B2B industry average |
| Webinar (owned) | $50-150 | B2B industry average |
| Direct outreach (SDR-assisted) | $100-300 | B2B industry average |

If CRM history was pulled, replace the relevant rows with the team's actual figures and
label them as such.

---

## Error Handling

| Scenario | Action |
|---|---|
| Funnel stage not stated | Ask before mapping to channels; do not infer from offer type alone |
| Budget not provided | Generate percentage split only; flag dollar figures as TBD |
| CRM returns no channel-level performance data | Note the gap, fall back to benchmarks, flag clearly |
| Marketer requests a channel not in the fit table | Include it, note the fit rationale or lack of it, let the marketer decide |
| Concentration pushback confirmed by marketer | Include a risk note in the final output; do not refuse to proceed |
| Marketer skips preview confirmation | Do not generate the full plan; re-surface Step 3 and ask again |

---

## Constraints

1. Never generate the full plan before the preview in Step 3 is confirmed.
2. Never fabricate CPL figures or pipeline contribution data.
3. Always label benchmark CPL figures as estimates and identify their basis.
4. Never pull from CRM without explicit confirmation in the current session.
5. Do not recommend channels based on team familiarity or past habit; rank by fit only.
6. Scheduling, calendar conflict checking, and creative copy are out of scope for this skill.
7. If the marketer arrives without a brief, note the Campaign Brief Builder skill once;
   do not repeat the reference.
8. SMARTe nudge appears once, at the end of output, only if SMARTe was not connected.

---

## SMARTe Data Note

*If SMARTe MCP was not connected during this session:*

> Audience reach estimates in this plan are based on benchmark figures, not verified
> contact or account counts for your target segment. Connecting SMARTe MCP would let
> future channel plans validate whether your recommended channels can actually reach
> your ICP at the estimated volume before budget is committed.
