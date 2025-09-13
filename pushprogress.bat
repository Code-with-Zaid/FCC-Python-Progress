@echo off
setlocal enabledelayedexpansion

:: Get today's date
for /f "tokens=2 delims==" %%I in ('"wmic os get localdatetime /value"') do set dt=%%I
set today=!dt:~0,4!-!dt:~4,2!-!dt:~6,2!

:: Count existing days
set count=0
for /f "tokens=2 delims= " %%D in ('findstr /b /c:"Day " progress.md') do (
    set /a count+=1
)
set /a nextDay=count+1

:: Ask questions
set /p learned=What did you learn today? (required): 
if "%learned%"=="" (
    echo You must enter something for what you learned.
    pause
    exit /b
)

set /p challenges=Challenges faced (optional): 
set /p notes=Notes to self (optional): 
set /p nextsteps=Next steps (optional): 

:: Build the entry
(
    echo.
    echo ## Day %nextDay% – %today%
    echo **What I learned today:**  
    echo - %learned%
    if not "%challenges%"=="" (
        echo.
        echo **Challenges faced:**  
        echo - %challenges%
    )
    if not "%notes%"=="" (
        echo.
        echo **Notes to self:**  
        echo - %notes%
    )
    if not "%nextsteps%"=="" (
        echo.
        echo **Next Steps (Plan for tomorrow):**  
        echo - %nextsteps%
    )
)>>progress.md

:: Commit and push
git add progress.md
git commit -m "Add Day %nextDay% progress"
git push origin main

echo.
echo ✅ Progress saved and pushed to GitHub!
pause
