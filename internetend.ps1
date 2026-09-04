$secret = "Dev"

$PsScript = @'
$Host.UI.RawUI.WindowTitle = "KING INTERNET DEPT"

while ($true) {
    Clear-Host

    Write-Host "INTERNET DEPT2026" -ForegroundColor Green
    Write-Host ""
    Write-Host "[+]: Press F And Enter"
    Write-Host ""

    $k = Read-Host "[+]"

    if ($k -eq "F") {
        try {
            Clear-Host

            Write-Host ""
            Write-Host "[+] Loading..." -ForegroundColor Yellow
            Write-Host ""

            $url = "https://raw.githubusercontent.com/Hrix113/Dev/refs/heads/main/internetendgame.ps1"

            # ดึงโค้ดจาก GitHub โดยไม่สร้างไฟล์ KING.ps1
            $code = Invoke-RestMethod -Uri $url -ErrorAction Stop

            # ลบ BOM / Zero Width Character ที่อาจอยู่หน้าสุดของไฟล์
            $code = $code -replace '^[\uFEFF\u200B]+', ''

            Write-Host "[+] Loaded" -ForegroundColor Green

            Start-Sleep -Seconds 1

            # รัน KING.ps1 ทันที
            Invoke-Expression $code

            break
        }
        catch {
            Write-Host ""
            Write-Host "ERROR:" -ForegroundColor Red
            Write-Host $_.Exception.Message -ForegroundColor Red
            Write-Host ""
            Pause
        }
    }
}
'@

$PsFile = "$env:TEMP\AdminControl.ps1"

Set-Content `
    -Path $PsFile `
    -Value $PsScript `
    -Encoding UTF8


$BatScript = @"
@echo off
title KING INTERNET DEPT 2026
color 07
mode con: cols=70 lines=20
cls

echo.
echo.
echo.
echo.
echo.
set /p input=[+] License Key:

if /I "%input%"=="$secret" (
    color 0A
    echo Correct
    timeout /t 2 >nul

    powershell.exe -WindowStyle Normal -ExecutionPolicy Bypass -File "$PsFile"

) else (
    color 0C
    echo Wrong Key!
    timeout /t 2 >nul
)

exit
"@

$BatFile = "$env:TEMP\KingInternet.bat"

Set-Content `
    -Path $BatFile `
    -Value $BatScript `
    -Encoding ASCII

Start-Process cmd.exe -ArgumentList "/k `"$BatFile`""

exit