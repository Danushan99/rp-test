# Research Project PP2 — Setup & Run Guide

## Project Structure

```
Research-Project-PP2-main/
├── backend/
│   ├── legal_deed_summarizer_flask/   # Flask API (deed summarization)
│   └── legal_vision_api-main/         # FastAPI (GraphRAG / LegalVision)
├── frontend/                           # React + Vite frontend
├── start.sh                            # macOS/Linux launcher
├── start.bat                           # Windows (CMD) launcher
└── start.ps1                           # Windows (PowerShell) launcher
```

---

## Prerequisites

Make sure the following are installed before running:

| Tool | Version | Notes |
|------|---------|-------|
| Python | 3.11 – 3.13 | ⚠️ Python 3.14 is **not supported** (spacy incompatibility) |
| Node.js | 18+ | For the frontend |
| npm | 9+ | Comes with Node.js |
| Neo4j | 5+ | Required by LegalVision API |

---

## 1. Environment Variables

### Flask Backend (`backend/legal_deed_summarizer_flask/.env`)

Create a `.env` file in `backend/legal_deed_summarizer_flask/`:

```env
GEMINI_API_KEY=your_gemini_api_key
GEMINI_MODEL=models/gemini-2.5-flash
```

### LegalVision API (`backend/legal_vision_api-main/.env`)

Copy the example and fill in your values:

```bash
cp backend/legal_vision_api-main/.env.example backend/legal_vision_api-main/.env
```

Then edit `backend/legal_vision_api-main/.env`:

```env
NEO4J_URI=bolt://localhost:7687
NEO4J_USER=neo4j
NEO4J_PASS=your_neo4j_password

OPENAI_API_KEY=sk-your-openai-api-key

HOST=0.0.0.0
PORT=8000
DEBUG=true
```

---

## 2. First-Time Setup

### Flask Backend

```bash
cd backend/legal_deed_summarizer_flask
python3 -m venv venv
source venv/bin/activate          # Windows: venv\Scripts\activate
pip install -r requirements.txt
deactivate
```

### LegalVision API

```bash
cd backend/legal_vision_api-main
python3 -m venv venv
source venv/bin/activate          # Windows: venv\Scripts\activate
pip install -r requirements.txt
deactivate
```

### Frontend

```bash
cd frontend
npm install
```

---

## 3. Running the Project

### macOS / Linux

```bash
chmod +x start.sh
./start.sh
```

### Windows (Command Prompt)

```cmd
start.bat
```

### Windows (PowerShell)

> First time only — allow scripts to run:
> ```powershell
> Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
> ```

```powershell
.\start.ps1
```

---

## What the launcher does

| Terminal | Service | URL |
|----------|---------|-----|
| New window | Flask Backend | `http://localhost:5000` |
| New window | LegalVision API (FastAPI) | `http://localhost:8000` |
| Current window | React Frontend (Vite) | `http://localhost:5173` |

Press `Ctrl+C` in the frontend terminal to stop. Close the other terminal windows to stop the backends.

---

## Troubleshooting

**`zsh: command not found: python`**
Use `python3` instead. The start scripts already handle this.

**`spacy` fails on Python 3.14**
Python 3.14 is not yet supported by spacy. Use Python 3.11, 3.12, or 3.13.
```bash
# Install Python 3.13 via Homebrew (macOS)
brew install python@3.13
/opt/homebrew/bin/python3.13 -m venv venv
```

**PowerShell execution policy error**
```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```

**Frontend `node_modules` missing**
The launcher installs them automatically. Or run manually:
```bash
cd frontend && npm install
```

**Neo4j connection error**
Make sure Neo4j is running and the credentials in `backend/legal_vision_api-main/.env` are correct.
