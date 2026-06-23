# SMARTe GTM Skills

Free, open-source Claude skills for GTM teams. Purpose-built instruction files that turn Claude into a specialized AI assistant for sales, RevOps, marketing, and GTM engineering workflows.

If you are an SDR writing cold emails, an AE qualifying deals, a RevOps manager scoring your ICP, or a GTM engineer building enrichment workflows, these skills give Claude the exact context and structure it needs to produce GTM-grade outputs, not generic AI responses.

No prompt engineering. No setup overhead. Install once, use across every conversation.

Built by [SMARTe](https://smarte.pro), the B2B GTM data intelligence platform trusted by enterprise revenue teams worldwide. Browse the full directory at [gtmskills.sh](https://gtmskills.sh)

---

## How it works

Each skill is a markdown instruction file (SKILL.md) that Claude reads before responding. When you install this repo, Claude knows:

- **When to use each skill** based on what you ask
- **How to structure its thinking** step by step, not freeform
- **What to output** in a format that's actually useful for GTM work

You don't need to write prompts. You just ask Claude to do the job.

---

## Install via GitHub

The fastest way to get all SMARTe GTM skills in one command. Works with Claude Code, Cursor, Windsurf, and GitHub Copilot.

```bash
npx skills add smarte-skills/gtm-skills
```

All skills in this repo are available to your coding agent immediately after install.

---

## Download and install directly into Claude

Prefer to use skills directly in Claude without a coding agent? You can download any SKILL.md file and add it manually.

1. Visit **[gtmskills.sh](https://gtmskills.sh)** and find the skill you want
2. Download the SKILL.md file directly from the skills page
3. Open Claude and go to **Projects** → create or open a project
4. Upload the SKILL.md file as a project document
5. Claude will now follow the skill's instructions in every conversation within that project

You can add multiple skills to the same project.

---

## Who these skills are for

These skills are built for GTM teams the people responsible for pipeline, revenue, and go-to-market execution. Skills are organized by role and use case, and the library grows as new skills are added.

Browse the full directory at **[gtmskills.sh](https://gtmskills.sh)** to find skills by role, function, or use case.

---

## Repo Architecture

```
gtm-skills/
├── README.md                          # Main repo readme — install, overview, about SMARTe
├── LICENSE
│
├── SKILL.md                           # Master orchestrator — detects persona, routes to sub-skill
│
├── references/                        # On-demand reference files — add your company/team context here
│   ├── reference-file.md
│   ├── reference-file.md
│   ├── reference-file.md
│   └── reference-file.md
│
├── skills/
│   ├── sellers/                       # Skills for SDRs, AEs, and Sales Managers
│   │   ├── skill-name/
│   │   │   └── SKILL.md
│   │   └── skill-name/
│   │       └── SKILL.md
│   │
│   ├── revops/                        # Skills for Revenue Ops and Sales Ops
│   │   ├── skill-name/
│   │   │   └── SKILL.md
│   │   └── skill-name/
│   │       └── SKILL.md
│   │
│   ├── marketing/                     # Skills for Demand Gen, ABM, and Marketing Ops
│   │   ├── skill-name/
│   │   │   └── SKILL.md
│   │   └── skill-name/
│   │       └── SKILL.md
│   │
│   └── gtm-engineers/                 # MCP-powered skills for RevOps builders and automation leads
│       ├── skill-name/
│       │   └── SKILL.md               # Detects SMARTe MCP, degrades gracefully if absent
│       └── skill-name/
│           └── SKILL.md               # Detects SMARTe MCP, degrades gracefully if absent
│
├── agents/
│   ├── seller.md                      # Quota-carrying AE/SDR persona
│   ├── revops.md                      # Structured, data-driven RevOps persona
│   ├── marketer.md                    # Campaign and pipeline-focused persona
│   └── gtm-engineer.md               # Automation-first builder persona
│
└── docs/
    ├── ARCHITECTURE.md                # Structure, design principles, orchestration flow
    └── SMARTE-MCP.md                  # What SMARTe MCP is, what it unlocks, and setup guide
```

---

## A note on SMARTe MCP

Several skills in this repo are powered by the **SMARTe MCP server**, which gives Claude direct, real-time access to SMARTe's B2B data platform via the Model Context Protocol (MCP).

This means Claude can run live prospect searches, enrich company and contact records, reveal verified emails and mobile numbers, and pull technographic signals, all within a single conversation, without switching tools or exporting data.

Skills that require MCP are clearly marked at the top of their SKILL.md file. Skills built for Sellers, RevOps, and Marketing work without MCP and rely on Claude's reasoning and web research capabilities out of the box.

**What SMARTe MCP unlocks:**
- Real-time access to 289M+ verified B2B contacts across 200+ countries
- Firmographic and technographic enrichment across 66M+ company profiles
- 75%+ mobile number coverage in North America, 45-50% across EMEA, APAC, and LATAM
- SOC 2 Type II certified, GDPR aligned, and CCPA compliant data

To connect SMARTe MCP, visit [smarte.pro](https://smarte.pro) or contact your SMARTe account team.

---

## Browse all skills

Visit **[gtmskills.sh](https://gtmskills.sh)** to browse the full directory, see example outputs for each skill, and find skills by role, use case, or tool.

---

## About SMARTe

SMARTe is a B2B GTM data intelligence platform built for the AI era. Founded in 2005, SMARTe delivers verified contact data, real-time buying signals, firmographic and technographic intelligence, and native AI agent infrastructure to enterprise revenue teams across sales, marketing, and RevOps.

**By the numbers:**
- 289M+ verified B2B contacts
- 66M+ company profiles
- 64K+ technographic signals tracked
- 200+ countries covered
- 75%+ mobile number coverage in North America

**Recognized by:**
- Forrester Wave: Marketing and Sales Data Providers for B2B, Q1 2026
- Gartner Market Guide for GTM Data Applications, 2024
- G2 High Performer in Sales Intelligence, Spring 2025
- Rated 4.6/5 on G2 and 8.3/10 on TrustRadius

**Trusted by:** Dell, Accenture, Salesforce, Uber, Finastra, Informatica, Qualtrics, Oracle, and hundreds of B2B revenue teams globally.

**In partnership with:** Clay, Bombora, Apollo, Outreach.

- Website: [smarte.pro](https://smarte.pro)
- GTM Skills Directory: [gtmskills.sh](https://gtmskills.sh)
- LinkedIn: [SMARTe on LinkedIn](https://www.linkedin.com/company/smarte-inc)

---

## License

MIT free to use, adapt, and build on.
