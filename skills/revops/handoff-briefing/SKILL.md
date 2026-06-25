---
name: handoff-briefing
description: >
  Use this skill whenever a RevOps user or seller needs to create a structured briefing
  document for a GTM handoff. Triggers on: "create a handoff brief", "SDR to AE handoff",
  "AE to CSM handoff", "account handoff", "rep transition brief", "deal handoff document",
  "passing a lead to AE", "handing off an account to CS", "territory handoff", "RevOps
  intel brief for sales", "rep is leaving handoff", "account reassignment brief",
  "qualification summary for AE", "handoff notes", or any request to document and transfer
  account, deal, or lead context from one GTM role to another. Asks which handoff type
  is needed, applies the relevant industry-standard framework as the default template,
  and adapts the briefing based on user input and available data. Supports both single
  high-value deal briefings and batch briefings for multiple leads.
---

# Handoff Briefing

Creates structured, role-specific handoff documents using industry-standard frameworks.
Covers SDR-to-AE, AE-to-CSM, rep-to-rep, and RevOps-to-sales handoffs. Works from CRM
data, rep notes, call transcripts, or any combination. Produces a single briefing document
for batch handoffs or a detailed individual brief for high-value deals, with optional
delivery to Slack, CRM, or both.

---

## Step 0 — Identify Handoff Type

Open every session by asking which type of handoff the user needs:

> "Which type of handoff briefing do you need?
> **A** — SDR to AE (qualifying a lead and passing it with full context for discovery)
> **B** — AE to CSM (closing a deal and handing the account to customer success)
> **C** — Rep to Rep (territory change, account reassignment, or rep departure)
> **D** — RevOps to Sales (passing account intelligence or analysis to the team for action)"

Wait for the user's answer before proceeding. Each handoff type uses a different
industry-standard framework and template structure.

---

## Step 1 — Single Deal or Batch

After identifying the handoff type, ask about scope:

> "Are we briefing on a single deal or account, or a batch of leads or accounts?"

**If single deal or account:**
Ask one follow-up:

> "Is this a high-value or enterprise deal? If so, I'll produce a more detailed
> individual brief with fuller context for the receiving party."

- **High-value / enterprise:** Full detailed brief with narrative sections, stakeholder
  map, and rich deal context.
- **Standard single deal:** Standard brief using the default template for the handoff type.

**If batch:**
Produce a combined document with:
- A priority-ranked summary table at the top (all leads or accounts at a glance)
- A brief individual section per lead or account below the table

For batches, ask:

> "How many leads or accounts are we briefing on? And should I sort them by deal size,
> priority, or another order?"

**Practical limit: 20 leads or accounts per batch briefing.**

If the user submits more than 20:

> "This batch has [N] leads. For a readable briefing document I recommend batches of 20.
> Want me to brief the top 20 by priority, or override and include all?"

---

## Step 2 — Collect Data

Tell the user what inputs will produce the best briefing for the handoff type, then
accept whatever they have. Do not require all fields before proceeding.

> "Here's what makes a strong [handoff type] briefing. Share what you have and I'll
> work from there:"

**For SDR to AE:**
> "Most useful: qualification call notes or transcript, CRM lead record, pain points
> surfaced, champion identified, and any email thread context. At minimum I need the
> company name and a brief description of what was discussed."

**For AE to CSM:**
> "Most useful: CRM deal record, contract details, call transcripts from late-stage
> conversations, any commitments or custom requests made, and the full stakeholder list
> with roles. At minimum I need the company name, deal size, and why they bought."

**For Rep to Rep:**
> "Most useful: full CRM account record, activity history, open tasks and opportunities,
> contact list with relationship notes, and any tribal knowledge the outgoing rep can
> share. At minimum I need the account name and the rep transition context."

**For RevOps to Sales:**
> "Most useful: the analysis or findings being passed, the accounts flagged and why,
> data sources used, and the recommended actions per rep or team. At minimum I need
> the key finding and the accounts involved."

