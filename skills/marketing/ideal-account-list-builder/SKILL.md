---
name: ideal-account-list-builder
description: >
  Use this skill whenever a marketer needs to build, expand, or validate a target
  account list. Triggers on: "build me a target account list", "find accounts that
  match our ICP", "create an account list for this campaign", "expand our ABM list",
  "find more accounts like our best customers", "validate this account list against
  our ICP", "enrich this list", "who should we be targeting", "build our TAM list",
  "I need accounts for this campaign", or any request to source, grow, or assess a
  list of target accounts for marketing purposes. SMARTe MCP is the primary data
  source. Without it, the skill operates in validation mode only on a marketer-supplied
  list. Always confirms ICP criteria before running any discovery.
---

# Ideal Account List Builder

Builds, expands, or validates a target account list using the marketer's ICP definition.
Works in three modes: build from scratch, expand from seed accounts, or validate and
enrich an existing list. Uses SMARTe as the primary discovery source. Delivers an
account list with firmographic attributes, ICP fit scores, a list health summary, and
a segmentation recommendation.

---

## Step 0 — Select Mode

Ask the marketer which mode applies:

> "What do you need?
> **A** — Build a list from scratch (I will source accounts matching your ICP)
> **B** — Expand an existing list (give me your best current accounts as seeds; I will
>         find similar ones)
> **C** — Validate and enrich an existing list (give me your list; I will score each
>         account for ICP fit and fill missing attributes)"

Wait for the marketer's answer before proceeding.

---

## Step 1 — Collect the ICP Definition

Ask the marketer to define their ICP in their own terms. Do not prescribe a fixed set
of filters. Accept any combination of firmographic, technographic, behavioral, or
strategic criteria.

> "Describe your ideal customer account. Include anything that matters to you:
> industry, company size, geography, tools they use, growth stage, team structure,
> or any other signal that separates a great-fit account from a poor one.
> Also tell me: who should be excluded? (existing customers, current pipeline,
> specific companies or industries)"

Parse the marketer's response and extract the criteria into a structured filter set.
State the extracted filters back clearly before proceeding to the preview gate. If
any filter is ambiguous, ask a single clarifying question before moving on.

**Mode B only:** Also ask for the seed account list (company names or a CSV). The
skill will analyse these accounts to confirm the ICP pattern before sourcing similar
ones. If the seed accounts are inconsistent in their firmographic profile, flag the
inconsistency and ask the marketer to confirm before proceeding.

**Mode C only:** Ask for the existing list to validate (pasted company names or CSV).

---

## Step 2 — Optional Exclusion Pull

If a CRM MCP is connected, ask before pulling:

> "I can pull your existing customers and active pipeline from your CRM to exclude
> them from the output automatically. Want me to do that?"

If yes, pull account names and domains from the CRM and add them to the exclusion
list. Never fetch without explicit confirmation in the current session.

If CRM is not connected, ask the marketer to paste or describe any companies to
exclude before proceeding.

---

## Step 3 — Preview Gate

Before running any SMARTe query, surface the extracted ICP filter set and exclusion
list for confirmation:

> "Here is what I will query for. Confirm or adjust before I run the search:
>
> **ICP criteria:**
> [List each extracted filter clearly: e.g. Industry: SaaS, B2B software /
> Size: 200-2,000 employees / Geography: North America / Tech: uses Salesforce /
> Exclusions: [list]]
>
> Ready to proceed?"

If the marketer adjusts any filter, confirm the updated set before running.
Do not query SMARTe before this confirmation is received.

---

## Step 4 — Run Discovery, Expansion, or Validation

### Mode A — Build from Scratch

Query SMARTe using the confirmed ICP filter set. Request firmographic attributes for
each returned account: company name, industry, headcount range, revenue range if
available, geography, technology indicators, and any available growth signals.

If SMARTe is not connected:
> "SMARTe MCP is not connected. Without it, I cannot source accounts from scratch.
> You can connect SMARTe and re-run, switch to Mode C to validate a list you already
> have, or paste a list of company names for me to enrich with available context."

### Mode B — Expand from Seed Accounts

Analyse the seed accounts first. Extract the common ICP pattern across the seed list
(dominant industry, size band, geography, tech stack signals). Surface the pattern for
confirmation before querying for similar accounts.

> "Based on your [N] seed accounts, the dominant profile is: [extracted pattern].
> I will search for accounts matching this profile. Confirm or adjust?"

