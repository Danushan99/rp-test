# Research Project PP2 — How to Run

This project has three components that must be started separately:

| Component | Tech | Port |
|---|---|---|
| Frontend | React + Vite | `5173` |
| Deed Summarizer API | Flask | `5000` |
| LegalVision API | FastAPI | `8000` |

---

## Prerequisites

- **Node.js** (v18+) and **npm**
- **Python** (3.10+)
- **Neo4j** database running locally (for LegalVision API)
- A **Gemini API key** (for Deed Summarizer)
- An **OpenAI API key** (for LegalVision API)

---

## 1. Frontend

```bash
cd frontend
npm install
npm run dev
```

Open [http://localhost:5173](http://localhost:5173) in your browser.

---

## 2. Deed Summarizer API (Flask)

### Setup environment variables

The `.env` file already exists at `backend/legal_deed_summarizer_flask/.env`. Verify it has your Gemini key:

```env
GEMINI_API_KEY=your_gemini_api_key_here
GEMINI_MODEL=models/gemini-2.5-flash
```

### Install dependencies and run

```bash
cd backend/legal_deed_summarizer_flask
python -m venv venv
source venv/bin/activate        # On Windows: venv\Scripts\activate
pip install -r requirements.txt
python -m spacy download en_core_web_sm
python app.py
```

The Flask API will be available at [http://localhost:5000](http://localhost:5000).

---

## 3. LegalVision API (FastAPI)

### Setup environment variables

Copy the example env file and fill in your values:

```bash
cd backend/legal_vision_api-main
cp .env.example .env
```

Edit `.env`:

```env
NEO4J_URI=bolt://localhost:7687
NEO4J_USER=neo4j
NEO4J_PASS=your_neo4j_password

OPENAI_API_KEY=sk-your-openai-api-key
```

### Start Neo4j

Make sure your Neo4j database is running before starting the API. You can use [Neo4j Desktop](https://neo4j.com/download/) or Docker:

```bash
docker run -p 7474:7474 -p 7687:7687 \
  -e NEO4J_AUTH=neo4j/your_neo4j_password \
  neo4j:latest
```

### Install dependencies and run

```bash
cd backend/legal_vision_api-main
python -m venv venv
source venv/bin/activate        # On Windows: venv\Scripts\activate
pip install -r requirements.txt
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

The FastAPI docs will be available at [http://localhost:8000/docs](http://localhost:8000/docs).

---

## Running All Three Together

Open three separate terminal windows and run each component in its own terminal following the steps above.

```
Terminal 1 → frontend         → npm run dev
Terminal 2 → deed summarizer  → python app.py
Terminal 3 → legalvision api  → uvicorn main:app --reload
```
