---
name: outbound-coverage-gap-finder
description: >
  Use this skill whenever a marketer or revenue leader needs to audit outbound coverage
  across their ICP account universe. Triggers on: "where are we not covering our ICP",
  "which accounts have we never touched", "outbound coverage audit", "find our coverage
  gaps", "which accounts are going stale", "are we reaching the right personas", "how
  much of our ICP is being worked", "coverage gap report", "which reps have thin
  coverage", "which accounts need re-engagement", or any request to assess how well
  the outbound motion is covering the target account list. Requires CRM MCP for
  account and activity data. Uses SMARTe MCP for intent signal prioritisation.
---

# Outbound Coverage Gap Finder

Audits outbound coverage across the ICP account universe. Classifies accounts as
active, stale, or uncovered. Identifies persona gaps and channel-thin coverage.
Prioritises uncovered and stale accounts by intent signal and account size. Delivers
a coverage summary, prioritised gap list, persona analysis, rep heat map, and
recommended actions.

---

## Step 0 — Collect Inputs

Ask the marketer for the following before proceeding:

> "To run the coverage gap analysis I need a few inputs:
> 1. What is the ICP account universe? (I can pull from CRM, or you can paste a list
>    or confirm a segment name)
> 2. What counts as actively covered? (e.g. at least 2 touches in the last 60 days)
> 3. What counts as stale? (e.g. last touch between 60 and 180 days ago)
> 4. Who is the target persona for this market? (seniority level and function, so I
>    can identify persona gaps)
> 5. Is territory or rep assignment data available in your CRM? (needed for the
>    coverage heat map)"

If the marketer does not specify a coverage definition, use these defaults and state
them clearly before proceeding:

> "No coverage definition was provided. I will use: active = 2 or more touches in the
> last 60 days; stale = last touch between 61 and 180 days ago; uncovered = no touch
> ever, or last touch more than 180 days ago. Adjust if needed before I pull data."

---

## Step 1 — Pull Account and Activity Data

**If CRM MCP is connected**, ask before pulling:

> "I will pull the following from your CRM: the ICP account list, outbound activity
> logs per account (emails sent, calls logged, LinkedIn touches), the contact persona
> for each activity, and rep or territory assignments. Ready to proceed?"

Pull on confirmation. Extract per account:
- Last activity date and total touch count in the recency window
- Activity types used (email, call, LinkedIn, other)
- Contact title, seniority, and function for each activity
- Assigned rep or territory

Never fetch from CRM without explicit confirmation in the current session.

**If CRM MCP is not connected**, ask the marketer to provide the data manually:

> "CRM is not connected. You can still run this analysis by providing:
> 1. Your ICP account list (paste company names or upload a CSV)
> 2. An activity export from your CRM or sequencing tool (Outreach, Salesloft,
>    HubSpot, Apollo) as a CSV with columns for: company, last touch date, touch
>    count, channel, and contact title where available
>
> Paste or upload what you have and I will work with it. Missing columns will limit
> the corresponding gap type and will be flagged clearly in the output."

Accept partial data. Flag which gap types cannot be fully assessed due to missing
columns, but run all checks possible with what is provided.

---

## Step 2 — Preview Gate

Before running the gap analysis, confirm the universe and definition:

> "Here is what I am working with:
>
> Account universe: [N] accounts from [source]
> Active coverage definition: [stated or default]
> Stale definition: [stated or default]
> Target persona: [seniority + function stated by marketer]
> Territory data available: [yes / no]
>
> Confirm to proceed with the analysis?"

Wait for confirmation before running Step 3 onwards.

---

## Step 3 — SMARTe Intent Signals (optional)

If SMARTe MCP is connected, ask before pulling:

> "I can pull live intent signals for uncovered and stale accounts via SMARTe to
> prioritise which gaps to fill first. Accounts showing active buying signals on
> relevant topics move to the top of the gap list. Want me to do that?"

If yes, pull intent signal status for uncovered and stale accounts and use it to
set priority tier in the gap list output.

Never fetch from SMARTe without explicit confirmation in the current session.

---

## Step 4 — Run Gap Analysis

Classify every account in the universe across the four gap types.

### Classification

| Coverage status | Definition |
|---|---|
| Active | Meets the marketer-defined touch count and recency threshold |
| Stale | Last touch falls within the stale window; not currently active |
| Uncovered | No touch ever recorded, or last touch outside the stale window |

### Gap Type 1: Uncovered Accounts
Accounts with no outbound activity ever or last touch more than the defined stale
window. These are the highest-priority gaps for net-new coverage.

### Gap Type 2: Stale Accounts
Accounts that were worked at some point but have had no activity within the defined
recency window. Flag the time since last touch for each.

### Gap Type 3: Wrong Persona Coverage
For all accounts with activity, compare the contact titles against the target persona
definition. Flag any account where:
- All touches went to seniority levels below the target (e.g. individual contributors
  when target is VP and above)
