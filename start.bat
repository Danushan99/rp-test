@echo off
setlocal

set PROJECT_ROOT=%~dp0
set BACKEND_DIR=%PROJECT_ROOT%backend\legal_deed_summarizer_flask
set LEGAL_VISION_DIR=%PROJECT_ROOT%backend\legal_vision_api-main
set FRONTEND_DIR=%PROJECT_ROOT%frontend

set VENV=%BACKEND_DIR%\venv
set LEGAL_VISION_VENV=%LEGAL_VISION_DIR%\venv

:: --- Check Flask venv ---
if not exist "%VENV%" (
    echo [ERROR] Virtual environment not found at %VENV%
    echo Run: python -m venv "%VENV%" ^&^& "%VENV%\Scripts\activate" ^&^& pip install -r "%BACKEND_DIR%\requirements.txt"
    pause
    exit /b 1
)

:: --- Check / create Legal Vision venv ---
if not exist "%LEGAL_VISION_VENV%" (
    echo [INFO] No venv for legal_vision_api. Creating one...
    python -m venv "%LEGAL_VISION_VENV%"
    call "%LEGAL_VISION_VENV%\Scripts\activate.bat"
    pip install -r "%LEGAL_VISION_DIR%\requirements.txt"
    deactivate
)

:: --- Backend (Flask) in a new window ---
echo [INFO] Starting backend (Flask)...
start "Flask Backend" cmd /k "call "%VENV%\Scripts\activate.bat" && cd /d "%BACKEND_DIR%" && python app.py"

:: --- Legal Vision API (FastAPI) in a new window ---
echo [INFO] Starting legal_vision_api...
start "Legal Vision API" cmd /k "call "%LEGAL_VISION_VENV%\Scripts\activate.bat" && cd /d "%LEGAL_VISION_DIR%" && uvicorn main:app --reload"

:: --- Frontend in current window ---
echo [INFO] Starting frontend...
cd /d "%FRONTEND_DIR%"

if not exist "node_modules" (
    echo [INFO] Installing frontend dependencies...
    npm install
)

echo [INFO] Press Ctrl+C to stop the frontend.
npm run dev

endlocal
