---
name: new-market-entry-briefer
description: >
  Use this skill whenever a marketer needs to research and brief a new market the
  company is considering entering. Triggers on: "we're expanding into [market]",
  "brief me on [new vertical / geo / segment]", "we want to enter [market]",
  "what does our GTM look like for [new market]", "new market research for [geo /
  vertical]", "we're moving upmarket", "we're expanding internationally", "help me
  build a market entry brief", "what would it take to sell to [new persona]", or any
  request to assess or plan entry into a market the company does not currently serve.
  Covers four entry types: new geography, new vertical, new buyer segment, new persona.
  Researches the market via web search and validates the addressable account universe
  via SMARTe before generating the brief.
---

# New Market Entry Briefer

Researches and produces a structured market entry brief covering opportunity size,
ICP definition, competitive landscape, buyer behavior, messaging adaptation, channel
fit, entry motion, and first 90-day priorities. Uses web search for market intelligence
and SMARTe for account universe validation. Adapts emphasis per entry type.

---

## Step 0 — Identify Entry Type and Collect Inputs

Ask the marketer to identify the entry type and provide the context needed to research it.

> "What kind of market are you entering?
> **A** — New geography (e.g. expanding from US to UK, or into APAC)
> **B** — New vertical (e.g. adding Financial Services or Healthcare to your focus)
> **C** — New buyer segment (e.g. moving from SMB to Mid-Market or Enterprise)
> **D** — New persona (e.g. selling to CFOs instead of or alongside IT buyers)"

Once the type is confirmed, collect the following. Accept any combination; ask only
for what is missing:

> "A few things I need before I research:
> 1. What is the specific market you are entering? (named geography, vertical, segment,
>    or persona; be as specific as you can)
> 2. What does your company do, and who do you currently sell to?
> 3. What is driving this market entry? (product fit signal, inbound demand, competitor
>    pressure, strategic decision)
> 4. What is the timeline expectation for this entry?
> 5. Any known competitors already active in this market?"

**Vagueness check:** If the market definition is too broad to research meaningfully,
push back before proceeding:

> "To research this accurately I need a more specific definition. 'International
> expansion' could mean dozens of markets with very different dynamics. Can you name
> a specific geography or vertical so I can give you a brief that is actually useful?"

Do not proceed until the market is named specifically enough to research.

---

## Step 1 — Pull Existing Data (if MCPs connected)

**CRM check:** If a CRM MCP is connected, ask before pulling:

> "I can check your CRM for any existing accounts or contacts in this market before
> we treat it as fully net new. Want me to do that?"

If yes, pull accounts matching the new market definition (by industry, geo, or company
size). Report the count and note whether any existing pipeline exists. This changes
the entry framing from net-new to expansion.

Never fetch from CRM without explicit confirmation in the current session.

**SMARTe: Addressable Universe:** If SMARTe MCP is connected, ask before pulling:

> "I can use SMARTe to quantify how many accounts matching this market's ICP profile
> actually exist, which gives you a grounded TAM estimate rather than an analyst figure.
> Want me to pull that?"

If yes, run the ICP filter for the new market (vertical, size, geography, or persona
presence) and return the account count with a breakdown by key attribute. Use this
figure in the Market Definition section of the brief.

Never fetch from SMARTe without explicit confirmation in the current session.

---

## Step 2 — Research the Market

Run web searches to build the market intelligence needed for the brief. Searches
should cover, at minimum:

- Competitive landscape: who the established players are in this market and their
  primary positioning
- Buyer behavior: how companies in this market buy, who is involved in the decision,
  and what evaluation criteria they use
- Market dynamics: growth signals, regulatory factors (especially for new geographies
  and regulated verticals), and industry-specific pain points
- Channel presence: which channels (events, publications, communities, analysts) are
  most active in this market

Adapt the search focus per entry type:

| Entry type | Additional research focus |
|---|---|
| New geography | Local regulations, data residency requirements, cultural buying norms, local competitor presence, language considerations |
| New vertical | Compliance and certification requirements, vertical-specific press and analysts, dominant tooling in the stack |
| New buyer segment | Buying committee composition changes, budget cycle differences, evaluation criteria vs. current segment |
| New persona | Day-to-day pain points, channels they use to learn, what they read and where they network |

Synthesise findings before generating the brief. Do not fabricate market data; if a
specific figure cannot be sourced, state that and provide a directional estimate with
the basis clearly noted.

---

## Step 3 — Generate the Market Entry Brief

---

### 1. Market Definition and Opportunity Size

Define the market precisely: named geography, vertical, segment, or persona, and the
specific subset of it being targeted in this entry.

State the addressable opportunity in account terms if SMARTe data was pulled, or in
directional terms if not. Do not present analyst TAM figures as precise unless the
source is cited. Note if any existing accounts or pipeline in this market were found
in the CRM and what that implies for the entry approach.

---

### 2. ICP Definition for This Market

