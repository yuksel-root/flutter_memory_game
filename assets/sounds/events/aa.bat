@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

REM Sabit path
set BASE_PATH=assets/sounds/events

REM Çıktı dosyası
set OUTPUT=mp3_listesi.txt

> "%OUTPUT%" (
  for %%F in (*.mp3) do (
    echo - %BASE_PATH%/%%F
  )
)

echo MP3 dosya isimleri alt alta ve başında - ile yazildi: %OUTPUT%
pause