**Accepted data sources:**
- Pasted notes or rep-written context
- CRM export or CRM MCP pull (ask for filters before pulling)
- Call transcripts or meeting summaries
- Email thread context
- A mix of any of the above

**If CRM MCP is connected**, ask before pulling:

> "Should I pull the deal or account record from your CRM to include in the briefing?"

Never fetch from SMARTe without asking. If intent or firmographic signals would strengthen
the briefing, offer:

> "I can enrich [company name] via SMARTe to add firmographic context, tech stack, and
> intent signals to the brief. Want me to do that?"

---

## Step 3 — Apply Default Template

Each handoff type uses an industry-standard framework as the default structure. Present
the template to the user before generating and ask if they want to add, remove, or
adjust any sections:

> "Here's the default structure I'll use for this [handoff type] briefing based on
> [framework name]. Want to add, remove, or adjust any sections before I generate it?"

---

### Template A — SDR to AE (MEDDIC Framework)

Used for: qualifying a lead and passing it with full context for an AE discovery call.

```
SDR TO AE HANDOFF BRIEF
Company: [Name] | Contact: [Name, Title] | Date: [Date]
Assigned AE: [Name] | Handed off by: [SDR Name]

MEDDIC QUALIFICATION SUMMARY

Metrics
What quantified business impact or pain did they express?
[Populated from call notes or transcript]

Economic Buyer
Who has budget authority? Have we reached them?
[Name, title, level of access]

Decision Criteria
What are they evaluating on? Price, features, integrations, timeline?
[Key criteria surfaced]

Decision Process
How do they make decisions? Who else is involved? What is the timeline?
[Process and timeline]

Identify Pain
What specific pain points were surfaced? How urgent is the pain?
[Pain points with urgency signal]

Champion
Who is the internal advocate? How strong is their influence?
[Name, title, champion strength: strong / developing / unclear]

ADDITIONAL CONTEXT
What else does the AE need to know before the first call?
[Rep notes, prior relationship, competitive context, anything not in MEDDIC]

SUGGESTED NEXT STEP
[Specific recommended action for the AE — e.g. "Schedule discovery call focused on
migration timeline — they have a Q3 deadline and the champion is ready to move"]
```

---

### Template B — AE to CSM (CSQL Framework)

Used for: transitioning a closed deal to customer success with full account context.

```
AE TO CSM HANDOFF BRIEF
Company: [Name] | Deal Size: [$] | Close Date: [Date]
Contract Term: [Length] | CSM Assigned: [Name] | AE: [Name]

DEAL OVERVIEW
Why they bought — core use case and pain points that drove the decision:
[Summary]

STAKEHOLDER MAP
Name          | Title          | Role in deal         | Relationship strength
[Champion]    | [Title]        | Internal advocate    | Strong
[Econ buyer]  | [Title]        | Budget authority     | Warm
[End user]    | [Title]        | Primary user         | Neutral
[Detractor]   | [Title]        | Raised objections    | Risk

COMMITMENTS MADE DURING SALES
What was promised? Any custom requests, feature commitments, or timeline guarantees?
[List of commitments — critical for CSM to know before first call]

SUCCESS CRITERIA
How will this customer measure ROI? What does "good" look like to them at 90 days?
[Specific success metrics the customer named]

RED FLAGS
Any concerns, technical risks, relationship risks, or unresolved objections?
[Honest assessment — do not sanitize]

RECOMMENDED FIRST ACTIONS FOR CSM
[Specific suggested steps — e.g. "Lead kickoff with the champion, not the economic
buyer — econ buyer is hands-off post-signature. Address the integration concern
from the final call before it becomes a support ticket."]
```

---

### Template C — Rep to Rep (Account Continuity Framework)

Used for: territory changes, account reassignments, or rep departures.

