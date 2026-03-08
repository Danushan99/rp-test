# Run from project root: .\start.ps1
# If blocked by execution policy, run: Set-ExecutionPolicy -Scope CurrentUser RemoteSigned

$PROJECT_ROOT = Split-Path -Parent $MyInvocation.MyCommand.Definition
$BACKEND_DIR = Join-Path $PROJECT_ROOT "backend\legal_deed_summarizer_flask"
$LEGAL_VISION_DIR = Join-Path $PROJECT_ROOT "backend\legal_vision_api-main"
$FRONTEND_DIR = Join-Path $PROJECT_ROOT "frontend"

$VENV = Join-Path $BACKEND_DIR "venv"
$LEGAL_VISION_VENV = Join-Path $LEGAL_VISION_DIR "venv"

# --- Check Flask venv ---
if (-Not (Test-Path $VENV)) {
    Write-Host "[ERROR] Virtual environment not found at $VENV" -ForegroundColor Red
    Write-Host "Run: python -m venv `"$VENV`" && pip install -r `"$BACKEND_DIR\requirements.txt`""
    Read-Host "Press Enter to exit"
    exit 1
}

# --- Check / create Legal Vision venv ---
if (-Not (Test-Path $LEGAL_VISION_VENV)) {
    Write-Host "[INFO] No venv for legal_vision_api. Creating one..." -ForegroundColor Yellow
    python -m venv $LEGAL_VISION_VENV
    & "$LEGAL_VISION_VENV\Scripts\Activate.ps1"
    pip install -r "$LEGAL_VISION_DIR\requirements.txt"
    deactivate
}

# --- Backend (Flask) in a new PowerShell window ---
Write-Host "[INFO] Starting backend (Flask)..." -ForegroundColor Green
Start-Process powershell -ArgumentList "-NoExit", "-Command", "& '$VENV\Scripts\Activate.ps1'; cd '$BACKEND_DIR'; python app.py"

# --- Legal Vision API (FastAPI) in a new PowerShell window ---
Write-Host "[INFO] Starting legal_vision_api..." -ForegroundColor Green
Start-Process powershell -ArgumentList "-NoExit", "-Command", "& '$LEGAL_VISION_VENV\Scripts\Activate.ps1'; cd '$LEGAL_VISION_DIR'; uvicorn main:app --reload"

# --- Frontend in current window ---
Write-Host "[INFO] Starting frontend..." -ForegroundColor Green
Set-Location $FRONTEND_DIR

if (-Not (Test-Path "node_modules")) {
    Write-Host "[INFO] Installing frontend dependencies..." -ForegroundColor Yellow
    npm install
}

Write-Host "[INFO] Press Ctrl+C to stop the frontend." -ForegroundColor Yellow
npm run dev