- All touches went to the wrong function (e.g. IT contacts when target is Finance)
- No economic buyer or decision-maker has been reached

### Gap Type 4: Channel-Thin Coverage
For all accounts with activity, check the channel mix used. Flag any account where:
- Only one channel has been used across all touches
- Email is the only channel with no calls or LinkedIn activity
- All touches are automated sequence emails with no human-initiated contact

---

## Step 5 — Output

### Coverage Summary

> **ICP universe:** [N] accounts
>
> | Status | Count | % of universe |
> |---|---|---|
> | Active coverage | [N] | [%] |
> | Stale coverage | [N] | [%] |
> | Uncovered | [N] | [%] |
> | Wrong persona | [N] | [%] |
> | Channel-thin | [N] | [%] |
>
> Note: wrong persona and channel-thin counts are subsets of active or stale accounts.
> Total coverage gaps (stale + uncovered): [N] accounts / [%] of universe.

---

### Prioritised Gap List

Present uncovered and stale accounts in priority order. Priority tier is set by:

| Priority | Criteria |
|---|---|
| P1 | Uncovered + active intent signal |
| P2 | Stale + active intent signal |
| P3 | Uncovered + high ICP fit or large account size |
| P4 | Stale + high ICP fit or large account size |
| P5 | Uncovered or stale with no intent signal and average fit |

For each account in the gap list:

```
Account | Status | Last touch | Priority tier | Intent signal | Recommended action
```

Cap the in-chat display at the top 25 accounts. Offer to output the full list as a
file for lists exceeding that.

---

### Persona Gap Analysis

> **Accounts with wrong persona coverage:** [N]
>
> | Pattern | Account count | Example accounts |
> |---|---|---|
> | Only individual contributors reached | [N] | [examples] |
> | Wrong function (e.g. IT vs Finance) | [N] | [examples] |
> | No economic buyer reached | [N] | [examples] |
>
> These accounts have activity but the right person has not been engaged. Outreach
> has not been wasted, but coverage is incomplete until the target persona is reached.

---

### Rep Coverage Heat Map

Shown only if territory or rep assignment data was available in the CRM.

| Rep | Assigned accounts | Active | Stale | Uncovered | Coverage rate |
|---|---|---|---|---|---|
| [Rep name] | [N] | [N] | [N] | [N] | [%] |
| Team average | | | | | [%] |

Flag reps whose coverage rate falls more than 20 percentage points below the team
average. Frame this as a coverage visibility finding, not a performance assessment.

---

### Recommended Actions

Organise recommendations by gap type and priority:

**Immediate (P1 and P2 accounts):**
[List specific accounts or account clusters with intent signals that need outreach
this week. State the gap type and the recommended first action per cluster.]

**Short-term (P3 and P4 accounts):**
[Accounts with strong ICP fit but no intent signal. Recommend adding to active
sequences or assigning to rep coverage.]

**Persona re-engagement:**
[Accounts where the wrong persona was reached. Recommend identifying the target
contact and initiating a separate outreach track.]

**Channel diversification:**
[Accounts with email-only or single-channel coverage. Recommend adding a call or
LinkedIn touch to existing sequences.]

---

## Error Handling

| Scenario | Action |
|---|---|
| CRM not connected | Ask for a manual account list and activity export; flag which gap types are limited by missing columns |
| CRM returns accounts with no activity data | Classify as uncovered; note that activity logging may be incomplete |
| Target persona not defined by marketer | Ask before running persona gap analysis; do not infer the target persona |
| Territory or rep data not in CRM | Skip the heat map section; note the gap and suggest adding rep assignments |
| SMARTe returns no intent signals for uncovered accounts | Note the result; rank uncovered accounts by account size instead |
| Marketer skips preview confirmation in Step 2 | Do not run the analysis; re-surface the preview and ask again |

---

## Constraints

1. Never run the gap analysis before the preview in Step 2 is confirmed.
2. Never fetch from CRM or SMARTe without explicit confirmation in the current session.
3. When working from a manual export, flag every gap type that could not be fully
   assessed due to missing columns before delivering the output.
4. The rep heat map is a coverage visibility tool only; never frame low coverage
   rates as individual performance failures.
5. Persona gap findings apply to contact-level activity data; do not infer persona
   from company name or industry alone.
6. Channel-thin flagging applies only to accounts with existing activity; uncovered
   accounts are not channel-thin, they are uncovered.
7. Cap in-chat gap list at 25 accounts; offer a full file output for larger lists.
8. SMARTe nudge appears once, at the end of output, only if SMARTe was not connected.

---

## SMARTe Data Note

*If SMARTe MCP was not connected during this session:*

> The gap list in this report is sorted by account size rather than buying intent.
> Connecting SMARTe MCP would re-sort the list by live intent signals, putting accounts
> that are actively researching relevant topics at the top regardless of size, so
> outreach effort goes to accounts most likely to be in-market right now.
