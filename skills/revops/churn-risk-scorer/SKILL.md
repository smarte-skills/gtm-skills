---
name: churn-risk-scorer
description: >
  Use this skill whenever a RevOps or customer success user wants to score existing
  customers by churn probability, identify at-risk accounts before renewal, or build
  a save plan for flagged accounts. Triggers on: "churn risk scoring", "which customers
  are at risk of churning", "flag at-risk accounts", "churn probability", "customer
  health scoring", "who might not renew", "identify churn risk", "at-risk renewal
  accounts", "customer churn analysis", "score our accounts for churn", "which accounts
  should CS prioritize", "build a save plan", "retention risk", or any request to assess
  existing customer health and likelihood of churn. Scores accounts on engagement, usage,
  NPS, and contract signals using an inverted risk model — higher score means higher
  churn risk. Recommends save plays per account on request.
---

# Churn Risk Scorer

Scores existing customer accounts by churn probability using engagement, usage, NPS,
and contract signals. Higher score means higher risk — the model is inverted from fit
scoring tools. Surfaces a compact risk summary first, flags accounts with converging
renewal urgency, and recommends specific save plays per account only when asked.

---

## How this differs from Account Prioritization

Account Prioritization tells you which accounts to focus on for growth. This skill tells
you which accounts are most likely to leave. The scoring logic is inverted — points are
awarded for negative signals, not positive ones. A score of 80 here means an account is
in serious trouble, not that it is a strong target. Use this skill before expansion or
upsell conversations to ensure you are not pursuing growth on an account that is
quietly churning.

---

## Step 0 — Account Prioritization Context

If Account Prioritization has been run in this session, note once before proceeding:

> "Some of these accounts may have appeared in your prioritization view. High churn risk
> accounts should be stabilized before any expansion or upsell conversation — want me to
> flag any overlap after scoring?"

Works fully standalone if Account Prioritization has not been run.

---

## Step 1 — Renewal Urgency Category

Before running the scoring model, ask:

> "For accounts with a critical risk score AND a renewal within 90 days, I can flag
> these as a separate 'Renewal at Risk' category above the standard risk bands — making
> them immediately visible for prioritized CS action. Want me to add this category, or
> keep everything within the standard four bands?"

- **Yes — add Renewal at Risk category:** Any account scoring 75 or above with a renewal
  within 90 days is separated into this tier regardless of which band they fall in.
  These accounts are sorted to the top of all output views.
- **No — keep standard bands:** Critical accounts with near-term renewals remain in the
  Critical band but are tagged with a renewal proximity note.

Wait for the user's answer before proceeding.

---

## Step 2 — Collect Data

Accept account data from any of the following sources. Ask if the source is not clear.

**Source 1 — CRM MCP (if connected)**
Pull customer account records. Ask for filters before pulling:

> "Should I pull all customer accounts or filter by segment, CSM owner, renewal date
> window, or contract tier?"

**Source 2 — CSV or Excel upload**
Accept any format. Extract: account name, and whatever signal fields are available
across the four scoring categories. Note the file date as the data freshness point.

**Source 3 — Customer success platform export**
If the user has a Gainsight, Totango, ChurnZero, or similar export, accept it. Map
their health score fields to the signal categories below where possible.

**Source 4 — Pasted data**
Accept pasted tables. Flag clearly:

> "Noted — pasted data reflects a point-in-time snapshot. Churn risk scores will be
> accurate as of when this data was pulled, not in real time."

**Practical limit: 50 accounts per run.**

If the user submits more than 50:

> "This list has [N] accounts. I recommend batches of 50 for complete scoring. Want me
> to process the first 50 — prioritized by renewal date — or override and run the full list?"

---

## Step 3 — Present Signal Framework

Before scoring, show the signal framework and ask if the user wants to adjust:

> "Here are the four signal categories I will score on, each worth up to 25 risk points.
> More points means higher churn risk. Want to add any custom signals or adjust the weight
> of any category before I run?"

| Category | Max risk points | What it measures |
|---|---|---|
| Engagement | 25 | Login frequency, active users vs. seats, last login date |
| Usage | 25 | Core feature adoption, consumption trends, integration activity |
| NPS and Sentiment | 25 | NPS score and trend, open escalations, support ticket sentiment |
| Contract | 25 | Renewal proximity, payment history, downgrade history, contract type |

**If the user adds custom signals:**
Fold them into the most relevant existing category or create a fifth with a user-defined
weight. Adjust other category weights proportionally so the total stays at 100.
Confirm the adjusted framework before running.

