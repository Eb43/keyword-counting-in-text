@echo off
setlocal enabledelayedexpansion

:check_keyword_file
if not exist "keyword.txt" (
    set /p keyword_file=Enter the address of keyword.txt: 
    if not exist "!keyword_file!" (
        echo Keyword file does not exist. Please provide a valid path.
        goto check_keyword_file
    )
) else (
    set "keyword_file=keyword.txt"
)

:check_text_file
if not exist "text.txt" (
    set /p text_file=Enter the address of text.txt: 
    if not exist "!text_file!" (
        echo Text file does not exist. Please provide a valid path.
        goto check_text_file
    )
) else (
    set "text_file=text.txt"
)

echo Searching for keywords in text...
echo:
echo -----------------------------

set "string="

:: Read the content from the text file and store it in the "string" variable
for /f "delims=" %%a in (!text_file!) do (
    set "string=!string! %%a"
)

:: Read the list of keywords from the keyword file and process each keyword one by one
for /f "delims=" %%k in (!keyword_file!) do (
    set "keyword=%%k"
    call :FindKeyword
)

echo ---------------------------
echo:
pause
exit /b

:FindKeyword
set "count=0"
for /f %%a in ('echo "!string!" ^| findstr /i /c:"!keyword!"') do (
    set /a "count+=1"
)
if %count% gtr 0 (
    echo "!keyword! ---> %count% times in text"
)
exit /b
