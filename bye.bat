@echo off
echo *** Ultimate Game Blocker (Riot, Roblox, PointBlank) ***

:: Must be run as Administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Please run this script as Administrator.
    pause
    exit
)

:: ----------------------------------------
:: 1) Stop and disable services (Riot, Roblox, Garena)
:: ----------------------------------------
echo [*] Stopping game services...
sc stop vgc >nul 2>&1
sc config vgc start= disabled >nul 2>&1
sc stop RiotClientServices >nul 2>&1
sc config RiotClientServices start= disabled >nul 2>&1
sc stop GarenaPlatform >nul 2>&1
sc config GarenaPlatform start= disabled >nul 2>&1
sc stop RobloxPlayerLauncher >nul 2>&1
sc config RobloxPlayerLauncher start= disabled >nul 2>&1

:: ----------------------------------------
:: 2) Block executables by removing execution permission
:: ----------------------------------------
echo [*] Blocking executables by permissions...

for %%F in (
    "C:\Riot Games\VALORANT\live\VALORANT.exe"
    "C:\Riot Games\League of Legends\LeagueClient.exe"
    "C:\Program Files (x86)\Roblox\Versions\RobloxPlayerBeta.exe"
    "C:\Program Files\Zepetto\PointBlank\PointBlank.exe"
) do (
    if exist %%~F (
        echo [+] Blocking %%~nxF ...
        icacls "%%~F" /deny Everyone:(X)
    )
)

:: ----------------------------------------
:: 3) Create scheduled tasks to auto-kill games if launched
:: ----------------------------------------
echo [*] Creating watchdog tasks...

schtasks /create /tn "Block_Valorant"    /sc minute /mo 1 /tr "taskkill /IM VALORANT.exe /F" /ru SYSTEM /f >nul
schtasks /create /tn "Block_Roblox"      /sc minute /mo 1 /tr "taskkill /IM RobloxPlayerBeta.exe /F" /ru SYSTEM /f >nul
schtasks /create /tn "Block_PointBlank"  /sc minute /mo 1 /tr "taskkill /IM PointBlank.exe /F" /ru SYSTEM /f >nul

:: ----------------------------------------
:: 4) Block websites via hosts file
:: ----------------------------------------
echo [*] Updating hosts file...
attrib -r -s -h %SystemRoot%\System32\drivers\etc\hosts

(
echo 127.0.0.1 roblox.com
echo 127.0.0.1 www.roblox.com
echo 127.0.0.1 valorant.com
echo 127.0.0.1 www.valorant.com
echo 127.0.0.1 leagueoflegends.com
echo 127.0.0.1 pb.garena.in.th
) >> %SystemRoot%\System32\drivers\etc\hosts

attrib +r +s +h %SystemRoot%\System32\drivers\etc\hosts

:: ----------------------------------------
:: 5) Flush DNS cache
:: ----------------------------------------
ipconfig /flushdns >nul

echo [/] Game blocking complete. Please restart PC to fully apply changes.
pause
exit
