@echo off
setlocal enabledelayedexpansion

echo PNG dosya isimleri 61'den başlayarak değiştiriliyor...
echo.

set sayi=0

for %%i in (*.png) do (
    ren "%%i" "!sayi!.png"
    echo %%i --^> !sayi!.png
    set /a sayi+=1
)

echo.
echo İşlem tamamlandı!
pause