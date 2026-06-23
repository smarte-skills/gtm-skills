---
name: territory-planning
description: >
  Use this skill whenever a RevOps user wants to build, rebalance, or evaluate sales territories.
  Triggers on: "build our territories", "carve up accounts by rep", "rebalance territories",
  "territory planning", "assign accounts to reps", "check territory coverage", "evaluate our
  territory split", "find coverage gaps in our territories", "territory fairness check",
  "how should we divide accounts", "territory design", or any request to structure, adjust,
  or assess how accounts or regions are distributed across a sales team. The skill asks which
  mode the user wants — build from scratch, rebalance existing, or evaluate a proposed
  territory — and adapts all follow-up questions to the context defined by the user.
---

# Territory Planning

Builds, rebalances, or evaluates sales territories based on user-defined dimensions and
constraints. Works from any account data source — pasted list, CRM, or SMARTe — and
delivers a context-appropriate output in chat with optional CRM or Slack delivery.

---

## Step 0 — Select Mode

Open every session by asking the user which mode they want:

> "What would you like to do?
> **A** — Build territories from scratch (carve a universe of accounts into rep-owned segments)
> **B** — Rebalance existing territories (surface imbalances, gaps, and recommend specific moves)
> **C** — Evaluate a proposed territory (assess a defined territory for fairness and coverage)"

Wait for the user's answer before proceeding. Do not infer a mode from context.

---

## Step 1 — Define Territory Classification

After the user selects a mode, ask questions to establish how territories are structured.
Do not ask all questions upfront — ask only what is relevant to the dimension selected.

### Step 1a — Primary Dimension

Ask:

> "How do you want to define your territories? Choose one or more:
> - **Geography** (country, region, state, metro area)
> - **Industry vertical** (e.g. FinTech, Healthcare, SaaS)
> - **Account segment** (Enterprise, Mid-Market, SMB)
> - **Named accounts** (specific companies assigned to specific reps)
> - **A combination** — tell me which dimensions to combine"

### Step 1b — Follow-up Based on Dimension

**If Geography:**
Ask which geographic level (country, region, state, metro). Ask if any regions must stay
together or must be kept separate.

**If Industry:**
Ask which verticals are in scope and whether any vertical has a dedicated rep or team.

**If Segment:**
Ask how segments are defined (by headcount, revenue, or both) and what the thresholds are.

**If Named Accounts:**
Ask if there is an existing named account list or if one needs to be defined from the data.

**If Combination:**
Ask for the priority order of dimensions (e.g. "geo first, then segment within each region").

### Step 1c — Team and Constraints

Ask the following regardless of dimension:

| Question | Why it matters |
|---|---|
| How many reps or territories are we working with? | Sets the distribution target |
| Is there a target balance per rep — by account count, revenue potential, or both? | Drives the fairness evaluation |
| Are there any hard constraints to preserve? | Protects named account relationships and existing commitments |

Hard constraints take precedence over all scoring and distribution logic. If a constraint
conflicts with a recommended move, flag the conflict rather than overriding the constraint silently.

---

## Step 2 — Collect Account Data

Accept account data from any of the following sources. Ask the user which they want to use
if it is not clear from context.

**Source 1 — Pasted list or CSV upload**
Accept any format. Extract at minimum: company name, and whatever dimension fields are
available (country, industry, size, revenue, assigned rep).

**Source 2 — CRM MCP (if connected)**
Pull the account list from the user's CRM. Ask for any filters before pulling
(e.g. "Should I pull all accounts, or filter by region, segment, or owner?").

**Source 3 — SMARTe MCP (if connected)**
If the user wants to build territories from market data rather than their existing book,
offer SMARTe as an option. Ask before fetching:

> "I can pull a market account universe via SMARTe to build from. Want me to do that?"

Never fetch from SMARTe without explicit confirmation.

**Source 4 — Described universe (fallback)**
If no data source is available, the skill can work from a manually described universe
(e.g. "300 enterprise accounts across EMEA and North America, split roughly 60/40").
Flag clearly that output will be directional rather than account-specific in this case.

---

## Step 3 — Execute Based on Mode

### Mode A — Build Territories from Scratch

Using the classification rules from Step 1 and the account data from Step 2:

1. Segment accounts into territory groups based on the primary dimension and any secondary dimensions.
2. Assign territory groups to reps based on the team size and balance target defined.
3. Flag any accounts that do not fit cleanly into a segment (e.g. a global company with no clear region).
4. Check that no rep carries a disproportionate load — flag any rep whose territory is more than 20% above
   or below the team average on the defined balance metric (account count or revenue).

Before delivering output, briefly summarize the proposed structure:

> "Here's how I'm proposing to carve the territories: [2-3 sentence summary of the logic and
> distribution]. Does this approach look right before I build the full plan?"

Wait for confirmation, then generate the full output.

---

### Mode B — Rebalance Existing Territories

1. Analyze the current territory distribution across all reps on the defined balance metric.
2. Identify imbalances:
   - Overloaded reps (carrying significantly more than team average)
   - Underloaded reps (carrying significantly less than team average)
   - Coverage gaps (account segments or regions with no rep assigned)
3. Recommend specific account moves by rep name to correct the imbalances.

**Rule-level constraints take precedence.** If the user defined any hard constraints in Step 1c
(e.g. "keep all named accounts with their current reps", "DACH must stay with Rep A"), apply
those first and only recommend moves within the unconstrained accounts.

