@echo off

:: MSOutlook
:: Spotify
:: Edge

echo Deletando cache de WebApps...

for %%G in (
"Microsoft\Edge\User Data\Default\Cache\Cache_Data"
"Microsoft\Olk\EBWebView\Default\Cache\Cache_Data"
"Vivaldi\User Data\Default\Cache\Cache_Data"
"Spotify\Default\Cache\Cache_Data"
"Packages\5319275A.WhatsAppDesktop_cv1g1gvanyjgm\LocalCache\EBWebView\Default\Cache\Cache_Data"
"Packages\5319275A.51895FA4EA97F_cv1g1gvanyjgm\LocalCache\EBWebView\Default\Cache\Cache_Data"
"NVIDIA\DXCache"
"FortniteGame\Saved\Logs"
"Roblox\rbx-storage"

) do (if exist "%localappdata%\%%~G" (rd /s /q "%localappdata%\%%~G" >nul 2>&1))

echo Deletando arquivos .log...
del /f /q /s "%USERPROFILE%\*.log" >nul 2>&1

echo Deletando arquivos .tmp...
del /f /q /s "%USERPROFILE%\*.tmp" >nul 2>&1

echo Limpando pastas temporarias...
del /f /q /s "%temp%\*.*" >nul 2>&1
del /f /q /s "%windir%\temp\*.*" >nul 2>&1

echo Deletando outros arquivos extras...
del /f /s /q "%LocalAppData%\Roblox\rbx-storage.db" >nul 2>&1

echo:

echo Tudo pronto!
pause