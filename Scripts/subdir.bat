@echo off
setlocal enabledelayedexpansion

:: Define the destination folder
set "destination=Consolidated"

:: Create the destination folder if it doesn't exist
if not exist "%destination%" mkdir "%destination%"

:: Get the script file's full path
set "scriptPath=%~f0"

:: Move all files from subfolders to the destination folder
for /r %%a in (*) do (
    if exist "%%a" (
        rem Skip the script file itself
        if not "%%~fa"=="%scriptPath%" (
            echo Moving "%%a" to "%destination%\"...
            move "%%a" "%destination%\" >nul
        )
    )
)

:: Recursively delete all empty folders (including nested ones)
:delete_empty_folders
set "emptyDeleted=0"
for /d /r %%d in (*) do (
    rd "%%d" 2>nul
    if not exist "%%d" set "emptyDeleted=1"
)
if "%emptyDeleted%"=="1" goto delete_empty_folders

echo All files have been moved to "%destination%" and all empty folders have been deleted.
pause