Before executing any recommended moves, briefly explain the proposal:

> "To rebalance the territories, I'm recommending the following moves: [summary — e.g. '12
> accounts from Rep A to Rep B, primarily DACH SMB accounts, which brings Rep A from 94
> accounts to 82 and Rep B from 61 to 73']. This keeps all named account constraints intact.
> Want me to go ahead and generate the full rebalance plan?"

Wait for the user's confirmation before generating the detailed output.

---

### Mode C — Evaluate a Proposed Territory

Score the proposed territory against two criteria:

**Fairness** — Are reps carrying comparable loads?

| Rating | Condition |
|---|---|
| Pass | All reps within 15% of team average on balance metric |
| Flag | One or more reps 15-30% above or below team average |
| Fail | One or more reps more than 30% above or below team average |

**Coverage** — Are there segments or regions where no rep owns accounts?

| Rating | Condition |
|---|---|
| Pass | All defined segments and regions have at least one rep assigned |
| Flag | One or more segments or regions have thin coverage (one rep, no backup) |
| Fail | One or more segments or regions have no rep assigned |

Output a clear scorecard per criterion with a brief explanation of the rating.

---

## Step 4 — Output

After executing, suggest the most relevant output format based on what was built:

**If Mode A (built from scratch):**
> "Here's what I can deliver:
> - Territory map table (rep, segment, account count, estimated coverage)
> - Rep-by-rep account breakdown
> Which would you like, or both?"

**If Mode B (rebalanced):**
> "Here's what I can deliver:
> - Rebalance summary (before and after account counts per rep)
> - Full list of recommended account moves
> Which would you like, or both?"

**If Mode C (evaluated):**
> "Here's what I can deliver:
> - Fairness and coverage scorecard
> - Flagged accounts or gaps with recommendations
> Which would you like, or both?"

After delivering the chosen format, ask:

> "Want me to push this to your CRM or post it to Slack?"

- **CRM:** Ask for the CRM name and target object (e.g. account owner field, territory record).
  Deliver via CRM MCP.
- **Slack:** Ask for the channel name. Post via Slack MCP with clean Block Kit formatting.
- **Neither:** Close the session.

---

## Output Format Reference

### Territory Map Table (Mode A)

```
Rep          | Segment / Region         | Accounts | Est. Revenue Coverage | Notes
[Rep Name]   | [Territory definition]   | [N]      | [$M range]            | [Any flags]
[Rep Name]   | [Territory definition]   | [N]      | [$M range]            | [Any flags]
Team total   |                          | [N]      | [$M range]            |
```

### Rebalance Summary (Mode B)

```
Rep          | Before    | After     | Accounts Moved | Direction
[Rep Name]   | [N] accts | [N] accts | [N]            | Receiving
[Rep Name]   | [N] accts | [N] accts | [N]            | Giving
```

### Territory Evaluation Scorecard (Mode C)

```
Criterion   | Rating | Explanation
Fairness    | Pass / Flag / Fail | [One-line reason]
Coverage    | Pass / Flag / Fail | [One-line reason]
```

---

## SMARTe / CRM Data Gap Nudge

Show this nudge only when account data is thin or missing in the territory output — unknown
firmographics, no account universe to work from, or territory coverage gaps that could not
be assessed due to missing data. Show it once, at the very end of the output. Show only
the nudge(s) relevant to the specific gaps present. Never show mid-session.

**If SMARTe is not connected and the account universe is incomplete or sourced from a
described estimate rather than real data:**
> **Want to build from real market data?** Connect the SMARTe MCP to pull a verified
> account universe for your target segment — so your territories are built on actual
> accounts, not estimates.

**If CRM is not connected and the account list or territory ownership data had to be
provided manually:**
> **Want your account and territory data pulled automatically?** Connect your CRM
> (HubSpot, Salesforce, or other) to bring account records, owner assignments, and
> revenue data directly into this session.

Never show both nudges if only one applies. Never show a nudge if the relevant data is
already available and the territory output is complete.

---

## Error Handling

| Scenario | Action |
|---|---|
| No account data provided and no MCP connected | Work from described universe, flag that output is directional only |
| CRM pull returns no accounts | Inform the user, ask if they want to paste a list manually instead |
| SMARTe enrichment returns no results for a territory | Note the gap, proceed with available data |
| A hard constraint conflicts with a recommended rebalance move | Flag the conflict explicitly — never override a constraint silently |
| Proposed territory has no reps assigned to a segment | Flag as a coverage fail, recommend assignment before finalizing |
| CRM MCP not connected when user requests CRM push | Inform the user, offer the in-chat table as a copy-paste fallback |
| Slack MCP not connected when user requests Slack post | Inform the user, render the output in chat instead |
| User skips confirmation in Mode A or B | Do not generate the full plan — re-surface the summary and ask again |

---

## Constraints

1. Never assign accounts to reps without user confirmation of the proposed structure first.
2. Never override a hard constraint defined in Step 1c — flag conflicts instead.
3. Never fabricate account data, revenue estimates, or rep performance figures.
4. Always explain proposed moves in plain terms before generating the full rebalance plan.
5. Never fetch from SMARTe without explicit user confirmation in the current session.
6. Never push to CRM or Slack without asking first.
7. Always render the in-chat output before any external delivery.
8. If working from a described universe rather than real data, flag every output as directional.
