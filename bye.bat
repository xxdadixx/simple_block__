@echo off
setlocal EnableDelayedExpansion
echo *** Starting to block Riot Games, Roblox, and PointBlank... ***

:: Check for Administrator privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Please run this script as Administrator.
    pause
    exit
)

:: Terminate running processes
echo [*] Terminating Riot, Roblox, and PointBlank processes...
:: Riot
taskkill /IM RiotClientServices.exe /F >nul 2>&1
taskkill /IM LeagueClient.exe /F >nul 2>&1
taskkill /IM VALORANT.exe /F >nul 2>&1
taskkill /IM LoR.exe /F >nul 2>&1
taskkill /IM TFT.exe /F >nul 2>&1

:: Roblox
taskkill /IM RobloxPlayerBeta.exe /F >nul 2>&1
taskkill /IM RobloxPlayerLauncher.exe /F >nul 2>&1

:: PointBlank
taskkill /IM PointBlank.exe /F >nul 2>&1
taskkill /IM PBLauncher.exe /F >nul 2>&1
taskkill /IM PB.exe /F >nul 2>&1
taskkill /IM ZepettoPB.exe /F >nul 2>&1

:: Garena
taskkill /IM Garena.exe /F >nul 2>&1
taskkill /IM GarenaMessenger.exe /F >nul 2>&1
taskkill /IM GarenaService.exe /F >nul 2>&1
taskkill /IM GarenaAgent.exe /F >nul 2>&1

:: Block known IP addresses
echo [*] Blocking known IP addresses...
:: Roblox IPs
netsh advfirewall firewall add rule name="Block Roblox IP1" dir=out action=block remoteip=128.116.0.0/16 enable=yes
netsh advfirewall firewall add rule name="Block Roblox IP2" dir=out action=block remoteip=162.125.80.0/20 enable=yes
netsh advfirewall firewall add rule name="Block Roblox IP3" dir=out action=block remoteip=209.206.0.0/16 enable=yes

:: Riot IPs
netsh advfirewall firewall add rule name="Block Riot IP1" dir=out action=block remoteip=162.249.72.0/21 enable=yes
netsh advfirewall firewall add rule name="Block Riot IP2" dir=out action=block remoteip=192.207.0.0/16 enable=yes
netsh advfirewall firewall add rule name="Block Riot IP3" dir=out action=block remoteip=104.160.131.0/24 enable=yes

:: PointBlank IPs
netsh advfirewall firewall add rule name="Block PB IP1" dir=out action=block remoteip=61.19.255.0/24 enable=yes
netsh advfirewall firewall add rule name="Block PB IP2" dir=out action=block remoteip=202.43.32.0/19 enable=yes
netsh advfirewall firewall add rule name="Block PB IP3" dir=out action=block remoteip=203.144.144.0/20 enable=yes
netsh advfirewall firewall add rule name="Block PB IP4" dir=out action=block remoteip=203.146.0.0/16 enable=yes

:: Block game ports
echo [*] Blocking game ports...
:: Riot
netsh advfirewall firewall add rule name="Block Riot Ports TCP" dir=out action=block protocol=TCP remoteport=5000-5500,7000-7999,8393-8400 enable=yes
netsh advfirewall firewall add rule name="Block Riot Ports UDP" dir=out action=block protocol=UDP remoteport=5000-5500,7000-7999,8393-8400 enable=yes

:: Roblox
netsh advfirewall firewall add rule name="Block Roblox UDP" dir=out action=block protocol=UDP remoteport=49152-65535 enable=yes

:: PointBlank
netsh advfirewall firewall add rule name="Block PB TCP Ports" dir=out action=block protocol=TCP remoteport=39190,39191,40000-50000 enable=yes
netsh advfirewall firewall add rule name="Block PB UDP Ports" dir=out action=block protocol=UDP remoteport=39190,40000-50000 enable=yes

:: Block websites via hosts file
echo [*] Blocking websites via hosts file using CMD...

:: เปลี่ยน permission ให้เขียนไฟล์ hosts ได้ (จำเป็นต้องรันเป็น admin)
attrib -r -s -h %SystemRoot%\System32\drivers\etc\hosts

echo 127.0.0.1 roblox.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 www.roblox.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 api.roblox.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 assetdelivery.roblox.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 games.roblox.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 friends.roblox.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 setup.roblox.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 clientsettings.roblox.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 riotgames.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 www.riotgames.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 leagueoflegends.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 www.leagueoflegends.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 valorant.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 www.valorant.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 playvalorant.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 legendsofruneterra.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 www.legendsofruneterra.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 teamfighttactics.leagueoflegends.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 pb.garena.in.th >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 pointblank.zepetto.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 pb-play.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 www.pb-play.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 pbpatch.playpark.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 pbpatch.true-digital.com >> %SystemRoot%\System32\drivers\etc\hosts

:: ปิด permission กลับเหมือนเดิม (optional)
attrib +r +s +h %SystemRoot%\System32\drivers\etc\hosts

echo [/] Hosts file updated successfully.

:: Block executables by known paths
echo [*] Blocking game executables...
:: Riot
set "riot1=C:\Riot Games\Riot Client\RiotClientServices.exe"
set "riot2=C:\Riot Games\VALORANT\live\VALORANT.exe"
set "riot3=C:\Riot Games\VALORANT\live\ValorantClient.exe"
set "riot4=C:\Riot Games\League of Legends\LeagueClient.exe"

:: PointBlank
set "pb1=C:\Program Files\Zepetto\PointBlank\PointBlank.exe"
set "pb2=C:\Program Files (x86)\GarenaPB\PointBlank.exe"
set "pb3=C:\Program Files (x86)\PointBlank\PointBlank.exe"
set "pb4=C:\Program Files (x86)\PointBlank\PBLauncher.exe"

for %%F in (
    "%riot1%" "%riot2%" "%riot3%" "%riot4%"
    "%pb1%" "%pb2%" "%pb3%" "%pb4%"
) do (
    if exist %%~F (
        echo [+] Found executable: %%~F
        netsh advfirewall firewall add rule name="Block %%~nxF Out" dir=out program="%%~F" action=block enable=yes
        netsh advfirewall firewall add rule name="Block %%~nxF In" dir=in program="%%~F" action=block enable=yes
    )
)

:: Flush DNS
echo [*] Flushing DNS cache...
ipconfig /flushdns >nul 2>&1
if %errorlevel% equ 0 (
    echo [/] DNS cache successfully flushed.
) else (
    echo [!] Failed to flush DNS cache.
)

echo *** Blocking of Riot Games, Roblox, and PointBlank Games is complete. ***
pause
exit
