@echo off
echo *** Unblock Games (Riot, Roblox, PointBlank) ***

:: Must be run as Administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Please run this script as Administrator.
    pause
    exit
)

:: ----------------------------------------
:: 1) Re-enable services
:: ----------------------------------------
echo [*] Re-enabling game services...
sc config vgc start= demand >nul 2>&1
sc config RiotClientServices start= demand >nul 2>&1
sc config GarenaPlatform start= demand >nul 2>&1
sc config RobloxPlayerLauncher start= demand >nul 2>&1

:: ----------------------------------------
:: 2) Restore permissions for executables
:: ----------------------------------------
echo [*] Restoring file permissions...

for %%F in (
    "C:\Riot Games\VALORANT\live\VALORANT.exe"
    "C:\Riot Games\League of Legends\LeagueClient.exe"
    "C:\Program Files (x86)\Roblox\Versions\RobloxPlayerBeta.exe"
    "C:\Program Files\Zepetto\PointBlank\PointBlank.exe"
) do (
    if exist %%~F (
        echo [+] Restoring %%~nxF ...
        icacls "%%~F" /grant Everyone:F
    )
)

:: ----------------------------------------
:: 3) Remove scheduled tasks
:: ----------------------------------------
echo [*] Removing watchdog tasks...

schtasks /delete /tn "Block_Valorant" /f >nul 2>&1
schtasks /delete /tn "Block_Roblox" /f >nul 2>&1
schtasks /delete /tn "Block_PointBlank" /f >nul 2>&1

:: ----------------------------------------
:: 4) Clean up hosts file (remove blocked entries)
:: ----------------------------------------
echo [*] Cleaning hosts file...
attrib -r -s -h %SystemRoot%\System32\drivers\etc\hosts

:: Backup original hosts file
copy %SystemRoot%\System32\drivers\etc\hosts %SystemRoot%\System32\drivers\etc\hosts.bak >nul

:: Remove blocking lines by rewriting hosts file
findstr /V /I "roblox.com valorant.com leagueoflegends.com pb.garena.in.th" %SystemRoot%\System32\drivers\etc\hosts.bak > %SystemRoot%\System32\drivers\etc\hosts

attrib +r +s +h %SystemRoot%\System32\drivers\etc\hosts

:: ----------------------------------------
:: 5) Flush DNS cache
:: ----------------------------------------
ipconfig /flushdns >nul

echo [/] Games successfully unblocked.
pause
exit
