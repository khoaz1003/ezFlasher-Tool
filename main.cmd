cls
@echo off
@echo off
cd /d "%~dp0"
adb start-server > nul 2>&1
title ezFlashing v1.1
cls
color 2
:MENU
cls
echo ========================================================
echo         ezFlashing Tool for Android by khoaz1003              
echo ========================================================
echo.
echo  [1] Kiem tra ket noi thiet bi
echo  [2] Khoi dong lai thiet bi
echo  [3] Auto Flash IMG
echo  [4] Sideload ROM zip
echo  [5] ADB
echo  [6] Thoat
echo.
echo Version 1.1
echo ========================================================
set /p choice="Nhap lua chon cua ban (1-6): "

if "%choice%"=="1" goto ktthietbi
if "%choice%"=="2" goto rebootmenu
if "%choice%"=="3" goto autoflashimg
if "%choice%"=="4" goto sideload
if "%choice%"=="5" goto ADB
if "%choice%"=="6" exit
echo Lua chon khong hop le! Nhan phim bat ky va thu lai. & pause > nul & goto MENU


:ktthietbi
cls
echo =============== KIEM TRA KET NOI THIET BI ===============
echo.
echo [Thiet bi ADB dang ket noi ADB Devices]:
adb devices
echo.
echo [Fastboot Devices]:
fastboot devices
echo.
echo ========================================================
echo Nhan phim bat ky de quay lai Menu...
pause > nul
goto MENU

:rebootmenu
cls
echo ========================================================
echo          REBOOT OPTIONS (TUY CHON KHOI DONG LAI)                  
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

echo Lua chon khong hop le! Nhan phim bat ky va thu lai. & pause > nul & goto rebootmenu

:autoflashimg
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

:sideload
cls
echo =================== SIDELOAD ROM zip ===================
echo  [CACH 1] Su dung file rom cung thu muc voi tool (rom.zip)
echo  [CACH 2] Keo tha file ROM tu ben ngoai
echo  [3] Quay lai Menu
echo ========================================================
set /p side_mode="Nhap lua chon (1-3): "

if "%side_mode%"=="1" goto sideloadcungthumuc
if "%side_mode%"=="2" goto sideloadkeotha
if "%side_mode%"=="3" goto MENU
echo Lua chon khong hop le! & pause > nul & goto sideload

:sideloadcungthumuc
cls
echo =============== SIDELOAD ROM zip (CACH 1) ===============
echo (Dam bao dien thoai dang o che do Recovery ADB Sideload)
echo Dam bao file rom can up o cung thu muc voi tool nay va duoc dat ten la "rom.zip"
echo ---
if not exist "rom.zip" (
    echo [LOI] Khong tim thay file "rom.zip" trong thu muc nay!
    echo Vui long kiem tra hoac doi ten file ROM cua ban thanh "rom.zip" roi thu lai. Hoac su dung cach 2 de
    echo keo tha chinh xac file ROM can sideload vao.
    echo.
    echo Nhan phim bat ky de thu lai...
    echo.
    pause
    goto sideload
)
echo Thiet bi dang ket noi:
adb devices
echo.
set /p confirm_side="Nhan 'Y' de xac nhan sideload rom.zip, hoac phim khac va nhan ENTER de huy: "
if /i "%confirm_side%" NEQ "Y" goto MENU

echo.
echo [*] Dang sideload rom.zip, Vui long cho...
echo [*] Trong qua trinh nay tuyet doi KHONG rut cap, TAT tool hay TAT may tinh.

adb sideload rom.zip
echo --------------------------------------------------------
echo Hoan tat qua trinh sideload!
echo Nhan phim bat ky de quay lai Menu...
pause > nul
goto MENU

:sideloadkeotha
cls
echo =============== SIDELOAD ROM zip (CACH 2) ===============
echo (Dam bao dien thoai dang o che do Recovery ADB Sideload)
echo [!] Keo tha hoac Copy duong dan file ROM can Sideload vao khung ben duoi roi nhan ENTER:
echo --------------------------------------------------------
set "rom_path="
set /p rom_path="Sideload: "

if [%rom_path%]==[] goto sideloadkeotha

set "rom_path=%rom_path:"=%"

if not exist "%rom_path%" (
    echo.
    echo [LOI] Khong tim thay file .zip tai duong dan nay!
    echo Nhan phim bat ky de thu lai...
    echo.
    pause
    goto sideloadkeotha
)

echo.
adb devices
echo.
set /p confirm_side="Nhan 'Y' de xac nhan sideload file nay, hoac phim khac de huy: "
if /i "%confirm_side%" NEQ "Y" goto MENU

echo.
echo [*] Dang sideload ROM, Vui long doi...
echo [*] Trong qua trinh nay tuyet doi KHONG rut cap, TAT tool hay TAT may tinh.

adb sideload "%rom_path%"
echo --------------------------------------------------------
echo Hoan tat qua trinh sideload!
echo Nhan phim bat ky de quay lai Menu...
pause > nul
goto MENU

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