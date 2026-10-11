@echo off
cd /d "%~dp0"
echo ===================================================
echo           LEARNXT MULTI-AI STUDY STUDIO
echo ===================================================
node --version >nul 2>&1
if errorlevel 1 (
  echo Node.js 20 or newer is required: https://nodejs.org/
  pause
  exit /b 1
)
if not exist ".env" (
  echo.
  echo No .env file found. Sample decks work but live AI needs a private API key.
  echo Copy .env.example to .env and fill in at least one provider key.
)
echo.
echo Browser address: http://localhost:3000
start "" "http://localhost:3000"
node server.js
pause
