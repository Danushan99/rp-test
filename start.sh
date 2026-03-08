#!/bin/bash

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKEND_DIR="$PROJECT_ROOT/backend/legal_deed_summarizer_flask"
LEGAL_VISION_DIR="$PROJECT_ROOT/backend/legal_vision_api-main"
FRONTEND_DIR="$PROJECT_ROOT/frontend"

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

VENV="$BACKEND_DIR/venv"
if [ ! -d "$VENV" ]; then
    echo -e "${RED}Virtual environment not found at $VENV${NC}"
    echo "Run: python3 -m venv $VENV && source $VENV/bin/activate && pip install -r $BACKEND_DIR/requirements.txt"
    exit 1
fi

LEGAL_VISION_VENV="$LEGAL_VISION_DIR/venv"
if [ ! -d "$LEGAL_VISION_VENV" ]; then
    echo -e "${YELLOW}No venv for legal_vision_api. Creating one...${NC}"
    python3 -m venv "$LEGAL_VISION_VENV"
    source "$LEGAL_VISION_VENV/bin/activate"
    pip install -r "$LEGAL_VISION_DIR/requirements.txt"
    deactivate
fi

# --- Backend (Flask) in a new Terminal window ---
echo -e "${GREEN}Starting backend (Flask) in a new terminal...${NC}"
osascript <<EOF
tell application "Terminal"
    do script "source '$VENV/bin/activate' && cd '$BACKEND_DIR' && python3 app.py"
    activate
end tell
EOF

# --- Legal Vision API (FastAPI) in another new Terminal window ---
echo -e "${GREEN}Starting legal_vision_api in a new terminal...${NC}"
osascript <<EOF
tell application "Terminal"
    do script "source '$LEGAL_VISION_VENV/bin/activate' && cd '$LEGAL_VISION_DIR' && python3 -m uvicorn main:app --reload"
    activate
end tell
EOF

# --- Frontend in current terminal ---
echo -e "${GREEN}Starting frontend...${NC}"
cd "$FRONTEND_DIR"

if [ ! -d "node_modules" ]; then
    echo -e "${YELLOW}Installing frontend dependencies...${NC}"
    npm install
fi

echo -e "${YELLOW}Press Ctrl+C to stop the frontend.${NC}"
npm run dev
