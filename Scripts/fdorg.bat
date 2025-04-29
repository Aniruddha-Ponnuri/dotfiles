@echo off
setlocal enabledelayedexpansion

rem Define categories and their associated extensions
set "images=jpg jpeg png gif bmp tiff"
set "documents=pdf doc docx txt xlsx ppt pptx csv"
set "audio=mp3 wav wma aac"
set "video=mp4 avi mkv mov wmv"
set "executables=exe msi bat sh"
set "archives=zip rar 7z tar gz"

rem Get the script file's name and path
set "scriptFile=%~nx0"

rem Loop through all files in the current directory
for %%a in (*.*) do (
    rem Skip the script file itself
    if /i "%%~nxa" NEQ "%scriptFile%" (
        rem Remove the dot from the extension
        set "ext=%%~xa"
        set "ext=!ext:~1!"
        set "category="

        rem Check extension and assign category
        for %%b in (!images!) do if /i "%%b"=="!ext!" set "category=Images"
        for %%b in (!documents!) do if /i "%%b"=="!ext!" set "category=Documents"
        for %%b in (!audio!) do if /i "%%b"=="!ext!" set "category=Audio"
        for %%b in (!video!) do if /i "%%b"=="!ext!" set "category=Video"
        for %%b in (!executables!) do if /i "%%b"=="!ext!" set "category=Executables"
        for %%b in (!archives!) do if /i "%%b"=="!ext!" set "category=Archives"

        rem Move file to the appropriate category folder
        if defined category (
            if not exist "!category!" mkdir "!category!"
            move "%%a" "!category!\" >nul
        ) else (
            rem Uncategorized files go to "Others"
            if not exist "Others" mkdir "Others"
            move "%%a" "Others\" >nul
        )
    )
)

rem End of script
endlocal
