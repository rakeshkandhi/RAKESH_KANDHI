# Resume Audit Handoff — Antigravity → Grok

> Session: 2026-11-03/04 | Model: Claude Opus 4.6

---

## Targeting Decisions

- **Primary role:** AI Engineer
- **Salary target:** 20+ LPA (India)
- **No specific companies** — targeting well-funded AI startups, Salesforce, ServiceNow, Microsoft Azure AI, Atlassian
- **No production Java/Kafka/Kubernetes** — target Python/TypeScript teams only
- **Production AWS:** EC2 (MLOFLO), S3 (MLOFLO + others)
- **Production Azure:** Container Instances, Blob Storage, Document Intelligence, Communication Services, Cosmos DB

## Contact Info Fixes Applied

- Email: `rakesh.kandhi@outlook.com` (was mismatched — href pointed to gmail)
- Phone: `+91 82477 72456` (was missing country code)
- Address: `Hyderabad, India` (removed PIN code)

## Critical Missing Projects Discovered

### 1. Insurance Claims Chatbot (WAS NOT ON RESUME — NOW LEAD BULLET)
- **Production** RAG pipeline for a multinational insurance company (NDA — can't name company or country)
- Azure Document Intelligence → section-based chunking → Cosmos DB (vector store) → embeddings
- Claude Sonnet with **tool calling** for remote data retrieval
- Top-K=5 vector search, retry logic (max 3), human-in-the-loop escalation via support tickets
- Built at RVAI Global

### 2. NRILegal AI Features (WERE NOT ON RESUME — NOW ADDED)
- Claude-powered document summarization via **structured outputs**
- AI-drafted client responses with human-in-the-loop review
- LLM-based incoming mail classification for automated service routing with manager approval

### 3. Dobby — Massively Undersold (NOW PROPERLY DESCRIBED)
- Custom-built LLM orchestration framework (like LangChain but purpose-built)
- Features: multi-provider support (Claude/OpenAI/Vertex AI), tool calling abstraction, structured output parsing, prompt templating, token usage tracking, retry/fallback across providers, streaming, conversation memory management
- Adopted across **10+ internal projects** and **2+ client projects**
- Old bullets were entirely vague tautologies — now has specific capabilities listed

## Project Facts Gathered

### NRILegal
- **Pre-production** — launching Nov 15, 2026. Currently in testing.
- One law firm with offices across UK, Canada, India
- Built for **200+ users** (lawyers, staff)
- **3-person full-stack team** including Rakesh — all handle AI work
- 57% of 2,900+ commits stat is real (as of Oct 25) but **removed** — invites AI-commit scrutiny
- Digital transformation — replacing fully manual/paper processes
- Webhook integrations: Azure Communication Services (email), DocuSeal (document signing)
- 150+ Alembic migrations stat **removed** — reads as unstable schema

### Badger
- Internal tool, **2-person team**
- Used on one repo, **20+ successful runs**
- Found critical **security vulnerabilities** with suggested patches
- 25+ minute average execution time per review
- Runs isolated Azure Container Instances via Taskiq/Redis

### Homesify
- Client application, **20,000+ listings**, production
- No traffic/page-view numbers available

### Warehouse CRM
- Production, ~100 users, straightforward CRUD
- **Removed as standalone** — not differentiated enough for AI Engineer resume

### MLOFLO
- Inherited codebase (not built from scratch)
- API consolidation: reduced redundant API calls, removed unnecessary aggregations
- Fixed infinite-loop bug in employment portal (missing data → crash instead of error)
- Regex ticketing bot: **20-30 tickets/day** automated to Jira (was fully manual)
- EC2 + S3 used in production
- No performance numbers available (2-year-old project)
- **Removed "Full-Stack AI Website Builder" label** — misleading, no AI in MLOFLO

### Dobby
- Used by NRILegal, Badger, insurance project, and other internal/client projects
- Is the orchestration layer underneath Badger's agent runtime

## Structural Changes Made to Resume

1. **2 pages → 1 page** — eliminated duplicate Projects section entirely
2. **Two employer entries → one**: `Software Development Engineer I | RVAI Global (formerly TYNYBAY) | April 2024 – Present`
3. **Experience moved ABOVE Skills** — work first, tools second
4. **7 bullets** covering: Insurance RAG → Dobby → NRILegal AI → NRILegal backend → Badger → Homesify → MLOFLO
5. **Skills cleaned**: Removed Claude Code, Cursor CLI, TipTap, Radix, shadcn/ui, Lefthook, Cloudflare Tunnel, React Hook Form, React Flow, structlog, Valkey, MCP, Subagent Workflows, Agent Hooks & Guardrails
6. **Skills added**: RAG Pipelines, Embeddings, Vector Search, Tool Calling, Structured Outputs, Cosmos DB, Azure Document Intelligence, AWS (EC2, S3)
7. **fontawesome5 package removed** from resume.tex (ATS compatibility)
8. **Summary rewritten**: AI-focused with concrete claims

## Scores Before → After

| Dimension | Before | After |
|-----------|:------:|:-----:|
| ATS Parsing | 6 | 8 |
| Recruiter Impression | 4 | 6.5 |
| Technical Credibility | 6.5 | 8 |
| Relevance to 2-4 YoE | 5 | 7.5 |
| Backend Strength | 6.5 | 7 |
| Full-Stack Strength | 5.5 | 6.5 |
| AI Engineering Strength | 4 | 7.5 |
| Project Quality | 5 | 7.5 |
| Business Impact | 3 | 5 |
| Keyword Alignment | 4.5 | 7 |
| Readability | 4 | 7.5 |
| Interview Defensibility | 5.5 | 7.5 |
| **ATS Overall** | **5.5** | **7.5** |
| **Recruiter Overall** | **4** | **6.5** |
| **Hiring Manager Overall** | **5.5** | **7.5** |

## What Still Needs Work

1. **No latency/throughput/performance numbers** — gather after NRILegal prod launch (Nov 15)
2. **No Java** — structural gap for 60%+ of MNC backend JDs in India
3. **DSA/System Design keywords absent** — interview prep gap, not resume gap
4. **Zero brand-name companies** on resume
5. **Insurance project can't be named** (NDA)
6. **Business impact still thin** — need "reduced X by Y%" style metrics post-launch

## Interview Defensibility Confirmed

Rakesh confirmed he can defend all of these in interviews:
- Embedding models, dimensionality, trade-offs
- Chunking strategies (fixed vs semantic, overlap)
- Vector similarity search (cosine, ANN)
- Token management, context windows, cost optimization
- Prompt engineering patterns (few-shot, CoT, system prompts)
- Agent architectures (ReAct, tool calling, multi-agent)
- LLM evaluation, hallucination detection

## Files Modified

```
src/heading.tex      — fixed email, phone, address
src/objective.tex    — AI-focused summary
src/skills.tex       — lean, relevant skills only
src/experience.tex   — one employer, 7 bullets, all projects consolidated
src/projects.tex     — emptied (comment only)
resume.tex           — reordered sections, removed fontawesome5
```

## Agreement with Grok's Prior Analysis

Agreed on: duplicate structure, activity metrics, email mismatch, employer confusion, niche skills, migration count.
Went further on: Dobby vagueness, MLOFLO mislabeling, Warehouse CRM removal, "AI Development Tools" category removal, missing DSA/System Design keywords.
