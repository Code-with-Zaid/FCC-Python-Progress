@echo off
setlocal enabledelayedexpansion

:: Ask for daily notes (optional)
set /p notes="Enter today's learning notes (leave empty if none): "

:: Stage all changes
git add .

:: If notes provided, use them as commit message
if not "%notes%"=="" (
    git commit -m "Progress Update: %notes%"
) else (
    git commit -m "Progress Update"
)

:: Push to GitHub
git push origin main

echo.
echo ✅ Progress pushed successfully!
pause
