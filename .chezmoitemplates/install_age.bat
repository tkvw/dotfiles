@echo off

:: Check if age is installed
where age >nul 2>nul
if %ERRORLEVEL% == 0 (
    echo age is already installed.
) else (
    echo age is not installed. Installing via winget...
    winget install FiloSottile.age
)