```
REP TO REP HANDOFF BRIEF
Account: [Company] | Outgoing Rep: [Name] | Incoming Rep: [Name]
Handoff date: [Date] | Account status: [Active customer / Open opportunity / Prospect]

ACCOUNT OVERVIEW
[Company name] is a [description — industry, size, relationship length].
Current status: [1-2 sentences on where things stand]

RELATIONSHIP HISTORY
Key milestones, decisions, and events in the relationship:
[Timeline or narrative — 3 to 5 key moments]

KEY CONTACTS
Name          | Title          | Department   | Last contact  | Relationship strength
[Name]        | [Title]        | [Dept]       | [Date]        | Strong / Warm / Cold
[Name]        | [Title]        | [Dept]       | [Date]        | Strong / Warm / Cold

OPEN ITEMS
What is unresolved, pending, or in flight?
[Tasks, follow-ups, open opportunities, renewal status, support issues]

TRIBAL KNOWLEDGE
What is not in the CRM but the incoming rep needs to know?
[Communication preferences, sensitivities, relationship nuances, history between
the account and the company that shaped the relationship]

SUGGESTED FIRST ACTIONS
[Specific recommended steps for the incoming rep — e.g. "Call [Champion name] first,
not the procurement contact. They prefer Slack over email. Do not bring up the Q2
pricing conversation — it is still a sore point."]
```

---

### Template D — RevOps to Sales (Intelligence Brief Framework)

Used for: passing analysis, account intelligence, or findings from RevOps to the sales team.

```
REVOPS INTELLIGENCE BRIEF
Prepared by: [RevOps name] | Date: [Date] | For: [Rep name / Team / Territory]

WHAT THIS BRIEF COVERS
[One paragraph — what was analyzed, why, and what the sales team should do with it]

KEY FINDINGS
[Finding 1]: [Plain-language explanation + what it means for the rep]
[Finding 2]: [Plain-language explanation + what it means for the rep]
[Finding 3]: [Plain-language explanation + what it means for the rep]

ACCOUNTS REQUIRING IMMEDIATE ACTION
Account       | Why flagged                | Recommended action          | Urgency
[Company]     | [Signal or finding]        | [Specific next step]        | High / Medium
[Company]     | [Signal or finding]        | [Specific next step]        | High / Medium

RECOMMENDED ACTIONS BY REP OR TEAM
[Rep or team name]: [Specific action — what to do with which accounts this week]

DATA SOURCES AND CONFIDENCE
Sources used: [CRM, SMARTe, call transcripts, etc.]
Confidence level: [High / Medium / Directional] — [one-line reason]

SUPPORTING DATA AVAILABLE ON REQUEST
[What additional data RevOps can pull if the rep wants to go deeper]
```

---

## Step 4 — Generate the Briefing

After the user confirms the template structure and data is collected, generate the briefing.
Keep every section as tight as the data allows — the goal is a briefing the receiving party
can read in under 3 minutes, not a comprehensive account history.

**For high-value or enterprise single deals:**
Populate all sections, but keep each to 3 to 5 sentences or a compact table. Use narrative
prose only where the data genuinely warrants it — not to fill space. If a section would
require more than a short paragraph to cover properly, summarize the key point and note
that full context is available on request.

**For standard single deals:**
One to two sentences per section maximum. If a section has nothing meaningful to say
given the available data, skip it rather than padding it.

**For batch briefings:**
Produce a summary table first, then a condensed per-record section below. Each individual
record section covers only the 3 most critical fields for the handoff type — do not
repeat the full template per record. If the batch is large, prioritize depth on the
top 5 records by deal size or urgency and keep the rest to summary-table level only.

**Batch summary table format:**

```
# | Company       | Contact / Account | Handoff type | Top signal or reason    | Priority | Assigned to
1 | [Company]     | [Name / Title]    | SDR to AE    | [MEDDIC signal]         | High     | [AE name]
2 | [Company]     | [Name / Title]    | SDR to AE    | [MEDDIC signal]         | Medium   | [AE name]
```

