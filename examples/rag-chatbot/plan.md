# Plan: RAG Chatbot API

## Overview
A Python API for uploading PDFs and asking questions answered from the document content. FastAPI + PostgreSQL/pgvector + OpenAI.
Spec: `docs/rag-chatbot/spec.md`

---

## Phase 1: Foundation
**Goal:** The app starts, connects to the database, and responds to a health check.

### Task 1: Project skeleton with database and health check

**Context:**
A Python RAG chatbot API using FastAPI and PostgreSQL with pgvector. Uses UV for package management. This task sets up the foundation — a running app with an async database connection and the pgvector extension enabled.

**Acceptance Criteria:**
- The app starts via Docker Compose (API + PostgreSQL with pgvector)
- A health check endpoint confirms the database connection is alive
- Configuration is driven by environment variables

**Verify:**
`docker compose up -d && curl http://localhost:8000/health` returns `{"status": "ok"}`

---

## Phase 2: Document Ingestion
**Goal:** PDFs can be uploaded, chunked, embedded, and stored.

### Task 2: PDF upload and ingestion

**Context:**
A RAG chatbot API that stores PDFs as text chunks with vector embeddings. Uses SQLAlchemy async with PostgreSQL and pgvector. OpenAI text-embedding-3-small (1536 dimensions). Chunks are ~500 tokens with ~50 token overlap. This task builds the full ingestion pipeline — from PDF upload to stored embeddings.

**Acceptance Criteria:**
- POST `/api/v1/documents` accepts a PDF, extracts text, chunks it, embeds it, and stores the document with all chunks and embeddings
- Non-PDF uploads return 400
- Upload response includes document ID and chunk count

**Verify:**
`curl -F "file=@test.pdf" http://localhost:8000/api/v1/documents` returns `{id, filename, chunk_count}`. `curl -F "file=@test.txt" http://localhost:8000/api/v1/documents` returns 400.

### Task 3: Document listing and deletion

**Context:**
A RAG chatbot API with uploaded documents stored in PostgreSQL. Users need to see what documents exist and remove ones they no longer need. Deleting a document must cascade to all associated chunks and embeddings.

**Acceptance Criteria:**
- GET `/api/v1/documents` returns all documents with id, filename, uploaded_at, chunk_count
- DELETE `/api/v1/documents/{id}` removes the document and all chunks
- Deleting a non-existent document returns 404

**Verify:**
Upload a document, `curl http://localhost:8000/api/v1/documents` lists it. `curl -X DELETE http://localhost:8000/api/v1/documents/{id}` returns 200. List again — it's gone. `curl -X DELETE http://localhost:8000/api/v1/documents/99999` returns 404.

---

## Phase 3: Chat
**Goal:** Users can ask questions and get answers grounded in their documents.

### Task 4: Chat endpoint with retrieval

**Context:**
A RAG chatbot API with documents stored as embedded chunks in pgvector. The chat endpoint takes a user's question, finds relevant chunks via vector similarity, and generates an answer using OpenAI chat completion. Answers must include source references. When no relevant chunks exist, the response says so rather than hallucinating.

**Acceptance Criteria:**
- POST `/api/v1/chat` accepts `{message}`, retrieves relevant chunks, and returns `{answer, sources}`
- Sources include the chunk content and document_id
- When no relevant chunks are found, returns a "no information" response

**Verify:**
Upload a test PDF about a known topic. `curl -X POST http://localhost:8000/api/v1/chat -H "Content-Type: application/json" -d '{"message": "What does the document say about X?"}'` returns an answer with non-empty sources. `curl -X POST http://localhost:8000/api/v1/chat -H "Content-Type: application/json" -d '{"message": "What is the airspeed of an unladen swallow?"}'` returns a "no information" response.

---

## Phase 4: Tests and Polish
**Goal:** Integration tests covering the full API and consistent response schemas.

### Task 5: Integration tests

**Context:**
A RAG chatbot API with document upload, listing, deletion, and chat endpoints. All endpoints are working but need integration tests. The testing strategy (from the spec) uses pytest with httpx AsyncClient, real pgvector for database tests, and mocked OpenAI calls for speed and reproducibility.

**Acceptance Criteria:**
- Tests cover: upload + verify chunks stored, list documents, delete with cascade, chat with relevant chunks, chat with no relevant chunks, error cases (400, 404, 502)
- OpenAI calls are mocked with deterministic responses
- Database tests run against a real PostgreSQL + pgvector instance

**Verify:**
`pytest` — all tests pass.