State how the ICP for this market differs from the company's existing ICP. Be specific:
- Which existing ICP criteria carry over unchanged
- Which criteria change in this market (different size band, different decision-maker,
  different tech stack requirements)
- What new criteria matter that did not apply before (compliance posture, local
  certifications, regional presence, vertical-specific tooling)

---

### 3. Competitive Landscape

For each identified competitor active in this market:

| Competitor | Category | Primary message | Strength | Gap or opening |
|---|---|---|---|---|
| [Name] | [Established / challenger / niche] | [Their core positioning] | [What they do well] | [Where they are weak or silent] |

Note which competitors are new to this market (not seen in the existing market) and
which carry over. Flag if the market appears to be served primarily by incumbents with
deep switching costs.

---

### 4. Buyer Landscape

Cover three areas:

**Personas:** Who is involved in the buying decision in this market. Name each persona,
their primary concern, and their role in the process (initiator, evaluator, blocker,
economic buyer, champion).

**Pain points:** What problems this market is actively trying to solve that your product
addresses. State these in the language buyers in this market use, not in your current
marketing language.

**Buying process:** How deals are typically evaluated and closed in this market. Note
any differences from the existing market: longer or shorter cycle, more stakeholders,
procurement or compliance involvement, preference for trials vs. demos.

---

### 5. Messaging Adaptation

State what changes and what stays the same.

**Carry over:** Core value proposition elements that land in this market without
modification.

**Adapt:** Specific claims, proof points, or framing that needs to change. For each
item flagged for adaptation, state why and what the replacement should be.

**New proof points needed:** Evidence this market will expect that the current library
does not cover (local case studies, vertical certifications, geographic references,
persona-specific outcomes).

---

### 6. Channel Recommendations

State which channels reach this market effectively and note any that perform
differently here than in the existing market.

| Channel | Fit for this market | Notes |
|---|---|---|
| [Channel] | High / Medium / Low | [Any market-specific consideration] |

Flag channels that are dominant in the existing go-to-market but have lower reach or
credibility in this market. Flag any channels that are strong in this market but not
currently used.

---

### 7. Entry Motion Recommendation

Recommend one primary entry motion and state the rationale:

**Direct sales:** Best when deal sizes justify rep investment and buyers expect a
managed evaluation process.

**PLG (product-led growth):** Best when buyers can self-serve to value quickly and
the product experience is the proof point.

**Partner-led:** Best when local partners, system integrators, or resellers already
have trust with the buyer and a direct motion would be slow or expensive to build.

**Community-led:** Best when the persona is active in a specific community or ecosystem
that can be entered before a full sales motion is required.

State what the recommendation requires to execute: headcount, budget, partner
relationships, or product changes needed before entry is viable.

---

### 8. First 90-Day Priorities

| Phase | Focus | Key actions | Success marker |
|---|---|---|---|
| Days 1-30 | Foundation | ICP validation, account list build, first competitive wins identified | [Specific output or signal] |
| Days 31-60 | Early traction | First outreach, first conversations, messaging tested | [Specific output or signal] |
| Days 61-90 | Momentum | Pipeline opened, channel effectiveness validated, entry motion confirmed or adjusted | [Specific output or signal] |

State what this brief does not yet cover and which downstream skills handle it:
Campaign Brief Builder for the first campaign, Ideal Account List Builder for the
account universe, and ABM Campaign Planner if the entry motion is account-based.

---

## Error Handling

| Scenario | Action |
|---|---|
| Market definition is too vague | Apply the vagueness check in Step 0; do not proceed until it is resolved |
| Web search returns limited results for a niche market | State what was found and what could not be sourced; note the gap explicitly in the brief |
| SMARTe returns a very small account universe | Report the number accurately; note which filter is most restrictive |
| CRM shows the company already has significant presence in this market | Reframe the brief as an expansion brief rather than a net-new entry; note the difference |
| Competitive landscape cannot be sourced for a specific market | Note the gap; do not fabricate competitors |
| Marketer provides conflicting entry signals (e.g. named geo but unclear vertical) | Ask for clarification before researching; do not invent the missing dimension |

---

## Constraints

1. Never present analyst TAM figures as precise without citing the source.
2. Never fabricate competitor names, market data, or buyer behavior claims.
3. Always note when a finding is directional rather than sourced.
4. Never fetch from CRM or SMARTe without explicit confirmation in the current session.
5. Messaging adaptation must name specific changes; do not produce generic advice
   about "localising your message."
6. Campaign planning, account list building, and ABM play design are out of scope;
   reference the relevant skills once in the 90-day section only.
7. SMARTe nudge appears once, at the end, only if SMARTe was not connected.

---

## SMARTe Data Note

*If SMARTe MCP was not connected during this session:*

> The addressable account universe in this brief is estimated from web research rather
> than verified account data. Connecting SMARTe MCP would replace that estimate with
> the actual count of accounts matching this market's ICP profile, giving leadership
> a grounded opportunity size rather than a directional one.