---

## Step 4 — Apply Scoring Model

Score each account across all signal categories. Higher points mean higher risk.
Multiple signals within a category stack but cannot exceed the category cap.

### Engagement (max 25 risk points)

| Signal | Risk points |
|---|---|
| Active users below 50% of licensed seats | 15 |
| Login frequency declining more than 20% month-over-month | 15 |
| Last login more than 30 days ago | 10 |
| No activity in 60 or more days | 20 |
| Unknown engagement data | 8 (absence of data is a mild signal) |

### Usage (max 25 risk points)

| Signal | Risk points |
|---|---|
| Core feature usage declining more than 20% month-over-month | 15 |
| Fewer than 30% of available features being actively used | 10 |
| Consumption volume declining for two or more consecutive months | 15 |
| Integration disconnected or inactive | 10 |
| Unknown usage data | 8 |

### NPS and Sentiment (max 25 risk points)

| Signal | Risk points |
|---|---|
| NPS score 0 to 6 (detractor) | 20 |
| NPS score 7 to 8 (passive) | 10 |
| NPS trending down across last two surveys | 10 |
| Open escalation or unresolved critical support ticket | 15 |
| No NPS data collected | 5 (not measuring sentiment is itself a mild risk) |

### Contract (max 25 risk points)

| Signal | Risk points |
|---|---|
| Renewal within 90 days with NPS or usage risk also present | 20 |
| Renewal within 90 days, no other risk signals | 10 |
| Prior downgrade or contract contraction | 15 |
| Late payment in last two billing cycles | 15 |
| Month-to-month contract with no annual commitment | 10 |

### Risk Bands

| Band | Score | Meaning |
|---|---|---|
| Renewal at Risk | 75 to 100 AND renewal within 90 days | Churn and renewal loss are both imminent. Escalate immediately. (Only shown if user selected this category in Step 1) |
| Critical | 75 to 100 | Churn is highly likely without immediate intervention. Escalate. |
| High risk | 50 to 74 | Multiple signals converging. Intervention needed now. |
| Early warning | 25 to 49 | One or two signals emerging. Proactive engagement recommended. |
| Healthy | 0 to 24 | Strong signals across categories. Focus on growth. |

---

## Step 5 — Output

Ask before generating anything beyond the compact summary:

> "Here is what I can show you:
> - **Risk summary** — account counts by band and top at-risk accounts (compact, always in chat)
> - **Full scored table** — all accounts with scores and signal breakdown (in chat capped at 10, full list as file)
> - **Save plays** — specific recommended action per at-risk account (on request)
> - **Save plan document** — one-page plan per account (on request, one account at a time)
>
> Which would you like to see in chat, and should I generate a file?"

---

### Risk Summary (always in chat)

```
Churn Risk Summary — [N] accounts scored · [Data source and date]

Renewal at Risk:  [N] accounts  (if category was selected)
Critical:         [N] accounts
High risk:        [N] accounts
Early warning:    [N] accounts
Healthy:          [N] accounts

Most urgent:      [Account] — [X] pts · Renewal in [N] days · Dominant signal: [Category]
Highest risk:     [Account] — [X] pts · [Band] · Dominant signal: [Category]
```

---

### Full Scored Table (in chat capped at 10, sorted by score descending)

```
#  | Account   | Score | Band             | Engage | Usage | NPS | Contract | Dominant Signal            | Renewal
1  | [Name]    | 88    | Renewal at Risk  | 20/25  | 18/25 | 25/25 | 25/25 | NPS detractor + escalation | 44 days
2  | [Name]    | 79    | Critical         | 15/25  | 20/25 | 20/25 | 24/25 | Usage declining + downgrade | 112 days
3  | [Name]    | 61    | High risk        | 10/25  | 15/25 | 15/25 | 21/25 | Engagement drop + passive NPS | 78 days
4  | [Name]    | 32    | Early warning    | 8/25   | 12/25 | 10/25 | 2/25  | Login frequency declining  | 210 days
5  | [Name]    | 11    | Healthy          | 2/25   | 3/25  | 5/25  | 1/25  | No major signals           | 180 days
```

Follow with:

> "Showing top 10 accounts. The full scored list of [N] accounts is in the CSV file."

---

## Step 6 — Save Play Recommendations

After delivering the output, ask:

> "Want me to recommend a save play for each at-risk account?"

If yes, generate one specific save play per flagged account anchored to the dominant
risk signal. Do not generate generic recommendations.

