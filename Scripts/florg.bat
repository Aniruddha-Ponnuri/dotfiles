@echo off
setlocal enabledelayedexpansion

rem Get the script file's name and path
set "scriptFile=%~nx0"

for %%a in (*.*) do (
    rem Skip the script file itself
    if /i "%%~nxa" NEQ "%scriptFile%" (
        if not "%%~xa"=="" (
            rem Remove the dot from the extension
            set "ext=%%~xa"
            set "ext=!ext:~1!"
            if not exist "!ext!" mkdir "!ext!"
            move "%%a" "!ext!\" >nul
        )
    )
)
