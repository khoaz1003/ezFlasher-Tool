::[Bat To Exe Converter]
::
::fBE1pAF6MU+EWH3eyFIiJxFRTxC+OXGcCrQP4OH16KqzrUIRaOM7esHewrHu
::fBE1pAF6MU+EWH3eyFIiJxFRTxC+OXGcCrQP4OH16KqzrUIRaMM7erjS1JWeKa4X5kmE
::fBE1pAF6MU+EWH3eyFIiJxFRTxC+OXGcCrQP4OH16KqzrUIRaMM7erjS1IGdIsED4wvgeZpN
::fBE1pAF6MU+EWH3eyFIiJxFRTxC+OXGcCrQP4OH16KqzrUIRaOQ+a5vZ1buabuUL7yU=
::YAwzoRdxOk+EWAnk
::fBw5plQjdG8=
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+JeA==
::cxY6rQJ7JhzQF1fEqQJQ
::ZQ05rAF9IBncCkqN+0xwdVs0
::ZQ05rAF9IAHYFVzEqQJQ
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
cls
@echo off
@echo off
title ezFlashing v1.0
cls

:MENU
cls
echo ========================================================
echo        ezFlashing Tool for Android by khoaz1003              
echo ========================================================
echo.
echo  [1] Kiem tra ket noi thiet bi
echo  [2] Khoi dong lai thiet bi
echo  [3] Auto Flash IMG
echo  [4] Sideload ROM zip
echo  [5] ADB
echo  [6] Thoat
echo.
echo ========================================================
set /p choice="Nhap lua chon cua ban (1-6): "

if "%choice%"=="1" goto CHECK_DEVICE
if "%choice%"=="2" goto REBOOT_MENU
if "%choice%"=="3" goto FLASH_IMAGES
if "%choice%"=="4" goto SIDELOAD_ROM
if "%choice%"=="5" goto ADB
if "%choice%"=="6" exit
echo Lua chon khong hop le! Nhan phim bat ky va thu lai. & pause > nul & goto MENU


:CHECK_DEVICE
cls
echo === KIEM TRA KET NOI THIET BI ===
echo.
echo [ADB Devices]:
adb devices
echo.
echo [Fastboot Devices]:
fastboot devices
echo.
echo ========================================================
echo Nhan phim bat ky de quay lai Menu...
pause > nul
goto MENU

:REBOOT_MENU
cls
echo ========================================================
echo            REBOOT (KHOI DONG LAI THIET BI)                  
echo ========================================================
echo.
echo  [1] Reboot system (Khoi dong lai)
echo  [2] Reboot Recovery (Che do khoi phuc)
echo  [3] Reboot Bootloader (Che do nap rom)
echo  [4] Reboot vao Fastbootd (Che do nap rom)
echo  [5] Tat nguon thiet bi
echo  [6] Thoat
echo.
echo ========================================================
set /p rb_choice="Nhap lua chon cua ban (1-6): "

if "%rb_choice%"=="1" (
    echo [*] Dang khoi dong lai...
    adb reboot
    fastboot reboot
    goto MENU
)
if "%rb_choice%"=="2" (
    echo [*] Dang khoi dong lai vao Recovery...
    adb reboot recovery
    fastboot reboot recovery
    goto MENU
)
if "%rb_choice%"=="3" (
    echo [*] Dang khoi dong lai vao Bootloader...
    adb reboot bootloader
    fastboot reboot bootloader
    goto MENU
)
if "%rb_choice%"=="4" (
    echo [*] Dang khoi dong lai vao Fastbootd...
    adb reboot fastboot
    fastboot reboot-fastboot
    goto MENU
)
if "%rb_choice%"=="5" (
    echo [*] Dang tat nguon thiet bi...
    adb shell reboot -p
    adb reboot -p
    fastboot oem poweroff
    fastboot poweroff
    goto MENU
)
if "%rb_choice%"=="6" goto MENU

echo Lua chon khong hop le! Nhan phim bat ky va thu lai. & pause > nul & goto REBOOT_MENU

:FLASH_IMAGES
cls
echo ======================= Auto Flash IMG =======================
echo (Dam bao dien thoai cua ban dang o che do Fastboot/Bootloader)
echo ----
echo File duoc ho tro: boot.img; vbmeta.img; vbmeta_system.img; vendor_boot.img; dtbo.img
echo *VUI LONG DOI TEN CAC FILE THEO HUONG DAN DE FLASH 1 CACH CHINH XAC.
echo.
fastboot devices
echo.
set /p confirm="Nhan 'Y' de bat dau flash, hoac nhan phim bat ky roi nhan ENTER de huy: "
if /i "%confirm%" NEQ "Y" goto MENU

echo.
echo --------------------------------------------------------
if exist "boot.img" (
    echo [*] Dang flash boot...
    fastboot flash boot boot.img
)
if exist "vbmeta.img" (
    echo [*] Dang flash vbmeta...
    fastboot flash vbmeta --disable-verity --disable-verification vbmeta.img
)
if exist "vbmeta_system.img" (
    echo [*] Dang flash vbmeta_system...
    fastboot flash vbmeta_system --disable-verity --disable-verification vbmeta_system.img
)
if exist "vendor_boot.img" (
    echo [*] Dang flash vendor_boot...
    fastboot flash vendor_boot vendor_boot.img
)
if exist "dtbo.img" (
    echo [*] Dang flash dtbo...
    fastboot flash dtbo dtbo.img
)
echo --------------------------------------------------------

echo.
echo Hoan tat qua trinh flash!
echo Nhan phim bat ky de quay lai Menu...
pause > nul
goto MENU

:SIDELOAD_ROM
cls
echo === SIDELOAD ROM ===
echo (Dam bao dien thoai dang o che do Recovery ADB Sideload)
echo (Copy file rom muon flash vao cung thu muc voi tool nay va doi ten thanh rom.zip)
echo.
if not exist "rom.zip" (
    echo [LOI] Khong tim thay file "rom.zip" trong thu muc nay!
    echo Vui long kiem tra hoac doi ten file ROM cua ban thanh "rom.zip" roi thu lai.
    echo.
    pause
    goto MENU
)

adb devices
echo.
set /p confirm_side="Nhan 'Y' de xac nhan sideload rom.zip, hoac phim khac de huy: "
if /i "%confirm_side%" NEQ "Y" goto MENU

echo.
echo [*] Dang sideload rom.zip... Vui long doi...
adb sideload rom.zip
echo --------------------------------------------------------
echo Hoan tat qua trinh sideload!
echo Nhan phim bat ky de quay lai Menu...
pause > nul
goto MENU
-------------------
:ADB
echo ========================= ADB =========================
echo - Go chu "exit" de thoat.
echo --------------------------------------------------------
echo.

:CMD_LOOP
set "user_cmd="
set /p user_cmd="ezFlasher_CMD> "

if /i "%user_cmd%"=="" goto CMD_LOOP
if /i "%user_cmd%"=="exit" goto MENU

echo.

%user_cmd%
echo --------------------------------------------------------
goto CMD_LOOP