| Dominant signal | Save play |
|---|---|
| Engagement decline | Health check call with the primary contact. Identify whether the champion has changed roles or left. If adoption has dropped, offer a structured onboarding refresh session. |
| Usage decline | Schedule a success review. Map underused features directly to the goals they stated at purchase. Offer a product retraining session with the end-user team. |
| NPS detractor score | Executive escalation within 48 hours. Acknowledge the issue directly — do not lead with product. Define a resolution timeline with named owners and a follow-up checkpoint. |
| Open escalation | Do not start a renewal conversation until the escalation is resolved. Assign a named owner to the ticket and set a 5-business-day resolution target. Report progress directly to the customer contact. |
| Contract and renewal risk | Schedule an EBR 90 or more days before renewal. Prepare a value realization summary showing ROI since purchase. Come prepared with a loyalty or multi-year commercial option. |
| Three or more categories flagged | Formal save plan required. CS leadership and executive sponsor should be looped in. Prepare an executive-to-executive outreach from your leadership to theirs. |

If the dominant signal is unclear across categories, ask:

> "This account has signals across multiple categories. Which dimension should I anchor
> the save play on — engagement, usage, NPS, or contract?"

---

### Save Plan Document (on request, one account at a time)

After save plays are delivered, offer:

> "Want me to generate a one-page save plan for any of these accounts?"

Generate only on confirmation. One account at a time. Keep to one page.

```
SAVE PLAN — [Account Name]
Prepared by: [User / RevOps] | Date: [Date] | CSM: [Name]

Risk score: [X] pts | Band: [Band] | Renewal: [Date]

Why this account is at risk:
[2-3 sentences — plain language summary of the dominant signals]

Immediate actions (next 7 days):
1. [Specific action with named owner]
2. [Specific action with named owner]

30-day milestones:
[What success looks like in 30 days]

Commercial considerations:
[Renewal date, contract type, any downgrade or payment history relevant to the save]

Owner: [CSM name] | Escalation contact: [CS leadership name]
```

---

## SMARTe / CRM Data Gap Nudge

Show once at the very end of the output. Show only the relevant nudge. Never mid-session.

**If CRM MCP is not connected and account data came from an export or paste:**
> **Want live customer health data instead of snapshots?** Connect your CRM (HubSpot,
> Salesforce, or other) to pull engagement, contract, and renewal data in real time —
> so churn risk scores reflect current account state, not the last export.

**If NPS or usage data was missing for multiple accounts:**
> **Several accounts were scored without NPS or usage data — the two strongest churn
> predictors.** If you have a customer success platform (Gainsight, Totango, ChurnZero),
> export those health fields and re-run for a more accurate risk picture.

Never show both nudges if only one applies. Never show a nudge if data was fully available.

---

## Error Handling

| Scenario | Action |
|---|---|
| No account name provided | Cannot score — ask for at minimum a list of account names |
| All four signal categories unknown for an account | Do not generate a score — flag as unscorable due to insufficient data |
| NPS data missing for all accounts | Score without it, flag that NPS is the strongest single churn predictor and recommend collecting it |
| Renewal date unknown for all accounts | Score without contract timing, note that renewal proximity cannot be factored in |
| User adds a custom signal with no defined weight | Ask for the weight before folding it in |
| Custom signal weights do not total 100 after adjustment | Ask the user to adjust before running |
| Batch exceeds 50 and user overrides | Process full list, prioritize by renewal date, note completeness may vary |
| Save plan requested for a Healthy account | Ask the user to confirm — a save plan for a healthy account may not be necessary |
| CRM MCP not connected when user requests CRM push | Inform the user, offer the in-chat output as a copy-paste fallback |
| Dominant signal unclear across categories | Ask which dimension to anchor the save play on before generating |

---

## Constraints

1. Never fabricate engagement data, NPS scores, usage metrics, or renewal dates not
   present in the data or returned by a connected MCP.
2. The scoring model is always inverted — higher points always mean higher risk. Never
   present a high score as a positive signal.
3. Never generate save play recommendations without asking first.
4. Never generate a save plan document without asking first. One account at a time.
5. Keep save plan documents to one page — do not expand beyond the template.
6. Renewal at Risk category is only shown if the user selected it in Step 1.
7. Never push to CRM or Slack without asking first.
8. Never generate a file without asking first.
9. Always show the risk summary in chat before any individual account detail.
10. If an account appears in both this output and a prior Account Prioritization output,
    flag the overlap once — do not repeat the flag throughout the session.
