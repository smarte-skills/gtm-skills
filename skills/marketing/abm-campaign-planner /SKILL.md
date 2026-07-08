---
name: abm-campaign-planner
description: >
  Use this skill whenever a marketer needs to design the campaign plays for an ABM
  program across account tiers. Triggers on: "plan my ABM campaign", "design plays for
  my ABM accounts", "what should we do with our Tier 1 accounts", "build an ABM program
  plan", "how do I structure ABM plays per tier", "ABM campaign design", "plan outreach
  and content by tier", or any request to define what content, channels, cadence, and
  triggers apply to each ABM tier. Takes a tiered account list as input and produces a
  structured play design per tier ready for team execution. Always confirms the play
  structure before generating the full plan.
---

# ABM Campaign Planner

Designs structured campaign plays per ABM tier: content type, channel sequence, cadence,
engagement triggers, and success metrics. Works from a tiered account list and engagement
history. Flags budget and timeline constraints that would prevent genuine 1:1 execution
before the plan is built.

---

## Step 0 — Collect Inputs

Ask the marketer for the following before proceeding. Accept all at once if provided;
ask only for what is missing.

> "To design your ABM plays, I need:
> 1. Your tiered account list (paste, upload, or I can pull from CRM)
> 2. Program goal: pipeline generation, expansion into existing accounts, or competitive
>    displacement?
> 3. Program duration (start and end date)
> 4. Total program budget
> 5. Team available to execute: how many people and roughly how much of their time?"

If the marketer is coming from the ABM Account Tiering skill, the account list and tier
assignments are already available. Confirm before using:

> "I can see you have a tiered account list from the tiering session. Want me to use
> that as the input for this plan?"

---

## Step 1 — Run Budget and Timeline Check

Before any MCP calls or plan generation, validate that the inputs support the play types
implied by the tier structure.

**Budget check (Tier 1):**
Divide total budget by the number of Tier 1 accounts. If the per-account figure falls
below $3,000, flag it:

> "With [N] Tier 1 accounts and a total budget of [$X], the per-account budget is [$Y].
> Genuine 1:1 plays (custom content, personalized creative, and targeted media) typically
> require at least $3,000 per account to execute with real differentiation. At the current
> split, Tier 1 will effectively receive a Tier 2 play. You can reduce Tier 1 account
> count, increase budget, or adjust expectations. How would you like to proceed?"

Wait for the marketer's answer before continuing.

**Timeline check:**
If the program duration is under eight weeks, flag it:

> "ABM engagement sequences typically need 8-12 weeks to generate pipeline signals.
> A [N]-week program may not give enough time to move accounts from first touch to
> sales-ready engagement. Want to extend the timeline, or should I design the plays
> for a compressed run with adjusted success metrics?"

Wait for the marketer's answer before continuing.

---

## Step 2 — Pull CRM Engagement History (if connected)

If a CRM MCP is connected, ask before pulling:

> "I can pull existing engagement history per account from your CRM to determine where
> each account should enter the play sequence rather than starting everyone from cold.
> Want me to do that?"

If yes, pull: last activity date, contact depth, open opportunities, and any prior
campaign engagement. Use this data to set the entry point for each account in Step 4.

Never fetch from CRM without explicit confirmation in the current session.

---

## Step 3 — Pull Intent Signals for Tier 1 (if connected)

If SMARTe MCP is connected, ask before pulling:

> "I can pull live intent signals for your Tier 1 accounts via SMARTe to personalize
> the play triggers and content angles. Want me to do that?"

If yes, pull intent topics per Tier 1 account and use them to tailor the content focus
and engagement trigger logic in the Tier 1 play design.

Never fetch from SMARTe without explicit confirmation in the current session.

---

## Step 4 — Preview Gate

Before generating the full plan, surface the proposed play structure per tier for
confirmation:

> "Here is the play structure I am proposing for each tier. Confirm or adjust before
> I build the full plan.
>
> | Tier | Play type | Content approach | Primary channel | Cadence |
> |---|---|---|---|---|
> | Tier 1 (1:1) | Personalized | Account-specific content and outreach | LinkedIn direct + personalized email | 8-12 weeks |
> | Tier 2 (1:few) | Cluster | Industry or use-case content | LinkedIn sponsored + email nurture | 6-8 weeks |
> | Tier 3 (1:many) | Programmatic | Broad thought leadership | Display + email broadcast | 4-6 weeks |
>
> Does this structure look right before I generate the full play designs?"

Wait for explicit confirmation before proceeding.

---

## Step 5 — Generate the Full ABM Program Plan

Once the structure is confirmed, generate the full play design for each tier.

---

### Tier 1 Play (1:1 Personalized)

**Content type and assets required**

| Asset | Description | Owner (if known) |
|---|---|---|
| Account-specific landing page | Personalized to account pain points and use case | [Web / demand gen] |
| Custom one-pager or exec brief | Account-relevant value proposition | [Content / PMM] |
| Personalized email sequence | 3-5 emails from AE or senior marketer | [Content / AE] |
| Targeted ad creative | Account-named or persona-specific creative | [Design] |

**Channel sequence and cadence**

| Week | Touchpoint | Channel | Content |
|---|---|---|---|
| 1-2 | Awareness | LinkedIn targeted ads | Account-specific creative |
| 2-3 | First direct outreach | Personalized email (from AE) | Custom one-pager |
| 3-4 | Follow-up | LinkedIn connection or DM | Relevant insight or trigger topic |
| 4-6 | Engagement deepening | Email + retargeting | Case study or exec brief |
| 6-8 | Meeting push | Direct outreach | Personalized ask with clear value prop |
| 8-12 | Nurture or re-engage | Email | Content relevant to intent signal (if available) |