For any section where data is missing, flag it rather than fabricating:

> "[Section name]: Insufficient data — recommend the [role] ask about this in the
> first call."

---

## Step 5 — Output

After generating the briefing, ask how the user wants to deliver it:

> "How would you like to deliver this briefing?
> - As a document (Markdown file to download)
> - Posted to Slack (channel or DM to the receiving rep)
> - Logged as a note in the CRM (attached to the deal or account record)
> - A combination of the above"

**Document:** Deliver as a downloadable Markdown file. Format cleanly for readability.

**Slack:** Ask for the channel name or the receiving rep's Slack handle. Post via Slack
MCP with a clean summary and a link or attachment to the full document.

**CRM note:** Ask for the deal or account record to attach it to. Log via CRM MCP as
an internal note.

**Combination:** Deliver in all selected formats. Always generate the document first,
then push to Slack and CRM from it.

---

## SMARTe / CRM Data Gap Nudge

Show this nudge once at the very end of the output — after the briefing is delivered.
Show only the nudge(s) relevant to the specific gaps in the briefing. Never show mid-session.

**If SMARTe is not connected and firmographic, technographic, or intent context is
missing from the briefing:**
> **Want richer account context in your briefings?** Connect the SMARTe MCP to pull
> verified firmographics, tech stack signals, and intent data for every account in
> the brief — so the receiving rep walks in with more than just what the CRM has.

**If CRM MCP is not connected and deal or account data had to be provided manually:**
> **Want CRM data pulled automatically into your briefings?** Connect your CRM
> (HubSpot, Salesforce, or other) to pull deal records, activity history, and contact
> details directly — no copying and pasting from the CRM needed.

Never show both nudges if only one applies. Never show a nudge if both data sources
were available and the briefing has no significant gaps.

---

## Error Handling

| Scenario | Action |
|---|---|
| Handoff type is unclear from context | Ask — do not guess the framework to apply |
| Minimal data provided for a high-value deal brief | Flag every unpopulated section explicitly — do not fill gaps with assumptions |
| Batch exceeds 20 and user overrides | Process the full batch, note the document may be long and suggest splitting by AE or territory |
| CRM pull returns no record for the deal or account | Inform the user, ask if they want to paste context manually |
| Rep notes are too sparse to populate key sections | Flag the gaps in the briefing with a recommended question for the receiving party to ask |
| Template section not applicable to this deal | Allow the user to skip it — do not force a section that has no relevant content |
| Slack MCP not connected when user requests Slack delivery | Inform the user, offer the document as a copy-paste fallback |
| CRM MCP not connected when user requests CRM note | Inform the user, offer to format the note for manual copy-paste into the CRM |
| Batch contains both single deal and enterprise deals | Apply full detailed template to enterprise deals and concise template to standard ones within the same document |

---

## Constraints

1. Never fabricate MEDDIC qualification data, stakeholder roles, commitments made,
   or relationship history not present in the provided data or CRM.
2. Always apply the industry-standard framework for the handoff type selected — do
   not default to a generic notes format.
3. Never skip a section without flagging it explicitly in the briefing — the receiving
   party needs to know what context is missing.
4. For high-value or enterprise deals, always use the detailed brief format. Never
   compress an enterprise deal into a batch-style summary without asking first.
5. Never fetch from SMARTe or CRM without explicit user confirmation in the current session.
6. Never deliver to Slack or CRM without asking the user first.
7. Always generate the document before pushing to Slack or CRM.
8. Tribal knowledge from rep notes should be preserved verbatim where possible —
   do not sanitize or reframe it. It exists because it matters.
9. In batch briefings, sort by priority or deal size unless the user specifies otherwise.
10. If the user adjusts the default template, apply those changes consistently across
    all records in the batch — do not mix template versions in the same document.
