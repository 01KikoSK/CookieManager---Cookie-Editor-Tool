@echo off
setlocal enabledelayedexpansion

:menu
cls
echo ==================================
echo CookieManager - Cookie Editor Tool
echo ==================================
echo [1] View Cookies
echo [2] Add/Edit a Cookie
echo [3] Delete a Cookie
echo [4] Exit
echo ==================================
set /p choice=Select an option [1-4]: 

if "%choice%"=="1" goto view_cookies
if "%choice%"=="2" goto edit_cookie
if "%choice%"=="3" goto delete_cookie
if "%choice%"=="4" goto exit
goto menu

:view_cookies
cls
echo --- Current Cookies ---
if exist cookies.txt (
    type cookies.txt
) else (
    echo No cookies found.
)
pause
goto menu

:edit_cookie
cls
echo --- Add/Edit a Cookie ---
set /p name=Enter cookie name: 
set /p value=Enter cookie value: 

if not exist cookies.txt echo. > cookies.txt

for /f "tokens=1,* delims==" %%A in (cookies.txt) do (
    if "%%A"=="%name%" (
        set edited=true
        echo !name!=%value% >> temp.txt
    ) else (
        echo %%A=%%B >> temp.txt
    )
)

if not defined edited echo %name%=%value% >> temp.txt
move /y temp.txt cookies.txt >nul
set edited=
echo Cookie saved successfully!
pause
goto menu

:delete_cookie
cls
echo --- Delete a Cookie ---
set /p name=Enter cookie name to delete: 

if not exist cookies.txt (
    echo No cookies found.
    pause
    goto menu
)

for /f "tokens=1,* delims==" %%A in (cookies.txt) do (
    if not "%%A"=="%name%" (
        echo %%A=%%B >> temp.txt
    )
)
move /y temp.txt cookies.txt >nul
echo Cookie deleted successfully!
pause
goto menu

:exit
endlocal
echo Goodbye!
exit