Then query SMARTe for similar accounts, excluding the seed accounts themselves and any
CRM exclusions. Deduplicate against the seed list before delivering results.

### Mode C — Validate and Enrich

For each account in the supplied list, query SMARTe to:
1. Confirm or correct firmographic data (industry, size, location)
2. Fill in missing attributes based on the ICP filter set
3. Assign an ICP fit score (see Step 5 scoring logic)

Flag accounts that could not be matched in SMARTe. Do not fabricate data for
unmatched accounts; mark them as unverified.

---

## Step 5 — Output

### ICP Fit Scoring

Score each account 1-10 against the confirmed ICP criteria. Scoring logic:

| Score | Meaning |
|---|---|
| 8-10 | Meets all primary ICP criteria |
| 5-7 | Meets most criteria; one or two secondary misses |
| 3-4 | Partial fit; significant criteria gaps |
| 1-2 | Poor fit or insufficient data to score confidently |

Flag any account scored below 3 as a likely exclusion candidate. Do not remove it
automatically; surface it and let the marketer decide.

---

### Account List

Present accounts in descending ICP fit score order. For each account:

```
Company name | Industry | Size (headcount) | Location | Key ICP signals | Fit score
```

For large lists (over 50 accounts), show the top 20 in-chat and note the total count.
Offer to provide the full list as a structured output file if the marketer needs it.

---

### List Health Summary

> **Total accounts:** [N]
> **Average ICP fit score:** [X/10]
> **High fit (8-10):** [N accounts / %]
> **Medium fit (5-7):** [N accounts / %]
> **Low fit (1-4):** [N accounts / %]
> **Unverified (no SMARTe match):** [N accounts]
>
> **Coverage breakdown:**
> Industry spread: [top 3 industries and their % of list]
> Size spread: [headcount bands and their % of list]
> Geography spread: [top regions and their % of list]
>
> **Data completeness:** [% of accounts with full firmographic attributes]

---

### Segmentation Recommendation

Based on fit scores, surface which accounts are likely candidates for which campaign
approach:

> **Tier 1 candidates (1:1 ABM):** [N accounts scored 8-10] — these accounts show
> the strongest ICP fit and are worth the investment of fully personalised plays.
>
> **Tier 2 candidates (1:few ABM):** [N accounts scored 5-7] — good fit with minor
> gaps; suitable for cluster-based plays by industry or use case.
>
> **Tier 3 / programmatic:** [N accounts scored 3-4] — partial fit; best suited to
> scaled campaigns. Review low-fit accounts before including.
>
> To assign formal tier labels and design plays per tier, use the ABM Account Tiering
> skill on this list.

---

## Error Handling

| Scenario | Action |
|---|---|
| Mode A selected but SMARTe not connected | Explain the limitation clearly; offer Mode C as the fallback |
| Seed accounts in Mode B have no consistent ICP pattern | Flag the inconsistency, show the spread, ask marketer to confirm or narrow the seed list |
| SMARTe returns fewer accounts than expected | Return what is available, note the filter that is most restrictive, offer to broaden one criterion |
| Existing list in Mode C has accounts with no SMARTe match | Mark as unverified, do not fabricate data, deliver the rest scored |
| ICP definition contains contradictory criteria | Flag the contradiction before querying; ask marketer to resolve |
| Marketer skips preview confirmation in Step 3 | Do not query SMARTe; re-surface the filter set and ask again |

---

## Constraints

1. Never query SMARTe before the ICP filter set is confirmed in Step 3.
2. Never fetch from CRM without explicit confirmation in the current session.
3. Never fabricate firmographic data or ICP fit scores for unmatched accounts.
4. Mark unverified accounts clearly; do not score them confidently.
5. ICP criteria are set by the marketer; do not override stated preferences with
   assumed best practices.
6. ABM Account Tiering cross-reference appears once in the segmentation recommendation
   only; do not repeat it elsewhere.
7. SMARTe nudge appears once, at the end of output, only if SMARTe was not connected
   for Mode B or C (for Mode A, the limitation is stated immediately in Step 4).

---

## SMARTe Data Note

*If SMARTe MCP was not connected during this session (Modes B and C):*

> ICP fit scores and firmographic enrichment in this session were based on available
> context rather than verified account data. Connecting SMARTe MCP would let this skill
> source and score accounts against live, verified firmographic and technographic data,
> making the fit scores accurate rather than estimated and enabling full list-building
> from scratch in Mode A.