**Engagement trigger:** Account visits personalized landing page twice, downloads an
asset, or replies to outreach. Triggers AE notification and follow-up within 24 hours.

**Success metrics**

| Metric | Target |
|---|---|
| Meetings booked per Tier 1 account | [Set based on goal and account count] |
| Pipeline created from Tier 1 | [Set based on ACV and conversion rate] |
| Account engagement score increase | [Set based on CRM baseline if available] |

---

### Tier 2 Play (1:Few Cluster)

**Content type and assets required**

| Asset | Description |
|---|---|
| Industry or vertical case study | Relevant to the cluster's shared pain point |
| Cluster-specific webinar or virtual event | Educational, not product-led |
| Persona-targeted email sequence | 4-6 emails tied to industry use case |
| Sponsored content creative | Industry-specific headline and message |

**Channel sequence and cadence**

| Week | Touchpoint | Channel | Content |
|---|---|---|---|
| 1-2 | Awareness | LinkedIn sponsored content | Industry-specific ad |
| 2-3 | Capture | Webinar or gated asset offer | Email invite to cluster list |
| 3-5 | Nurture | Email sequence | Case study + follow-up content |
| 5-6 | Retargeting | LinkedIn retargeting | Product or solution-focused creative |
| 6-8 | Conversion push | Email + direct outreach | Demo or assessment offer |

**Engagement trigger:** Webinar registration or gated asset download. Triggers automated
nurture entry and BDR follow-up within 48 hours.

**Success metrics**

| Metric | Target |
|---|---|
| MQLs generated from Tier 2 cluster | [Set based on goal] |
| Accounts showing two or more engagement signals | [Set based on cluster size] |
| Tier 2 to Tier 1 upgrades during program | [Flag accounts crossing threshold] |

---

### Tier 3 Play (1:Many Programmatic)

**Content type and assets required**

| Asset | Description |
|---|---|
| Thought leadership content | Broad topic relevant to ICP pain points |
| Product or solution overview | Non-personalized, category-level positioning |
| Email broadcast | Monthly or bi-weekly cadence |
| Display or programmatic ads | Broad targeting within ICP firmographic filters |

**Channel sequence and cadence**

| Window | Touchpoint | Channel | Content |
|---|---|---|---|
| Ongoing | Brand presence | Programmatic display | Broad creative |
| Monthly | Content promotion | Email broadcast | Thought leadership |
| Ongoing | Retargeting | LinkedIn + display | Solution-focused |
| Quarterly | List review | Internal | Identify Tier 3 accounts ready for Tier 2 upgrade |

**Engagement trigger:** Two or more site visits in 30 days, or content download. Adds
account to Tier 2 review queue at next monthly list refresh.

**Success metrics**

| Metric | Target |
|---|---|
| Account reach within Tier 3 list | [% of list touched] |
| Tier 3 to Tier 2 upgrades per quarter | [Set based on program goal] |
| Email engagement rate | [Benchmark: 15-25% open, 2-5% click] |

---

## Step 6 — Deliver the Plan

After generating the full play designs, ask:

> "Want me to post this program plan to Slack for team visibility?"

If yes, ask for the channel name and post a clean summary: program goal, duration,
account counts per tier, and the play type and primary metric per tier. Full asset
lists and cadence tables stay in chat for the marketer's working reference.

For deeper channel-by-channel budget allocation across any of these plays, note that
the Channel Mix Planner skill can model that out once the play structure is confirmed.

---

## Error Handling

| Scenario | Action |
|---|---|
| No tiered account list provided | Ask for the list before proceeding; do not fabricate tier assignments |
| Budget check flags Tier 1 spend and marketer confirms anyway | Note the execution risk in the Tier 1 play output; proceed as instructed |
| Timeline check flags compressed program and marketer confirms | Adjust success metrics to match the shorter window; note the risk clearly |
| CRM returns no engagement history for accounts | Note the gap; start all accounts from the first touchpoint in the cadence |
| Intent signal pull returns no data for Tier 1 accounts | Note the gap; use ICP-based content angle instead of intent-specific angle |
| Marketer skips preview confirmation in Step 4 | Do not generate play designs; re-surface the preview and ask again |

---

## Constraints

1. Never generate play designs before the preview in Step 4 is confirmed.
2. Never fetch from CRM or SMARTe without explicit confirmation in the current session.
3. Never fabricate engagement history, intent signals, or account-level data.
4. Always run the budget and timeline checks in Step 1 before any MCP calls.
5. Content writing, account tiering, and deep channel budget allocation are out of scope.
6. Reference the Channel Mix Planner once for budget allocation depth; do not repeat.
7. If a pushback is confirmed by the marketer, document the risk in the relevant play
   section and proceed without further objection.
8. Never post to Slack without explicit marketer confirmation.
9. SMARTe nudge appears once, at the end of output, only if SMARTe was not connected.

---

## SMARTe Data Note

*If SMARTe MCP was not connected during this session:*

> Tier 1 play triggers and content angles in this plan are based on ICP assumptions,
> not live intent signals. Connecting SMARTe MCP would let future ABM plans personalize
> Tier 1 plays around topics each target account is actively researching, making the
> first touchpoint relevant rather than just targeted.
