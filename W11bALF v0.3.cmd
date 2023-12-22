@echo off
chcp 65001 >nul

:: Versão
set _ver=v0.3

:: Cores
set cor=
set grn=[92m 
set bgrn=[42m
set pgrn=[102m
set red=[31m 
set inv=[7m 
set rst=[0m

:: Quantidade de etapas no modo automático
set qte=4

:: Telemetria
set taskend=schtasks /end /tn "\Microsoft
set taskchg=schtasks /change /tn "\Microsoft

:: Limpeza
set _del=del /f /s /q

:: Progresso
set prog1=call :color %grn% "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
set prog2=call :color %grn% "▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒"
set prog3=call :color %grn% "▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓"
set prog4=call :color %grn% "██████████████████████████████████████████████████████"
set progend=call :color %rst% "           " %grn% "Processo concluído com sucesso"
set progmenu=echo      Pressione qualquer tecla para voltar ao menu

:: Ajusta o tamanho da tela
set telamenu=mode con:cols=44 lines=24
set telaprocesso=mode con:cols=54 lines=22

:: Recursos
set _powershell=PowerShell -ExecutionPolicy Unrestricted -Command

:: Requisitar permissões de administrador
if not "%1"=="am_admin" (
powershell -command "Start-Process -Verb RunAs -FilePath '%0' -ArgumentList 'am_admin'"
exit /b )

::::::::::::::::::::::::::::::::::::::::::::::
::                                          ::
::		Windows11 but a little faster		::
::		github.com/rubem-psd/W11bALF		::
::											::
::::::::::::::::::::::::::::::::::::::::::::::

::Menu principal do script
:menu
%telamenu%
cls
title - W11bAlf %_ver% -
echo █▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█
echo █                                          █
call :color %rst% "█   " %inv% "▓▒░                              ░▒▓███ "
call :color %rst% "█   " %inv% "▓▒▒▒█▒█▒█▒▄█▒▄█▒▒█▄▄▒▄▀█▒█▒▒▒█▀▀▒▒▒▓███ "
call :color %rst% "█   " %inv% "▓▒▒▒▀▄▀▄▀▒▒█▒▒█▒▒█▄█▒█▀█▒█▄▄▒█▀▒▒▒▒▓███ "
call :color %rst% "█   " %inv% "▓▒░                              ░▒▓███ "
call :color %rst% "█   " %inv% "▓▒░ W11 but A Little Faster %_ver% ░▒▓███ "
call :color %rst% "█   " %inv% "▓▒░ github.com/rubem-psd/W11bALF ░▒▓███ "
call :color %rst% "█   " %inv% "▓▒░                              ░▒▓███ "
echo █                                          █
call :color %grn% "█          Escolha uma das opções          █"
echo █                                          █
echo █  ░▒▓█[1] ONE-CLICK                 █▓▒░  █
echo █  ░▒▓█[2] Serviços e Telemetria     █▓▒░  █
echo █  ░▒▓█[3] Desinstalar Bloatware     █▓▒░  █
echo █  ░▒▓█[4] Configurar o Windows      █▓▒░  █
echo ▓  ░▒▓█[5] Limpeza do Sistema        █▓▒░  ▓
echo ▓  ░▒▓█                              █▓▒░  ▓
echo ▒  ░▒▓█[6] Configs de Hibernação     █▓▒░  ▒
echo ▒  ░▒▓█[7] Limpar Imagem do Windows  █▓▒░  ▒
echo ░  ░▒▓█[8] Limpar Menu Iniciar    [^!]█▓▒░  ░
echo ░  ░▒▓█[9] Ajuda                     █▓▒░  ░  

choice /C:123456789 /N

set _erl=%errorlevel%
if %_erl%==9 call :ajuda
if %_erl%==8 call :menuiniciar
if %_erl%==7 call :imagem
if %_erl%==6 call :hibernacao
if %_erl%==5 call :limpeza
if %_erl%==4 call :configurar
if %_erl%==3 call :aplicativos
if %_erl%==2 call :servicosetelemetria
if %_erl%==1 call :oneclick

::::::::::::::::::::::::::::::::::::::::::::::::::::::
::Alteração de serviços
:servicosetelemetria
%telaprocesso%
cls
title W11bAlf %_ver% - Alterando Serviços e Reduzindo Telemetria.
echo:
echo:
call :color %rst% "  " %inv% "▓▒░                                            ░▒▓"
call :color %rst% "  " %inv% "▓▒░ Alterando Serviços e Reduzindo Telemetria. ░▒▓"
call :color %rst% "  " %inv% "▓▒░                                            ░▒▓"
echo:
::Serviços desativados
for %%G in (AJRouter,AppVClient,AssignedAccessManagerSvc,DiagTrack,DialogBlockingService,NetTcpPortSharing,RemoteAccess,RemoteRegistry,UevAgentService,shpamsvc,ssh-agent,tzautoupdate,uhssvc) do (sc config %%G start= disabled >nul 2>&1)
%prog1%

::Serviços manuais
for %%G in (ALG,AppIDSvc,AppMgmt,AppReadiness,AppXSvc,Appinfo,AxInstSV,BDESVC,BTAGService,BcastDVRUserService_dc2a4,BluetoothUserService_dc2a4,Browser,CDPSvc,COMSysApp,CaptureService_dc2a4,CertPropSvc,ClipSVC,ConsentUxUserSvc_dc2a4,CredentialEnrollmentManagerUserSvc_dc2a4,CscService,DcpSvc,DevQueryBroker,DeviceAssociationBrokerSvc_dc2a4,DeviceAssociationService,DeviceInstall,DevicePickerUserSvc_dc2a4,DevicesFlowUserSvc_dc2a4,DisplayEnhancementService,DmEnrollmentSvc,DsSvc,DsmSvc,EFS,EapHost,EntAppSvc,FDResPub,Fax,FrameServer,FrameServerMonitor,GraphicsPerfSvc,HomeGroupListener,HomeGroupProvider,HvHost,IEEtwCollectorService,IKEEXT,InstallService,InventorySvc,IpxlatCfgSvc,KtmRm,LicenseManager,LxpSvc,MSDTC,MSiSCSI,McpManagementService,MessagingService_dc2a4,MicrosoftEdgeElevationService,MixedRealityOpenXRSvc,MsKeyboardFilter,NPSMSvc_dc2a4,NaturalAuthentication,NcaSvc,NcbService,NcdAutoSetup,NetSetupSvc,Netlogon,Netman,NgcCtnrSvc,NgcSvc,NlaSvc,P9RdrService_dc2a4,PNRPAutoReg,PNRPsvc,PcaSvc,PeerDistSvc,PenService_dc2a4,PerfHost,PhoneSvc,PimIndexMaintenanceSvc_dc2a4,PlugPlay,PolicyAgent,PrintNotify,PrintWorkflowUserSvc_dc2a4,PushToInstall,QWAVE,RasAuto,RasMan,RetailDemo,RmSvc,RpcLocator,SCPolicySvc,SCardSvr,SDRSVC,SEMgrSvc,SNMPTRAP,SNMPTrap,SSDPSRV,ScDeviceEnum,SecurityHealthService,Sense,SensorDataService,SensorService,SensrSvc,SessionEnv,SharedAccess,SharedRealitySvc,SmsRouter,SstpSvc,StateRepository,StiSvc,StorSvc,TabletInputService,TapiSrv,TextInputManagementService,TieringEngineService,TimeBroker,TimeBrokerSvc,TokenBroker,TroubleshootingSvc,TrustedInstaller,UI0Detect,UdkUserSvc_dc2a4,UmRdpService,UnistoreSvc_dc2a4,UserDataSvc_dc2a4,UsoSvc,VSS,VacSvc,W32Time,WEPHOSTSVC,WFDSConMgrSvc,WMPNetworkSvc,WManSvc,WPDBusEnum,WSService,WaaSMedicSvc,WalletService,WarpJITSvc,WbioSrvc,WcsPlugInService,WdNisSvc,WdiServiceHost,WdiSystemHost,WebClient,Wecsvc,WerSvc,WiaRpc,WinHttpAutoProxySvc,WinRM,WpcMonSvc,WpnService,WwanSvc,XblAuthManager,XblGameSave,XboxGipSvc,XboxNetApiSvc,autotimesvc,bthserv,camsvc,cbdhsvc_dc2a4,cloudidsvc,dcsvc,defragsvc,diagnosticshub.standardcollector.service,diagsvc,dmwappushservice,dot3svc,edgeupdate,edgeupdatem,embeddedmode,fdPHost,fhsvc,hidserv,icssvc,lfsvc,lltdsvc,lmhosts,msiserver,netprofm,p2pimsvc,p2psvc,perceptionsimulation,pla,seclogon,smphost,spectrum,svsvc,swprv,upnphost,vds,vm3dservice,vmicguestinterface,vmicheartbeat,vmickvpexchange,vmicrdv,vmicshutdown,vmictimesync,vmicvmsession,vmicvss,vmvss,wbengine,wcncsvc,webthreatdefsvc,wercplsupport,wisvc,wlidsvc,wlpasvc,wmiApSrv,workfolderssvc,wuauserv,wudfsvc) do (sc config %%G start= demand >nul 2>&1)
%prog2%

::Serviços automáticos com delay
for %%G in (BITS,DoSvc,MapsBroker,WSearch,sppsvc,wscsvc) do (sc config %%G start= delayed-auto >nul 2>&1)

::Serviços automáticos
for %%G in (AudioEndpointBuilder,Audiosrv,BFE,BrokerInfrastructure,BthAvctpSvc,BthHFSrv,CDPUserSvc_dc2a4,CoreMessagingRegistrar,CryptSvc,DPS,DcomLaunch,Dhcp,DispBrokerDesktopSvc,Dnscache,DusmSvc,EventLog,EventSystem,FontCache,KeyIso,LSM,LanmanServer,LanmanWorkstation,MpsSvc,OneSyncSvc_dc2a4,Power,ProfSvc,RpcEptMapper,RpcSs,SENS,SamSs,Schedule,SgrmBroker,ShellHWDetection,Spooler,SysMain,SystemEventsBroker,TermService,Themes,TrkWks,UserManager,VGAuthService,VMTools,VaultSvc,Wcmsvc,WinDefend,Winmgmt,WlanSvc,WpnUserService_dc2a4,gpsvc,iphlpsvc,mpssvc,nsi,tiledatamodelsvc,webthreatdefusersvc_dc2a4) do (sc config %%G start= auto >nul 2>&1)

::Telemetria
%taskend%\Office\OfficeTelemetryAgentFallBack2016" >nul 2>&1
%taskend%\Office\OfficeTelemetryAgentLogOn2016" >nul 2>&1
%taskend%\Windows\AppID\SmartScreenSpecific" >nul 2>&1
%taskend%\Windows\Application Experience\AitAgent" >nul 2>&1
%taskend%\Windows\Application Experience\Microsoft Compatibility Appraiser" >nul 2>&1
%taskend%\Windows\Application Experience\ProgramDataUpdater" >nul 2>&1
%taskend%\Windows\Application Experience\StartupAppTask" >nul 2>&1
%taskend%\Windows\Autochk\Proxy" >nul 2>&1
%taskend%\Windows\CloudExperienceHost\CreateObjectTask" >nul 2>&1
%taskend%\Windows\Customer Experience Improvement Program\BthSQM" >nul 2>&1
%taskend%\Windows\Customer Experience Improvement Program\Consolidator" >nul 2>&1
%taskend%\Windows\Customer Experience Improvement Program\KernelCeipTask" >nul 2>&1
%taskend%\Windows\Customer Experience Improvement Program\Uploader" >nul 2>&1
%taskend%\Windows\Customer Experience Improvement Program\UsbCeip" >nul 2>&1
%taskend%\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" >nul 2>&1
%taskend%\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver" >nul 2>&1
%taskend%\Windows\DiskFootprint\Diagnostics" >nul 2>&1
%taskend%\Windows\FileHistory\File History (maintenance mode)" >nul 2>&1
%taskend%\Windows\Maintenance\WinSAT" >nul 2>&1
%taskend%\Windows\NetTrace\GatherNetworkInfo" >nul 2>&1
%taskend%\Windows\PI\Sqm-Tasks" >nul 2>&1
%taskend%\Windows\Power Efficiency Diagnostics\AnalyzeSystem" >nul 2>&1
%taskend%\Windows\Shell\FamilySafetyMonitor" >nul 2>&1
%taskend%\Windows\Shell\FamilySafetyRefresh" >nul 2>&1
%taskend%\Windows\Shell\FamilySafetyUpload" >nul 2>&1
%taskend%\Windows\Windows Error Reporting\QueueReporting" >nul 2>&1
%prog3%
%taskchg%\Office\Office 15 Subscription Heartbeat" /disable >nul 2>&1
%taskchg%\Office\OfficeTelemetryAgentFallBack" /disable >nul 2>&1
%taskchg%\Office\OfficeTelemetryAgentFallBack2016" /disable >nul 2>&1
%taskchg%\Office\OfficeTelemetryAgentLogOn" /disable >nul 2>&1
%taskchg%\Office\OfficeTelemetryAgentLogOn2016" /disable >nul 2>&1
%taskchg%\Windows\AppID\SmartScreenSpecific" /disable >nul 2>&1
%taskchg%\Windows\Application Experience\AitAgent" /disable >nul 2>&1
%taskchg%\Windows\Application Experience\Microsoft Compatibility Appraiser" /disable >nul 2>&1
%taskchg%\Windows\Application Experience\ProgramDataUpdater" /disable >nul 2>&1
%taskchg%\Windows\Application Experience\StartupAppTask" /disable >nul 2>&1
%taskchg%\Windows\Autochk\Proxy" /disable >nul 2>&1
%taskchg%\Windows\CloudExperienceHost\CreateObjectTask" /disable >nul 2>&1
%taskchg%\Windows\Customer Experience Improvement Program\BthSQM" /disable >nul 2>&1
%taskchg%\Windows\Customer Experience Improvement Program\Consolidator" /disable >nul 2>&1
%taskchg%\Windows\Customer Experience Improvement Program\KernelCeipTask" /disable >nul 2>&1
%taskchg%\Windows\Customer Experience Improvement Program\Uploader" /disable >nul 2>&1
%taskchg%\Windows\Customer Experience Improvement Program\UsbCeip" /disable >nul 2>&1
%taskchg%\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /disable >nul 2>&1
%taskchg%\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver" /disable >nul 2>&1
%taskchg%\Windows\DiskFootprint\Diagnostics" /disable >nul 2>&1
%taskchg%\Windows\FileHistory\File History (maintenance mode)" /disable >nul 2>&1
%taskchg%\Windows\Maintenance\WinSAT" /disable >nul 2>&1
%taskchg%\Windows\NetTrace\GatherNetworkInfo" /disable >nul 2>&1
%taskchg%\Windows\PI\Sqm-Tasks" /disable >nul 2>&1
%taskchg%\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /disable >nul 2>&1
%taskchg%\Windows\Shell\FamilySafetyMonitor" /disable >nul 2>&1
%taskchg%\Windows\Shell\FamilySafetyRefresh" /disable >nul 2>&1
%taskchg%\Windows\Shell\FamilySafetyUpload" /disable >nul 2>&1
%taskchg%\Windows\Time Synchronization\ForceSynchronizeTime" /disable >nul 2>&1
%taskchg%\Windows\Time Synchronization\SynchronizeTime" /disable >nul 2>&1
%taskchg%\Windows\Windows Error Reporting\QueueReporting" /disable >nul 2>&1
%taskchg%\Windows\WindowsUpdate\Automatic App Update" /disable >nul 2>&1
%prog4%
echo:
%progend%
%progmenu%
pause >nul
goto menu

::::::::::::::::::::::::::::::::::::::::::::::::::::::
::Limpar arquivos temporarios
:limpeza
%telaprocesso%
cls
title W11bAlf %_ver% - Limpeza do Sistema

echo:
call :color %rst% "             " %inv% "▓▒░                    ░▒▓"
call :color %rst% "             " %inv% "▓▒░ Limpando o Sistema ░▒▓"
call :color %rst% "             " %inv% "▓▒░                    ░▒▓"
echo:
echo      Cache do Microsoft Edge...
taskkill /F /IM "msedge.exe" >nul 2>&1
%_del% %appdata%\..\LocalLow\Microsoft\CryptnetUrlCache\Content\*.* >nul 2>&1
%_del% %appdata%\..\LocalLow\Microsoft\CryptnetUrlCache\MetaData\*.* >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\Default\GPUCache\* >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\Default\Service Worker\CacheStorage\* >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\"Guest Profile"\"File System"\*. >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\"Guest Profile"\"Platform Notifications"\*.* >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\"Guest Profile"\"Service Worker"\CacheStorage\*. >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\"Guest Profile"\Cache\Cache_Data\data*. >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\"Guest Profile"\Cache\Cache_Data\f*. >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\"Guest Profile"\Cache\Cache_Data\index. >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\"Guest Profile"\EdgeCoupons\coupons_data.db\*.ldb >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\"Guest Profile"\EdgeCoupons\coupons_data.db\*.log >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\"Guest Profile"\EdgeCoupons\coupons_data.db\index. >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\"Guest Profile"\EdgePushStorageWithWinRt\*.log >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\"Guest Profile"\GPUCache\d*. >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\"Guest Profile"\GPUCache\i*. >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\"Guest Profile"\IndexedDB\https_ntp.msn.com_0.indexeddb.leveldb\*.* >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\"File System"\*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\"Platform Notifications"\*.* /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\"Service Worker"\CacheStorage\*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\Cache\Cache_Data\data*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\Cache\Cache_Data\f*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\Cache\Cache_Data\index. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\EdgeCoupons\coupons_data.db\*.ldb /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\EdgeCoupons\coupons_data.db\*.log /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\EdgeCoupons\coupons_data.db\index. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\EdgePushStorageWithWinRt\*.log /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\GPUCache\d*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\GPUCache\i*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\IndexedDB\https_ntp.msn.com_0.indexeddb.leveldb\*.* /s /q) >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\*.pma >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\BrowserMetrics\*.pma >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\Default\"File System"\*. >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\Default\"Platform Notifications"\*.* >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\Default\"Service Worker"\CacheStorage\*. >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\Default\Cache\Cache_Data\data*. >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\Default\Cache\Cache_Data\f*. >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\Default\Cache\Cache_Data\index. >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\Default\EdgeCoupons\coupons_data.db\*.ldb >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\Default\EdgeCoupons\coupons_data.db\*.log >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\Default\EdgeCoupons\coupons_data.db\index. >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\Default\EdgePushStorageWithWinRt\*.log >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\Default\GPUCache\d*. >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\Default\GPUCache\i*. >nul 2>&1

echo      Cache do Capcut...
rd /s /q "%localappdata%\CapCut\User Data\Cache" >nul 2>&1

echo      Cache do OneDrive...
taskkill /F /IM "onedrive.exe" >nul 2>&1
%_del% "%localappdata%\Microsoft\OneDrive\setup\logs\*.odl" >nul 2>&1
%_del% "%localappdata%\Microsoft\OneDrive\setup\logs\*.aodl" >nul 2>&1
%_del% "%localappdata%\Microsoft\OneDrive\*.odl" >nul 2>&1
%_del% "%localappdata%\Microsoft\OneDrive\*.aodl" >nul 2>&1
%_del% "%localappdata%\Microsoft\OneDrive\*.otc" >nul 2>&1
%_del% "%localappdata%\OneDrive\*.qmlc" >nul 2>&1

echo      Cache da Ferramenta de captura...
%_del% "%localappdata%\Packages\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\TempState\ScreenClip\*" >nul 2>&1

echo      Cache do Internet Explorer...
%_del% "%localappdata%\Microsoft\Windows\INetCache\Low\*" >nul 2>&1
%_del% "%localappdata%\Microsoft\Windows\INetCache\IE\*" >nul 2>&1

echo      Cache do Google Chrome...
taskkill /F /IM "chrome.exe" >nul 2>&1
%_del% "C:\Program Files\Google\Chrome\Application\SetupMetrics\*.pma" >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\"Guest Profile"\"Service Worker"\CacheStorage\*. >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\"Guest Profile"\Cache\Cache_Data\data*. >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\"Guest Profile"\Cache\Cache_Data\f*. >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\"Guest Profile"\Cache\Cache_Data\index. >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\"Guest Profile"\GPUCache\d*. >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\"Guest Profile"\GPUCache\i*. >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\"Guest Profile"\History-journal*. >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\"Guest Profile"\JumpListIconsRecentClosed\*.tmp >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\"Guest Profile"\Storage\data_*. >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\"Guest Profile"\Storage\index*. >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Profile %%i"\"Service Worker"\CacheStorage\*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Profile %%i"\Cache\Cache_Data\data*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Profile %%i"\Cache\Cache_Data\f*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Profile %%i"\Cache\Cache_Data\index. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Profile %%i"\GPUCache\d*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Profile %%i"\GPUCache\i*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Profile %%i"\History-journal*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Profile %%i"\JumpListIconsRecentClosed\*.tmp /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Profile %%i"\Storage\data_*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Profile %%i"\Storage\index*. /s /q) >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\BrowserMetrics*.pma >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\crash*.pma >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\Default\"Service Worker"\CacheStorage\*. >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\Default\"Service Worker"\Database\*.log >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\Default\"Service Worker"\ScriptCache\*. >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\Default\Cache\Cache_Data\data*. >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\Default\Cache\Cache_Data\f*. >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\Default\Cache\Cache_Data\index. >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\Default\GPUCache\d*. >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\Default\GPUCache\i*. >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\Default\History-journal*. >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\Default\JumpListIconsRecentClosed\*.tmp >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\Default\Storage\data_*. >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\Default\Storage\index*. >nul 2>&1

echo      Cache do Brave Browser...
taskkill /F /IM "brave.exe" >nul 2>&1
del C:\Program Files\BraveSoftware\Brave-Browser\Application\SetupMetrics\*.pma >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\"Guest Profile"\"Service Worker"\CacheStorage\*. >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\"Guest Profile"\"Service Worker"\Database\*.log >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\"Guest Profile"\"Service Worker"\ScriptCache\*. >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\"Guest Profile"\Cache\Cache_Data\data*. >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\"Guest Profile"\Cache\Cache_Data\f*. >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\"Guest Profile"\Cache\Cache_Data\index. >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\"Guest Profile"\GPUCache\d*. >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\"Guest Profile"\GPUCache\i*. >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\"Guest Profile"\History-journal*. >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\"Guest Profile"\JumpListIconsRecentClosed\*.tmp >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\"Guest Profile"\Storage\data_*. >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\"Guest Profile"\Storage\index*. >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\BrowserMetrics*.pma >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\crash*.pma >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\Default\"Service Worker"\CacheStorage\*. >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\Default\"Service Worker"\Database\*.log >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\Default\"Service Worker"\ScriptCache\*. >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\Default\Cache\Cache_Data\data*. >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\Default\Cache\Cache_Data\f*. >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\Default\Cache\Cache_Data\index. >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\Default\GPUCache\d*. >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\Default\GPUCache\i*. >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\Default\History-journal*. >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\Default\JumpListIconsRecentClosed\*.tmp >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\Default\Storage\data_*. >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\Default\Storage\index*. >nul 2>&1

echo      Cache do Vivaldi...
taskkill /F /IM "vivaldi.exe" >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\"Guest Profile"\"Service Worker"\CacheStorage\*. >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\"Guest Profile"\"Service Worker"\Database\*.log /s /q >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\"Guest Profile"\"Service Worker"\ScriptCache\*. >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\"Guest Profile"\Cache\Cache_Data\data*. >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\"Guest Profile"\Cache\Cache_Data\f*. >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\"Guest Profile"\Cache\Cache_Data\index. >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\"Guest Profile"\GPUCache\d*. >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\"Guest Profile"\GPUCache\i*. >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\"Guest Profile"\History-journal*. >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\"Guest Profile"\JumpListIconsRecentClosed\*.tmp >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\"Guest Profile"\Storage\data_*. >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\"Guest Profile"\Storage\index*. >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\BrowserMetrics*.pma >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\crash*.pma >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\Default\"Service Worker"\CacheStorage\*. >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\Default\"Service Worker"\Database\*.log /s /q  >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\Default\"Service Worker"\ScriptCache\*. >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\Default\Cache\Cache_Data\data*. >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\Default\Cache\Cache_Data\f*. >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\Default\Cache\Cache_Data\index. >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\Default\GPUCache\d*. >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\Default\GPUCache\i*. >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\Default\History-journal*. >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\Default\JumpListIconsRecentClosed\*.tmp >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\Default\Storage\data_*. >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\Default\Storage\index*. >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Vivaldi\"User Data"\"Profile %%i"\"Service Worker"\CacheStorage\*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Vivaldi\"User Data"\"Profile %%i"\"Service Worker"\Database\*.log /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Vivaldi\"User Data"\"Profile %%i"\"Service Worker"\ScriptCache\*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Vivaldi\"User Data"\"Profile %%i"\Cache\Cache_Data\data*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Vivaldi\"User Data"\"Profile %%i"\Cache\Cache_Data\f*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Vivaldi\"User Data"\"Profile %%i"\Cache\Cache_Data\index. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Vivaldi\"User Data"\"Profile %%i"\GPUCache\d*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Vivaldi\"User Data"\"Profile %%i"\GPUCache\i*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Vivaldi\"User Data"\"Profile %%i"\History-journal*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Vivaldi\"User Data"\"Profile %%i"\JumpListIconsRecentClosed\*.tmp /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Vivaldi\"User Data"\"Profile %%i"\Storage\data_*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Vivaldi\"User Data"\"Profile %%i"\Storage\index*. /s /q) >nul 2>&1

echo      Cache do Spotify...
%_del% %localappdata%\Spotify\Data\*.file >nul 2>&1
%_del% %localappdata%\Spotify\Browser\Cache\"Cache_Data"\f*. >nul 2>&1
%_del% %localappdata%\Spotify\Browser\GPUCache\*. >nul 2>&1

echo      Cache da Adobe...
for /d %%F in (C:\Users\*) do del %%F\AppData\Roaming\Adobe\Common\"Media Cache files"\*.* /s /q >nul 2>&1

echo      Limpando pastas de drivers...
rd /s /q %SYSTEMDRIVE%\AMD >nul 2>&1
rd /s /q %SYSTEMDRIVE%\NVIDIA >nul 2>&1
rd /s /q %SYSTEMDRIVE%\INTEL >nul 2>&1

echo      Executando limpeza nativa do sistema...
%_del% %LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db >nul 2>&1
%_del% %LocalAppData%\Microsoft\Windows\Explorer\iconcache_*.db >nul 2>&1
%_del% %ProgramData%\Microsoft\Windows Defender\Support\*.* >nul 2>&1
set sageset=reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\
%sageset%Active Setup Temp Folders" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%BranchCache" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%D3D Shader Cache" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Delivery Optimization Files" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Device Driver Packages" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Diagnostic Data Viewer database files" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Downloaded Program Files" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Feedback Hub Archive log files" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Internet Cache Files" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Language Pack" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Offline Pages Files" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Old ChkDsk Files" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Previous Installations" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Recycle Bin" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%RetailDemo Offline Content" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Service Pack Cleanup" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Setup Log Files" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%System error memory dump files" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%System error minidump files" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Temporary Files" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Temporary Setup Files" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Temporary Sync Files" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Thumbnail Cache" /v "StateFlags0064" /t REG_DWORD /d "0" /f >nul 2>&1
%sageset%Update Cleanup" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Upgrade Discarded Files" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%User file versions" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Windows Defender" /v "StateFlags0064" /t REG_DWORD /d "0" /f >nul 2>&1
%sageset%Windows Error Reporting Files" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Windows ESD installation files" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Windows Upgrade Log Files" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
cleanmgr /sagerun:64
echo:
%progend%
%progmenu%
pause >nul
goto menu

::::::::::::::::::::::::::::::::::::::::::::::::::::::
::Remover Apps e Configurar o Windows
:aplicativos
%telaprocesso%
cls
title W11bAlf %_ver% - Removendo Apps e Configurando o Windows.
echo:
echo:
call :color %rst% "   " %inv% "▓▒░                                          ░▒▓"
call :color %rst% "   " %inv% "▓▒░   Removendo Aplicativos Pré-Instalados   ░▒▓"
call :color %rst% "   " %inv% "▓▒░                                          ░▒▓"
echo:
%prog1%
chcp 437 > nul
%_powershell% "Get-WindowsPackage -Online | Where PackageName -like *MediaPlayer* | Remove-WindowsPackage -Online -NoRestart" >nul 2>&1
%_powershell% "Get-WindowsPackage -Online | Where PackageName -like *Hello-Face* | Remove-WindowsPackage -Online -NoRestart" >nul 2>&1
%_powershell% "Get-WindowsPackage -Online | Where PackageName -like *WordPad* | Remove-WindowsPackage -Online -NoRestart" >nul 2>&1
%_powershell% "Get-WindowsPackage -Online | Where PackageName -like *TabletPCMath* | Remove-WindowsPackage -Online -NoRestart" >nul 2>&1
%prog2%
sc stop "XblAuthManager" >nul 2>&1
sc config "XblAuthManager" start= disabled >nul 2>&1
sc stop "XblGameSave" >nul 2>&1
sc config "XblGameSave" start= disabled >nul 2>&1
sc stop "XboxNetApiSvc" >nul 2>&1
sc config "XboxNetApiSvc" start= disabled >nul 2>&1
%_powershell% "Get-AppxPackage '46928bounde.EclipseManager' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage '7EE7776C.LinkedInforWindows' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage '9E2F88E3.Twitter' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'ActiproSoftwareLLC.562882FEEB491' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'AdobeSystemIncorporated.AdobePhotoshop' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'ClearChannelRadioDigital.iHeartRadio' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Clipchamp.Clipchamp' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'D5EA27B7.Duolingo-LearnLanguagesforFree' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Flipboard.Flipboard' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'king.com.CandyCrushSaga' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'king.com.CandyCrushSodaSaga' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.3DBuilder' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.549981C3F5F10' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.Advertising.Xaml' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.Appconnector' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.BingFinance' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.BingFoodAndDrink' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.BingNews' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.BingSports' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.BingTranslator' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.BingTravel' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.BingWeather' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.CommsPhone' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.GetHelp' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.Getstarted' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.GroupMe10' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.ConnectivityStore' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.FreshPaint' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.Messaging' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.Microsoft3DViewer' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.MicrosoftOfficeHub' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.MicrosoftPowerBIForWindows' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.MicrosoftSolitaireCollection' | Remove-AppxPackage" >nul 2>&1
%prog3%
%_powershell% "Get-AppxPackage 'Microsoft.MicrosoftStickyNotes' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.MinecraftUWP' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.MixedReality.Portal' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.NetworkSpeedTest' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.Office.OneNote' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.Office.Sway' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.OfficeLens' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.OneConnect' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.People' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.PowerAutomateDesktop' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.Print3D' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.SkypeApp' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.Todos' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.Wallet' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.Windows.Phone' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.WindowsFeedbackHub' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.WindowsMaps' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.WindowsPhone' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.Xbox.TCUI' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.XboxApp' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.XboxGameOverlay' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.XboxGamingOverlay' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.XboxIdentityProvider' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.XboxSpeechToTextOverlay' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.YourPhone' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.ZuneVideo' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'MicrosoftWindows.Client.CBS' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'PandoraMediaInc.29680B314EFC2' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'ShazamEntertainmentLtd.Shazam' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'SpotifyAB.SpotifyMusic' | Remove-AppxPackage" >nul 2>&1
winget uninstall cortana --accept-source-agreements >nul 2>&1
TASKKILL /f /im OneDrive.exe >nul 2>&1
%SystemRoot%\System32\OneDriveSetup.exe /uninstall >nul 2>&1
%systemroot%\SysWOW64\OneDriveSetup.exe /uninstall >nul 2>&1
chcp 65001 > nul
%prog4%
echo:
%progend%
%progmenu%
pause >nul
goto menu

::::::::::::::::::::::::::::::::::::::::::::::::::::::
::Configurar o Windows
:configurar
%telaprocesso%
cls
title W11bAlf %_ver% - Configurando o Windows.
echo:
echo:
call :color %rst% "   " %inv% "▓▒░                                          ░▒▓"
call :color %rst% "   " %inv% "▓▒░          Configurando o Windows          ░▒▓"
call :color %rst% "   " %inv% "▓▒░                                          ░▒▓"
echo:
%prog1%
reg add "HKCU\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve  >nul 2>&1
reg add "HKCU\Software\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\InputPersonalization\TrainedDataStore" /v "HarvestContacts" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicy" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" /v "HasAccepted" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps" /v "AgentActivationEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\CPSS\Store\InkingAndTypingPersonalization" /v "Value" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /v "ShowedToastAtLevel" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds\DSB" /v "ShowDynamicContent" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SearchSettings" /v "IsAADCloudSearchEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SearchSettings" /v "IsDeviceSearchHistoryEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SearchSettings" /v "IsDynamicSearchBoxEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SearchSettings" /v "IsMSACloudSearchEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Control Panel\International\User Profile" /v HttpAcceptLanguageOptOut /t REG_DWORD /d 0x00000001 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v AllowAutoGameMode /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v UseNexusForGameBarEnabled /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Input\Settings" /v EnableHwkbTextPrediction /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Input\Settings" /v MultilingualEnabled /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Input\Settings\proc_1\loc_0409\im_1" /v Prediction /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\MediaPlayer\Preferences" /v UsageTracking /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v OemPreInstalledAppsEnabled /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v PreInstalledAppsEnabled /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v PreInstalledAppsEverEnabled /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SilentInstalledAppsEnabled /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SoftLandingEnabled /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-310093Enabled /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-314563Enabled /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338389Enabled /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338393Enabled /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-353694Enabled /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-353696Enabled /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-353698Enabled /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SystemPaneSuggestionsEnabled /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSyncProviderNotifications /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" /v DisableAutoPlay /t REG_DWORD /d 0x00000001 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v ScoobeSystemSettingEnabled /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v Value /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v Value /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\System\Maps" /v AutoUpdateEnabled /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v "Value" /t REG_SZ /d "Deny" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack\EventTranscriptKey" /v "EnableEventTranscript" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "MaxTelemetryAllowed" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v DontOfferThroughWUAU /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "UploadUserActivities" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger" /v "Start" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "JPEGImportQuality" /t "REG_DWORD" /d "100" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableSearchBoxSuggestions" /t REG_DWORD /d 1 /f >nul 2>&1
%prog2%
::Ajustes Visuais
Reg Add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d "3" /f >nul 2>&1
Reg Add "HKCU\Control Panel\Desktop" /v "DragFullWindows" /t REG_SZ /d "1" /f >nul 2>&1
Reg Add "HKCU\Control Panel\Desktop" /v "FontSmoothing" /t REG_SZ /d "2" /f >nul 2>&1
Reg Add "HKCU\Control Panel\Desktop" /v "UserPreferencesMask" /t REG_BINARY /d "9012038010000000" /f >nul 2>&1
Reg Add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d "0" /f >nul 2>&1
Reg Add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d "0" /f >nul 2>&1
Reg Add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "IconsOnly" /t REG_DWORD /d "0" /f >nul 2>&1
Reg Add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d "1" /f >nul 2>&1
Reg Add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewAlphaSelect" /t REG_DWORD /d "1" /f >nul 2>&1
Reg Add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewShadow" /t REG_DWORD /d "0" /f >nul 2>&1
Reg Add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "NavPaneExpandToCurrentFolder" /t REG_DWORD /d "1" /f >nul 2>&1
Reg Add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "NavPaneShowAllFolders" /t REG_DWORD /d "0" /f >nul 2>&1
Reg Add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAnimations" /t REG_DWORD /d "0" /f >nul 2>&1
Reg Add "HKCU\Software\Microsoft\Windows\DWM" /v "AlwaysHibernateThumbnails" /t REG_DWORD /d "0" /f >nul 2>&1
Reg Add "HKCU\Software\Microsoft\Windows\DWM" /v "EnableAeroPeek" /t REG_DWORD /d "0" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "SystemUsesLightTheme" /t REG_DWORD /d "0" /f >nul 2>&1

%prog3%
::Desativar sincronização de configurações
Reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" /v "SyncPolicy" /t Reg_DWORD /d "5" /f >nul 2>&1
Reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Accessibility" /v "Enabled" /t Reg_DWORD /d "0" /f >nul 2>&1
Reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\AppSync" /v "Enabled" /t Reg_DWORD /d "0" /f >nul 2>&1
Reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\BrowserSettings" /v "Enabled" /t Reg_DWORD /d "0" /f >nul 2>&1
Reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Credentials" /v "Enabled" /t Reg_DWORD /d ""0"" /f >nul 2>&1
Reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\DesktopTheme" /v "Enabled" /t Reg_DWORD /d "0" /f >nul 2>&1
Reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Language" /v "Enabled" /t Reg_DWORD /d "0" /f >nul 2>&1
Reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\PackageState" /v "Enabled" /t Reg_DWORD /d "0" /f >nul 2>&1
Reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Personalization" /v "Enabled" /t Reg_DWORD /d "0" /f >nul 2>&1
Reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\StartLayout" /v "Enabled" /t Reg_DWORD /d "0" /f >nul 2>&1
Reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Windows" /v "Enabled" /t Reg_DWORD /d "0" /f >nul 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSync" /t Reg_DWORD /d "2" /f >nul 2>&1 >nul 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSyncUserOverride" /t Reg_DWORD /d "1" /f >nul 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableAppSyncSettingSync" /t Reg_DWORD /d "2" /f >nul 2>&1 >nul 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableAppSyncSettingSyncUserOverride" /t Reg_DWORD /d "1" /f >nul 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableApplicationSettingSync" /t Reg_DWORD /d "2" /f >nul 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableApplicationSettingSyncUserOverride" /t Reg_DWORD /d "1" /f >nul 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableCredentialsSettingSync" /t Reg_DWORD /d "2" /f >nul 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableCredentialsSettingSyncUserOverride" /t Reg_DWORD /d "2" /f >nul 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableDesktopThemeSettingSync" /t Reg_DWORD /d "2" /f >nul 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableDesktopThemeSettingSyncUserOverride" /t Reg_DWORD /d "2" /f >nul 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisablePersonalizationSettingSync" /t Reg_DWORD /d "2" /f  >nul 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisablePersonalizationSettingSyncUserOverride" /t Reg_DWORD /d "2" /f >nul 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableStartLayoutSettingSync" /t Reg_DWORD /d "2" /f >nul 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableStartLayoutSettingSyncUserOverride" /t Reg_DWORD /d "2" /f >nul 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSyncOnPaidNetwork" /t Reg_DWORD /d "2" /f >nul 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWebBrowserSettingSync" /t Reg_DWORD /d "2" /f >nul 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWebBrowserSettingSyncUserOverride" /t Reg_DWORD /d "2" /f >nul 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWindowsSettingSync" /t Reg_DWORD /d "2" /f >nul 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWindowsSettingSyncUserOverride" /t Reg_DWORD /d "2" /f >nul 2>&1

::Reiniciar o Explorer
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 2 >nul 2>&1
start explorer.exe  >nul 2>&1
timeout /t 2 >nul 2>&1
%prog4%
echo:
%progend%
%progmenu%
pause >nul
goto menu

::::::::::::::::::::::::::::::::::::::::::::::::::::::
::Limpar Imagem do Windows
:imagem
%telaprocesso%
cls
title W11bAlf %_ver% - Limpando Imagem do Windows
echo:
echo:
call :color %rst% "          " %inv% "▓▒░                            ░▒▓"
call :color %rst% "          " %inv% "▓▒░ Limpando Imagem do Windows ░▒▓"
call :color %rst% "          " %inv% "▓▒░                            ░▒▓"
echo:
echo    Esse é um processo LENTO mas que pode te garantir
echo    mais espaço livre em sua unidade de armazenamento
echo:
echo     ^(Enquanto a barra abaixo estiver piscando, a
echo    limpeza está acontecendo e o script não travou^)
echo                          ...
Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase >nul 2>&1
cls
echo:
echo:
call :color %rst% "          " %inv% "▓▒░                            ░▒▓"
call :color %rst% "          " %inv% "▓▒░ Limpando Imagem do Windows ░▒▓"
call :color %rst% "          " %inv% "▓▒░                            ░▒▓"
echo:
%progend%
%progmenu%
pause >nul
goto menu

::::::::::::::::::::::::::::::::::::::::::::::::::::::
::Desfixar aplicativos do menu iniciar

:menuiniciar
%telaprocesso%
cls
title W11bAlf %_ver% - Limpar Menu Iniciar e Barra de Tarefas
echo:
echo:
call :color %rst% "    " %inv% "▓▒░                                        ░▒▓"
call :color %rst% "    " %inv% "▓▒░ Limpar Menu Iniciar e Barra de Tarefas ░▒▓"
call :color %rst% "    " %inv% "▓▒░                                        ░▒▓"
echo:
echo    Recomendado para novas instalações do Windows
echo:
echo    Isso irá desfixar todos os ícones do Menu Iniciar
echo    e todos os ícones adicionais da barra de tarefas
echo:
call :color %grn% "   Pressione qualquer tecla para iniciar o processo"
call :color %red% "   Para cancelar, basta fechar e reabrir o script"
pause >nul
goto onoroff

:onoroff
cls
title W11bAlf %_ver% - Checando conexão com a internet
echo:
echo:
call :color %rst% "    " %rst% "▓▒░   VERIFICANDO CONEXÃO COM A INTERNET   ░▒▓"
ping www.google.com -n 2 -w 1000 >nul 2>&1
if %errorlevel%==0 goto internetok
if %errorlevel%==1 goto internetoff

:internetok
goto menuiniciarstart

:internetoff
%telaprocesso%
cls
title W11bAlf %_ver% - Sem Conexão com a Internet
echo:
echo:
call :color %rst% "    " %red% "▓▒░              SEM CONEXÃO               ░▒▓"
call :color %rst% "    " %inv% "▓▒░                                        ░▒▓"
call :color %rst% "    " %inv% "▓▒░       Limpando Barra de Tarefas.       ░▒▓"
call :color %rst% "    " %inv% "▓▒░                                        ░▒▓"
echo:
echo     Existe algum problema na conexão com a internet
echo     Não será possível limpar o Menu Iniciar
echo:
echo     ^> Desfixando ícones da Barra de Tarefas   
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" /v "FavoritesResolve" /t REG_BINARY /d "350300004c0000000114020000000000c000000000000046830080002000000059069b06e532da0191f89f06e532da015cf4e1fbd161d801970100000000000001000000000000000000000000000000a0013a001f80c827341f105c1042aa032ee45287d668260001002600efbe1200000019ce53dce432da0159069b06e532da01a9749d06e532da01140056003100000000009457a10c11005461736b42617200400009000400efbe9457a10c9457a10c2e00000096bd01000000010000000000000000000000000000006f7a23015400610073006b00420061007200000016000e01320097010000a754662a200046494c4545587e312e4c4e4b00007c0009000400efbe9457a10c9457a10c2e00000097bd0100000001000000000000000000520000000000a413a200460069006c00650020004500780070006c006f007200650072002e006c006e006b00000040007300680065006c006c00330032002e0064006c006c002c002d003200320030003600370000001c00220000001e00efbe02005500730065007200500069006e006e006500640000001c00120000002b00efbe91f89f06e532da011c00420000001d00efbe02004d006900630072006f0073006f00660074002e00570069006e0064006f00770073002e004500780070006c006f0072006500720000001c0000009e0000001c000000010000001c0000002d000000000000009d0000001100000003000000681b0d141000000000433a5c55736572735c57313162414c465c417070446174615c526f616d696e675c4d6963726f736f66745c496e7465726e6574204578706c6f7265725c517569636b204c61756e63685c557365722050696e6e65645c5461736b4261725c46696c65204578706c6f7265722e6c6e6b000060000000030000a058000000000000006465736b746f702d68656a6f68356500c4aa4634b9e6d54696c8e2c6142c721c9de0b1b3d79eee11bb5b000c29acfb30c4aa4634b9e6d54696c8e2c6142c721c9de0b1b3d79eee11bb5b000c29acfb3045000000090000a03900000031535053b1166d44ad8d7048a748402ea43d788c1d000000680000000048000000a326bfe44d439e438b9a711debf92c62000000000000000000000000e80200004c0000000114020000000000c00000000000004683008000200000005510a506e532da015510a506e532da01fe85aefce332da0186090000000000000100000000000000000000000000000052013a001f80c827341f105c1042aa032ee45287d668260001002600efbe1200000019ce53dce432da0159069b06e532da015510a506e532da01140056003100000000009457a10c11005461736b42617200400009000400efbe9457a10c9457a10c2e00000096bd01000000010000000000000000000000000000006f7a23015400610073006b0042006100720000001600c0003200860900009457b10b20004d4943524f537e312e4c4e4b0000560009000400efbe9457a10c9457a10c2e00000099bd0100000001000000000000000000000000000000028d0d004d006900630072006f0073006f0066007400200045006400670065002e006c006e006b0000001c00220000001e00efbe02005500730065007200500069006e006e006500640000001c00120000002b00efbe5510a506e532da011c001a0000001d00efbe02004d005300450064006700650000001c0000009f0000001c000000010000001c0000002d000000000000009e0000001100000003000000681b0d141000000000433a5c55736572735c57313162414c465c417070446174615c526f616d696e675c4d6963726f736f66745c496e7465726e6574204578706c6f7265725c517569636b204c61756e63685c557365722050696e6e65645c5461736b4261725c4d6963726f736f667420456467652e6c6e6b000060000000030000a058000000000000006465736b746f702d68656a6f68356500c4aa4634b9e6d54696c8e2c6142c721c9ee0b1b3d79eee11bb5b000c29acfb30c4aa4634b9e6d54696c8e2c6142c721c9ee0b1b3d79eee11bb5b000c29acfb3045000000090000a03900000031535053b1166d44ad8d7048a748402ea43d788c1d000000680000000048000000a326bfe44d439e438b9a711debf92c62000000000000000000000000" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" /v "Favorites" /t REG_BINARY /d "00a40100003a001f80c827341f105c1042aa032ee45287d668260001002600efbe1200000019ce53dce432da0159069b06e532da01a9749d06e532da01140056003100000000009457a10c11005461736b42617200400009000400efbe9457a10c9457a10c2e00000096bd01000000010000000000000000000000000000006f7a23015400610073006b00420061007200000016001201320097010000a754662a200046494c4545587e312e4c4e4b00007c0009000400efbe9457a10c9457a10c2e00000097bd0100000001000000000000000000520000000000a413a200460069006c00650020004500780070006c006f007200650072002e006c006e006b00000040007300680065006c006c00330032002e0064006c006c002c002d003200320030003600370000001c00120000002b00efbe91f89f06e532da011c00420000001d00efbe02004d006900630072006f0073006f00660074002e00570069006e0064006f00770073002e004500780070006c006f0072006500720000001c00260000001e00efbe0200530079007300740065006d00500069006e006e006500640000001c00000000560100003a001f80c827341f105c1042aa032ee45287d668260001002600efbe1200000019ce53dce432da0159069b06e532da015510a506e532da01140056003100000000009457a10c11005461736b42617200400009000400efbe9457a10c9457a10c2e00000096bd01000000010000000000000000000000000000006f7a23015400610073006b0042006100720000001600c4003200860900009457b10b20004d4943524f537e312e4c4e4b0000560009000400efbe9457a10c9457a10c2e00000099bd0100000001000000000000000000000000000000028d0d004d006900630072006f0073006f0066007400200045006400670065002e006c006e006b0000001c00120000002b00efbe5510a506e532da011c001a0000001d00efbe02004d005300450064006700650000001c00260000001e00efbe0200530079007300740065006d00500069006e006e006500640000001c000000ff" /f >nul 2>&1
echo:
call :color %grn% "    Ícones desfixados com sucesso!"
echo     Pressione qualquer tecla para voltar ao menu
pause >nul
goto menu

:menuiniciarstart
%telaprocesso%
cls
title W11bAlf %_ver% - Desfixando aplicativos do menu iniciar
echo:
echo:
call :color %rst% "   " %grn% "▓▒░                CONEXÃO OK                ░▒▓"
call :color %rst% "   " %inv% "▓▒░                                          ░▒▓"
call :color %rst% "   " %inv% "▓▒░ Limpando Menu Iniciar e Barra de Tarefas ░▒▓"
call :color %rst% "   " %inv% "▓▒░                                          ░▒▓"
echo:
echo     ^> Desfixando ícones da Barra de Tarefas        
::Remove os ícones adicionais da barra de tarefas
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" /v "FavoritesResolve" /t REG_BINARY /d "350300004c0000000114020000000000c000000000000046830080002000000059069b06e532da0191f89f06e532da015cf4e1fbd161d801970100000000000001000000000000000000000000000000a0013a001f80c827341f105c1042aa032ee45287d668260001002600efbe1200000019ce53dce432da0159069b06e532da01a9749d06e532da01140056003100000000009457a10c11005461736b42617200400009000400efbe9457a10c9457a10c2e00000096bd01000000010000000000000000000000000000006f7a23015400610073006b00420061007200000016000e01320097010000a754662a200046494c4545587e312e4c4e4b00007c0009000400efbe9457a10c9457a10c2e00000097bd0100000001000000000000000000520000000000a413a200460069006c00650020004500780070006c006f007200650072002e006c006e006b00000040007300680065006c006c00330032002e0064006c006c002c002d003200320030003600370000001c00220000001e00efbe02005500730065007200500069006e006e006500640000001c00120000002b00efbe91f89f06e532da011c00420000001d00efbe02004d006900630072006f0073006f00660074002e00570069006e0064006f00770073002e004500780070006c006f0072006500720000001c0000009e0000001c000000010000001c0000002d000000000000009d0000001100000003000000681b0d141000000000433a5c55736572735c57313162414c465c417070446174615c526f616d696e675c4d6963726f736f66745c496e7465726e6574204578706c6f7265725c517569636b204c61756e63685c557365722050696e6e65645c5461736b4261725c46696c65204578706c6f7265722e6c6e6b000060000000030000a058000000000000006465736b746f702d68656a6f68356500c4aa4634b9e6d54696c8e2c6142c721c9de0b1b3d79eee11bb5b000c29acfb30c4aa4634b9e6d54696c8e2c6142c721c9de0b1b3d79eee11bb5b000c29acfb3045000000090000a03900000031535053b1166d44ad8d7048a748402ea43d788c1d000000680000000048000000a326bfe44d439e438b9a711debf92c62000000000000000000000000e80200004c0000000114020000000000c00000000000004683008000200000005510a506e532da015510a506e532da01fe85aefce332da0186090000000000000100000000000000000000000000000052013a001f80c827341f105c1042aa032ee45287d668260001002600efbe1200000019ce53dce432da0159069b06e532da015510a506e532da01140056003100000000009457a10c11005461736b42617200400009000400efbe9457a10c9457a10c2e00000096bd01000000010000000000000000000000000000006f7a23015400610073006b0042006100720000001600c0003200860900009457b10b20004d4943524f537e312e4c4e4b0000560009000400efbe9457a10c9457a10c2e00000099bd0100000001000000000000000000000000000000028d0d004d006900630072006f0073006f0066007400200045006400670065002e006c006e006b0000001c00220000001e00efbe02005500730065007200500069006e006e006500640000001c00120000002b00efbe5510a506e532da011c001a0000001d00efbe02004d005300450064006700650000001c0000009f0000001c000000010000001c0000002d000000000000009e0000001100000003000000681b0d141000000000433a5c55736572735c57313162414c465c417070446174615c526f616d696e675c4d6963726f736f66745c496e7465726e6574204578706c6f7265725c517569636b204c61756e63685c557365722050696e6e65645c5461736b4261725c4d6963726f736f667420456467652e6c6e6b000060000000030000a058000000000000006465736b746f702d68656a6f68356500c4aa4634b9e6d54696c8e2c6142c721c9ee0b1b3d79eee11bb5b000c29acfb30c4aa4634b9e6d54696c8e2c6142c721c9ee0b1b3d79eee11bb5b000c29acfb3045000000090000a03900000031535053b1166d44ad8d7048a748402ea43d788c1d000000680000000048000000a326bfe44d439e438b9a711debf92c62000000000000000000000000" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" /v "Favorites" /t REG_BINARY /d "00a40100003a001f80c827341f105c1042aa032ee45287d668260001002600efbe1200000019ce53dce432da0159069b06e532da01a9749d06e532da01140056003100000000009457a10c11005461736b42617200400009000400efbe9457a10c9457a10c2e00000096bd01000000010000000000000000000000000000006f7a23015400610073006b00420061007200000016001201320097010000a754662a200046494c4545587e312e4c4e4b00007c0009000400efbe9457a10c9457a10c2e00000097bd0100000001000000000000000000520000000000a413a200460069006c00650020004500780070006c006f007200650072002e006c006e006b00000040007300680065006c006c00330032002e0064006c006c002c002d003200320030003600370000001c00120000002b00efbe91f89f06e532da011c00420000001d00efbe02004d006900630072006f0073006f00660074002e00570069006e0064006f00770073002e004500780070006c006f0072006500720000001c00260000001e00efbe0200530079007300740065006d00500069006e006e006500640000001c00000000560100003a001f80c827341f105c1042aa032ee45287d668260001002600efbe1200000019ce53dce432da0159069b06e532da015510a506e532da01140056003100000000009457a10c11005461736b42617200400009000400efbe9457a10c9457a10c2e00000096bd01000000010000000000000000000000000000006f7a23015400610073006b0042006100720000001600c4003200860900009457b10b20004d4943524f537e312e4c4e4b0000560009000400efbe9457a10c9457a10c2e00000099bd0100000001000000000000000000000000000000028d0d004d006900630072006f0073006f0066007400200045006400670065002e006c006e006b0000001c00120000002b00efbe5510a506e532da011c001a0000001d00efbe02004d005300450064006700650000001c00260000001e00efbe0200530079007300740065006d00500069006e006e006500640000001c000000ff" /f >nul 2>&1
echo     ^> Limpando Menu Iniciar
::Limpa o Menu Iniciar
curl -o %localappdata%\Packages\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\LocalState\start2.bin https://raw.githubusercontent.com/rubem-psd/W11bALF/main/Recursos/start2.bin >nul 2>&1
timeout /t 2 >nul 2>&1
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 2 >nul 2>&1
start explorer.exe >nul 2>&1
timeout /t 2 >nul 2>&1
echo:
%progend%
%progmenu%
pause >nul
cls
goto menu


::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::

:oneclick
mode con:cols=54 lines=24
cls
title W11bAlf %_ver% - One-Click
echo:
echo:
call :color %rst% "       " %inv% "▓▒░                                  ░▒▓"
call :color %rst% "       " %inv% "▓▒░           W11bALF %_ver%           ░▒▓"
call :color %rst% "       " %inv% "▓▒░                                  ░▒▓"
call :color %rst% "       " %inv% "▓▒░░█▀█░█▄░█ █▀▀░░░█▀▀░█░░░█░█▀▀░█▄▀░░▒▓"
call :color %rst% "       " %inv% "▓▒░░█▄█░█░▀█ ██▄░░░█▄▄░█▄▄░█░█▄▄░█░█░░▒▓"
call :color %rst% "       " %inv% "▓▒░                                  ░▒▓"
call :color %rst% "       " %inv% "▓▒░░░░░░░░░░ ONE CLICK MODE ░░░░░░░░░░▒▓"
call :color %rst% "       " %inv% "▓▒░                                  ░▒▓"
echo:
echo:
echo    O modo One Click irá automaticamente realizar os
echo    seguintes processos:
echo:
echo    - Alterarar a inicialização de serviços
echo    - Reduzir a Telemetria
echo    - Configurar o Windows e Remover Bloat
echo    - Limpar o Windows
echo:
call :color %grn% "   Pressione qualquer tecla para iniciar o processo"
call :color %red% "   Para cancelar, basta fechar e reabrir o script"
pause >nul
goto oneclickstart

::::::::::::::::::::::::::::::::::::::::::::::::::::::

:oneclickstart
%telaprocesso%
cls
title W11bAlf %_ver% - One-Click
echo:
echo:
call :color %rst% "              " %inv% "▓▒░                    ░▒▓"
call :color %rst% "              " %inv% "▓▒░ Etapa 1/%qte% iniciada ░▒▓"
call :color %rst% "              " %inv% "▓▒░                    ░▒▓"
echo:
echo          Alterando inicialização dos serviços
echo:
%prog1%
for %%G in (AJRouter,AppVClient,AssignedAccessManagerSvc,DiagTrack,DialogBlockingService,NetTcpPortSharing,RemoteAccess,RemoteRegistry,UevAgentService,shpamsvc,ssh-agent,tzautoupdate,uhssvc) do (sc config %%G start= disabled >nul 2>&1)
for %%G in (ALG,AppIDSvc,AppMgmt,AppReadiness,AppXSvc,Appinfo,AxInstSV,BDESVC,BTAGService,BcastDVRUserService_dc2a4,BluetoothUserService_dc2a4,Browser,CDPSvc,COMSysApp,CaptureService_dc2a4,CertPropSvc,ClipSVC,ConsentUxUserSvc_dc2a4,CredentialEnrollmentManagerUserSvc_dc2a4,CscService,DcpSvc,DevQueryBroker,DeviceAssociationBrokerSvc_dc2a4,DeviceAssociationService,DeviceInstall,DevicePickerUserSvc_dc2a4,DevicesFlowUserSvc_dc2a4,DisplayEnhancementService,DmEnrollmentSvc,DsSvc,DsmSvc,EFS,EapHost,EntAppSvc,FDResPub,Fax,FrameServer,FrameServerMonitor,GraphicsPerfSvc,HomeGroupListener,HomeGroupProvider,HvHost,IEEtwCollectorService,IKEEXT,InstallService,InventorySvc,IpxlatCfgSvc,KtmRm,LicenseManager,LxpSvc,MSDTC,MSiSCSI,McpManagementService,MessagingService_dc2a4,MicrosoftEdgeElevationService,MixedRealityOpenXRSvc,MsKeyboardFilter,NPSMSvc_dc2a4,NaturalAuthentication,NcaSvc,NcbService,NcdAutoSetup,NetSetupSvc,Netlogon,Netman,NgcCtnrSvc,NgcSvc,NlaSvc,P9RdrService_dc2a4,PNRPAutoReg,PNRPsvc,PcaSvc,PeerDistSvc,PenService_dc2a4,PerfHost,PhoneSvc,PimIndexMaintenanceSvc_dc2a4,PlugPlay,PolicyAgent,PrintNotify,PrintWorkflowUserSvc_dc2a4,PushToInstall,QWAVE,RasAuto,RasMan,RetailDemo,RmSvc,RpcLocator,SCPolicySvc,SCardSvr,SDRSVC,SEMgrSvc,SNMPTRAP,SNMPTrap,SSDPSRV,ScDeviceEnum,SecurityHealthService,Sense,SensorDataService,SensorService,SensrSvc,SessionEnv,SharedAccess,SharedRealitySvc,SmsRouter,SstpSvc,StateRepository,StiSvc,StorSvc,TabletInputService,TapiSrv,TextInputManagementService,TieringEngineService,TimeBroker,TimeBrokerSvc,TokenBroker,TroubleshootingSvc,TrustedInstaller,UI0Detect,UdkUserSvc_dc2a4,UmRdpService,UnistoreSvc_dc2a4,UserDataSvc_dc2a4,UsoSvc,VSS,VacSvc,W32Time,WEPHOSTSVC,WFDSConMgrSvc,WMPNetworkSvc,WManSvc,WPDBusEnum,WSService,WaaSMedicSvc,WalletService,WarpJITSvc,WbioSrvc,WcsPlugInService,WdNisSvc,WdiServiceHost,WdiSystemHost,WebClient,Wecsvc,WerSvc,WiaRpc,WinHttpAutoProxySvc,WinRM,WpcMonSvc,WpnService,WwanSvc,XblAuthManager,XblGameSave,XboxGipSvc,XboxNetApiSvc,autotimesvc,bthserv,camsvc,cbdhsvc_dc2a4,cloudidsvc,dcsvc,defragsvc,diagnosticshub.standardcollector.service,diagsvc,dmwappushservice,dot3svc,edgeupdate,edgeupdatem,embeddedmode,fdPHost,fhsvc,hidserv,icssvc,lfsvc,lltdsvc,lmhosts,msiserver,netprofm,p2pimsvc,p2psvc,perceptionsimulation,pla,seclogon,smphost,spectrum,svsvc,swprv,upnphost,vds,vm3dservice,vmicguestinterface,vmicheartbeat,vmickvpexchange,vmicrdv,vmicshutdown,vmictimesync,vmicvmsession,vmicvss,vmvss,wbengine,wcncsvc,webthreatdefsvc,wercplsupport,wisvc,wlidsvc,wlpasvc,wmiApSrv,workfolderssvc,wuauserv,wudfsvc) do (sc config %%G start= demand >nul 2>&1)
%prog2%
for %%G in (BITS,DoSvc,MapsBroker,WSearch,sppsvc,wscsvc) do (sc config %%G start= delayed-auto >nul 2>&1)
%prog3%
for %%G in (AudioEndpointBuilder,Audiosrv,BFE,BrokerInfrastructure,BthAvctpSvc,BthHFSrv,CDPUserSvc_dc2a4,CoreMessagingRegistrar,CryptSvc,DPS,DcomLaunch,Dhcp,DispBrokerDesktopSvc,Dnscache,DusmSvc,EventLog,EventSystem,FontCache,KeyIso,LSM,LanmanServer,LanmanWorkstation,MpsSvc,OneSyncSvc_dc2a4,Power,ProfSvc,RpcEptMapper,RpcSs,SENS,SamSs,Schedule,SgrmBroker,ShellHWDetection,Spooler,SysMain,SystemEventsBroker,TermService,Themes,TrkWks,UserManager,VGAuthService,VMTools,VaultSvc,Wcmsvc,WinDefend,Winmgmt,WlanSvc,WpnUserService_dc2a4,gpsvc,iphlpsvc,mpssvc,nsi,tiledatamodelsvc,webthreatdefusersvc_dc2a4) do (sc config %%G start= auto >nul 2>&1)
%prog4%
echo:
call :color %grn% "            Etapa 1/%qte% concluída com sucesso"
echo                  Iniciando etapa 2/%qte%
echo                          ...
timeout /t 3 >nul
cls
echo:
echo:
call :color %rst% "              " %inv% "▓▒░                    ░▒▓"
call :color %rst% "              " %inv% "▓▒░ Etapa 2/%qte% iniciada ░▒▓"
call :color %rst% "              " %inv% "▓▒░                    ░▒▓"
echo:
echo                 Reduzindo  Telemetria
echo:
%prog1%
%taskend%\Office\OfficeTelemetryAgentFallBack2016" >nul 2>&1
%taskend%\Office\OfficeTelemetryAgentLogOn2016" >nul 2>&1
%taskend%\Windows\AppID\SmartScreenSpecific" >nul 2>&1
%taskend%\Windows\Application Experience\AitAgent" >nul 2>&1
%taskend%\Windows\Application Experience\Microsoft Compatibility Appraiser" >nul 2>&1
%taskend%\Windows\Application Experience\ProgramDataUpdater" >nul 2>&1
%taskend%\Windows\Application Experience\StartupAppTask" >nul 2>&1
%taskend%\Windows\Autochk\Proxy" >nul 2>&1
%taskend%\Windows\CloudExperienceHost\CreateObjectTask" >nul 2>&1
%taskend%\Windows\Customer Experience Improvement Program\BthSQM" >nul 2>&1
%taskend%\Windows\Customer Experience Improvement Program\Consolidator" >nul 2>&1
%taskend%\Windows\Customer Experience Improvement Program\KernelCeipTask" >nul 2>&1
%taskend%\Windows\Customer Experience Improvement Program\Uploader" >nul 2>&1
%taskend%\Windows\Customer Experience Improvement Program\UsbCeip" >nul 2>&1
%taskend%\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" >nul 2>&1
%taskend%\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver" >nul 2>&1
%taskend%\Windows\DiskFootprint\Diagnostics" >nul 2>&1
%prog2%
%taskend%\Windows\FileHistory\File History (maintenance mode)" >nul 2>&1
%taskend%\Windows\Maintenance\WinSAT" >nul 2>&1
%taskend%\Windows\NetTrace\GatherNetworkInfo" >nul 2>&1
%taskend%\Windows\PI\Sqm-Tasks" >nul 2>&1
%taskend%\Windows\Power Efficiency Diagnostics\AnalyzeSystem" >nul 2>&1
%taskend%\Windows\Shell\FamilySafetyMonitor" >nul 2>&1
%taskend%\Windows\Shell\FamilySafetyRefresh" >nul 2>&1
%taskend%\Windows\Shell\FamilySafetyUpload" >nul 2>&1
%taskend%\Windows\Windows Error Reporting\QueueReporting" >nul 2>&1
%taskchg%\Office\Office 15 Subscription Heartbeat" /disable >nul 2>&1
%taskchg%\Office\OfficeTelemetryAgentFallBack" /disable >nul 2>&1
%taskchg%\Office\OfficeTelemetryAgentFallBack2016" /disable >nul 2>&1
%taskchg%\Office\OfficeTelemetryAgentLogOn" /disable >nul 2>&1
%taskchg%\Office\OfficeTelemetryAgentLogOn2016" /disable >nul 2>&1
%taskchg%\Windows\AppID\SmartScreenSpecific" /disable >nul 2>&1
%taskchg%\Windows\Application Experience\AitAgent" /disable >nul 2>&1
%taskchg%\Windows\Application Experience\Microsoft Compatibility Appraiser" /disable >nul 2>&1
%taskchg%\Windows\Application Experience\ProgramDataUpdater" /disable >nul 2>&1
%taskchg%\Windows\Application Experience\StartupAppTask" /disable >nul 2>&1
%prog3%
%taskchg%\Windows\Autochk\Proxy" /disable >nul 2>&1
%taskchg%\Windows\CloudExperienceHost\CreateObjectTask" /disable >nul 2>&1
%taskchg%\Windows\Customer Experience Improvement Program\BthSQM" /disable >nul 2>&1
%taskchg%\Windows\Customer Experience Improvement Program\Consolidator" /disable >nul 2>&1
%taskchg%\Windows\Customer Experience Improvement Program\KernelCeipTask" /disable >nul 2>&1
%taskchg%\Windows\Customer Experience Improvement Program\Uploader" /disable >nul 2>&1
%taskchg%\Windows\Customer Experience Improvement Program\UsbCeip" /disable >nul 2>&1
%taskchg%\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /disable >nul 2>&1
%taskchg%\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver" /disable >nul 2>&1
%taskchg%\Windows\DiskFootprint\Diagnostics" /disable >nul 2>&1
%taskchg%\Windows\FileHistory\File History (maintenance mode)" /disable >nul 2>&1
%taskchg%\Windows\Maintenance\WinSAT" /disable >nul 2>&1
%taskchg%\Windows\NetTrace\GatherNetworkInfo" /disable >nul 2>&1
%taskchg%\Windows\PI\Sqm-Tasks" /disable >nul 2>&1
%taskchg%\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /disable >nul 2>&1
%taskchg%\Windows\Shell\FamilySafetyMonitor" /disable >nul 2>&1
%taskchg%\Windows\Shell\FamilySafetyRefresh" /disable >nul 2>&1
%taskchg%\Windows\Shell\FamilySafetyUpload" /disable >nul 2>&1
%taskchg%\Windows\Time Synchronization\ForceSynchronizeTime" /disable >nul 2>&1
%taskchg%\Windows\Time Synchronization\SynchronizeTime" /disable >nul 2>&1
%taskchg%\Windows\Windows Error Reporting\QueueReporting" /disable >nul 2>&1
%taskchg%\Windows\WindowsUpdate\Automatic App Update" /disable >nul 2>&1
%prog4%
echo:
call :color %grn% "            Etapa 2/%qte% concluída com sucesso"
echo                  Iniciando etapa 3/%qte%
echo                          ...
timeout /t 3 >nul
cls
echo:
echo:
call :color %rst% "              " %inv% "▓▒░                    ░▒▓"
call :color %rst% "              " %inv% "▓▒░ Etapa 3/%qte% iniciada ░▒▓"
call :color %rst% "              " %inv% "▓▒░                    ░▒▓"
echo:
echo       Removendo Apps e Configurando o Windows...
echo:
%prog1%
chcp 437 > nul
%_powershell% "Get-WindowsPackage -Online | Where PackageName -like *MediaPlayer* | Remove-WindowsPackage -Online -NoRestart" >nul 2>&1
%_powershell% "Get-WindowsPackage -Online | Where PackageName -like *Hello-Face* | Remove-WindowsPackage -Online -NoRestart" >nul 2>&1
%_powershell% "Get-WindowsPackage -Online | Where PackageName -like *WordPad* | Remove-WindowsPackage -Online -NoRestart" >nul 2>&1
%_powershell% "Get-WindowsPackage -Online | Where PackageName -like *TabletPCMath* | Remove-WindowsPackage -Online -NoRestart" >nul 2>&1
%prog2%
sc stop "XblAuthManager" >nul 2>&1
sc config "XblAuthManager" start= disabled >nul 2>&1
sc stop "XblGameSave" >nul 2>&1
sc config "XblGameSave" start= disabled >nul 2>&1
sc stop "XboxNetApiSvc" >nul 2>&1
sc config "XboxNetApiSvc" start= disabled >nul 2>&1
%_powershell% "Get-AppxPackage '46928bounde.EclipseManager' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage '7EE7776C.LinkedInforWindows' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage '9E2F88E3.Twitter' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'ActiproSoftwareLLC.562882FEEB491' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'AdobeSystemIncorporated.AdobePhotoshop' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'ClearChannelRadioDigital.iHeartRadio' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Clipchamp.Clipchamp' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'D5EA27B7.Duolingo-LearnLanguagesforFree' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Flipboard.Flipboard' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'king.com.CandyCrushSaga' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'king.com.CandyCrushSodaSaga' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.3DBuilder' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.549981C3F5F10' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.Advertising.Xaml' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.Appconnector' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.BingFinance' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.BingFoodAndDrink' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.BingNews' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.BingSports' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.BingTranslator' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.BingTravel' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.BingWeather' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.CommsPhone' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.GetHelp' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.Getstarted' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.GroupMe10' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.ConnectivityStore' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.FreshPaint' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.Messaging' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.Microsoft3DViewer' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.MicrosoftOfficeHub' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.MicrosoftPowerBIForWindows' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.MicrosoftSolitaireCollection' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.MicrosoftStickyNotes' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.MinecraftUWP' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.MixedReality.Portal' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.NetworkSpeedTest' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.Office.OneNote' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.Office.Sway' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.OfficeLens' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.OneConnect' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.People' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.PowerAutomateDesktop' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.Print3D' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.SkypeApp' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.Todos' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.Wallet' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.Windows.Phone' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.WindowsFeedbackHub' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.WindowsMaps' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.WindowsPhone' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.Xbox.TCUI' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.XboxApp' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.XboxGameOverlay' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.XboxGamingOverlay' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.XboxIdentityProvider' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.XboxSpeechToTextOverlay' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.YourPhone' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'Microsoft.ZuneVideo' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'MicrosoftWindows.Client.CBS' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'PandoraMediaInc.29680B314EFC2' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'ShazamEntertainmentLtd.Shazam' | Remove-AppxPackage" >nul 2>&1
%_powershell% "Get-AppxPackage 'SpotifyAB.SpotifyMusic' | Remove-AppxPackage" >nul 2>&1
winget uninstall cortana --accept-source-agreements >nul 2>&1
TASKKILL /f /im OneDrive.exe >nul 2>&1
%SystemRoot%\System32\OneDriveSetup.exe /uninstall >nul 2>&1
%systemroot%\SysWOW64\OneDriveSetup.exe /uninstall >nul 2>&1
chcp 65001 > nul
%prog3%
reg add "HKCU\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve  >nul 2>&1
reg add "HKCU\Software\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\InputPersonalization\TrainedDataStore" /v "HarvestContacts" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicy" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" /v "HasAccepted" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps" /v "AgentActivationEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\CPSS\Store\InkingAndTypingPersonalization" /v "Value" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /v "ShowedToastAtLevel" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds\DSB" /v "ShowDynamicContent" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SearchSettings" /v "IsAADCloudSearchEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SearchSettings" /v "IsDeviceSearchHistoryEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SearchSettings" /v "IsDynamicSearchBoxEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SearchSettings" /v "IsMSACloudSearchEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Control Panel\International\User Profile" /v HttpAcceptLanguageOptOut /t REG_DWORD /d 0x00000001 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v AllowAutoGameMode /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v UseNexusForGameBarEnabled /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Input\Settings" /v EnableHwkbTextPrediction /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Input\Settings" /v MultilingualEnabled /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Input\Settings\proc_1\loc_0409\im_1" /v Prediction /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\MediaPlayer\Preferences" /v UsageTracking /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v OemPreInstalledAppsEnabled /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v PreInstalledAppsEnabled /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v PreInstalledAppsEverEnabled /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SilentInstalledAppsEnabled /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SoftLandingEnabled /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-310093Enabled /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-314563Enabled /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338389Enabled /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338393Enabled /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-353694Enabled /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-353696Enabled /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-353698Enabled /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SystemPaneSuggestionsEnabled /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSyncProviderNotifications /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" /v DisableAutoPlay /t REG_DWORD /d 0x00000001 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v ScoobeSystemSettingEnabled /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v Value /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v Value /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\Maps" /v AutoUpdateEnabled /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v "Value" /t REG_SZ /d "Deny" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack\EventTranscriptKey" /v "EnableEventTranscript" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "MaxTelemetryAllowed" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v DontOfferThroughWUAU /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "UploadUserActivities" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 0x00000000 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger" /v "Start" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "JPEGImportQuality" /t "REG_DWORD" /d "100" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableSearchBoxSuggestions" /t REG_DWORD /d 1 /f >nul 2>&1

::Ajustes Visuais
Reg Add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d "3" /f >nul 2>&1
Reg Add "HKCU\Control Panel\Desktop" /v "DragFullWindows" /t REG_SZ /d "1" /f >nul 2>&1
Reg Add "HKCU\Control Panel\Desktop" /v "FontSmoothing" /t REG_SZ /d "2" /f >nul 2>&1
Reg Add "HKCU\Control Panel\Desktop" /v "UserPreferencesMask" /t REG_BINARY /d "9012038010000000" /f >nul 2>&1
Reg Add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d "0" /f >nul 2>&1
Reg Add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d "0" /f >nul 2>&1
Reg Add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "IconsOnly" /t REG_DWORD /d "0" /f >nul 2>&1
Reg Add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d "1" /f >nul 2>&1
Reg Add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewAlphaSelect" /t REG_DWORD /d "1" /f >nul 2>&1
Reg Add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewShadow" /t REG_DWORD /d "0" /f >nul 2>&1
Reg Add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "NavPaneExpandToCurrentFolder" /t REG_DWORD /d "1" /f >nul 2>&1
Reg Add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "NavPaneShowAllFolders" /t REG_DWORD /d "0" /f >nul 2>&1
Reg Add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAnimations" /t REG_DWORD /d "0" /f >nul 2>&1
Reg Add "HKCU\Software\Microsoft\Windows\DWM" /v "AlwaysHibernateThumbnails" /t REG_DWORD /d "0" /f >nul 2>&1
Reg Add "HKCU\Software\Microsoft\Windows\DWM" /v "EnableAeroPeek" /t REG_DWORD /d "0" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "SystemUsesLightTheme" /t REG_DWORD /d "0" /f >nul 2>&1

::Desativar sincronização de configurações
Reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" /v "SyncPolicy" /t Reg_DWORD /d "5" /f >nul 2>&1
Reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Accessibility" /v "Enabled" /t Reg_DWORD /d "0" /f >nul 2>&1
Reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\AppSync" /v "Enabled" /t Reg_DWORD /d "0" /f >nul 2>&1
Reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\BrowserSettings" /v "Enabled" /t Reg_DWORD /d "0" /f >nul 2>&1
Reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Credentials" /v "Enabled" /t Reg_DWORD /d ""0"" /f >nul 2>&1
Reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\DesktopTheme" /v "Enabled" /t Reg_DWORD /d "0" /f >nul 2>&1
Reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Language" /v "Enabled" /t Reg_DWORD /d "0" /f >nul 2>&1
Reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\PackageState" /v "Enabled" /t Reg_DWORD /d "0" /f >nul 2>&1
Reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Personalization" /v "Enabled" /t Reg_DWORD /d "0" /f >nul 2>&1
Reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\StartLayout" /v "Enabled" /t Reg_DWORD /d "0" /f >nul 2>&1
Reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Windows" /v "Enabled" /t Reg_DWORD /d "0" /f >nul 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSync" /t Reg_DWORD /d "2" /f >nul 2>&1 >nul 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSyncUserOverride" /t Reg_DWORD /d "1" /f >nul 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableAppSyncSettingSync" /t Reg_DWORD /d "2" /f >nul 2>&1 >nul 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableAppSyncSettingSyncUserOverride" /t Reg_DWORD /d "1" /f >nul 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableApplicationSettingSync" /t Reg_DWORD /d "2" /f >nul 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableApplicationSettingSyncUserOverride" /t Reg_DWORD /d "1" /f >nul 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableCredentialsSettingSync" /t Reg_DWORD /d "2" /f >nul 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableCredentialsSettingSyncUserOverride" /t Reg_DWORD /d "2" /f >nul 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableDesktopThemeSettingSync" /t Reg_DWORD /d "2" /f >nul 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableDesktopThemeSettingSyncUserOverride" /t Reg_DWORD /d "2" /f >nul 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisablePersonalizationSettingSync" /t Reg_DWORD /d "2" /f  >nul 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisablePersonalizationSettingSyncUserOverride" /t Reg_DWORD /d "2" /f >nul 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableStartLayoutSettingSync" /t Reg_DWORD /d "2" /f >nul 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableStartLayoutSettingSyncUserOverride" /t Reg_DWORD /d "2" /f >nul 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSyncOnPaidNetwork" /t Reg_DWORD /d "2" /f >nul 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWebBrowserSettingSync" /t Reg_DWORD /d "2" /f >nul 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWebBrowserSettingSyncUserOverride" /t Reg_DWORD /d "2" /f >nul 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWindowsSettingSync" /t Reg_DWORD /d "2" /f >nul 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWindowsSettingSyncUserOverride" /t Reg_DWORD /d "2" /f >nul 2>&1

%prog4%
echo:
call :color %grn% "            Etapa 3/%qte% concluída com sucesso"
echo                  Iniciando etapa 4/%qte%
echo                          ...
timeout /t 3 >nul
cls
echo:
echo:
call :color %rst% "              " %inv% "▓▒░                    ░▒▓"
call :color %rst% "              " %inv% "▓▒░ Etapa 4/%qte% iniciada ░▒▓"
call :color %rst% "              " %inv% "▓▒░                    ░▒▓"
echo:
echo                  Limpando o Windows
echo:
%prog1%
taskkill /F /IM "msedge.exe" >nul 2>&1
%_del% %appdata%\..\LocalLow\Microsoft\CryptnetUrlCache\Content\*.* >nul 2>&1
%_del% %appdata%\..\LocalLow\Microsoft\CryptnetUrlCache\MetaData\*.* >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\Default\GPUCache\* >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\Default\Service Worker\CacheStorage\* >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\"Guest Profile"\"File System"\*. >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\"Guest Profile"\"Platform Notifications"\*.* >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\"Guest Profile"\"Service Worker"\CacheStorage\*. >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\"Guest Profile"\Cache\Cache_Data\data*. >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\"Guest Profile"\Cache\Cache_Data\f*. >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\"Guest Profile"\Cache\Cache_Data\index. >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\"Guest Profile"\EdgeCoupons\coupons_data.db\*.ldb >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\"Guest Profile"\EdgeCoupons\coupons_data.db\*.log >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\"Guest Profile"\EdgeCoupons\coupons_data.db\index. >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\"Guest Profile"\EdgePushStorageWithWinRt\*.log >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\"Guest Profile"\GPUCache\d*. >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\"Guest Profile"\GPUCache\i*. >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\"Guest Profile"\IndexedDB\https_ntp.msn.com_0.indexeddb.leveldb\*.* >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\"File System"\*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\"Platform Notifications"\*.* /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\"Service Worker"\CacheStorage\*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\Cache\Cache_Data\data*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\Cache\Cache_Data\f*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\Cache\Cache_Data\index. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\EdgeCoupons\coupons_data.db\*.ldb /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\EdgeCoupons\coupons_data.db\*.log /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\EdgeCoupons\coupons_data.db\index. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\EdgePushStorageWithWinRt\*.log /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\GPUCache\d*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\GPUCache\i*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\IndexedDB\https_ntp.msn.com_0.indexeddb.leveldb\*.* /s /q) >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\*.pma >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\BrowserMetrics\*.pma >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\Default\"File System"\*. >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\Default\"Platform Notifications"\*.* >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\Default\"Service Worker"\CacheStorage\*. >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\Default\Cache\Cache_Data\data*. >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\Default\Cache\Cache_Data\f*. >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\Default\Cache\Cache_Data\index. >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\Default\EdgeCoupons\coupons_data.db\*.ldb >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\Default\EdgeCoupons\coupons_data.db\*.log >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\Default\EdgeCoupons\coupons_data.db\index. >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\Default\EdgePushStorageWithWinRt\*.log >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\Default\GPUCache\d*. >nul 2>&1
%_del% %localappdata%\Microsoft\Edge\"User Data"\Default\GPUCache\i*. >nul 2>&1

rd /s /q "%localappdata%\CapCut\User Data\Cache" >nul 2>&1

taskkill /F /IM "onedrive.exe" >nul 2>&1
%_del% "%localappdata%\Microsoft\OneDrive\setup\logs\*.odl" >nul 2>&1
%_del% "%localappdata%\Microsoft\OneDrive\setup\logs\*.aodl" >nul 2>&1
%_del% "%localappdata%\Microsoft\OneDrive\*.odl" >nul 2>&1
%_del% "%localappdata%\Microsoft\OneDrive\*.aodl" >nul 2>&1
%_del% "%localappdata%\Microsoft\OneDrive\*.otc" >nul 2>&1
%_del% "%localappdata%\OneDrive\*.qmlc" >nul 2>&1

%_del% "%localappdata%\Packages\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\TempState\ScreenClip\*" >nul 2>&1

%_del% "%localappdata%\Microsoft\Windows\INetCache\Low\*" >nul 2>&1
%_del% "%localappdata%\Microsoft\Windows\INetCache\IE\*" >nul 2>&1

taskkill /F /IM "chrome.exe" >nul 2>&1
%_del% "C:\Program Files\Google\Chrome\Application\SetupMetrics\*.pma" >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\"Guest Profile"\"Service Worker"\CacheStorage\*. >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\"Guest Profile"\Cache\Cache_Data\data*. >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\"Guest Profile"\Cache\Cache_Data\f*. >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\"Guest Profile"\Cache\Cache_Data\index. >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\"Guest Profile"\GPUCache\d*. >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\"Guest Profile"\GPUCache\i*. >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\"Guest Profile"\History-journal*. >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\"Guest Profile"\JumpListIconsRecentClosed\*.tmp >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\"Guest Profile"\Storage\data_*. >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\"Guest Profile"\Storage\index*. >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Profile %%i"\"Service Worker"\CacheStorage\*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Profile %%i"\Cache\Cache_Data\data*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Profile %%i"\Cache\Cache_Data\f*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Profile %%i"\Cache\Cache_Data\index. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Profile %%i"\GPUCache\d*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Profile %%i"\GPUCache\i*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Profile %%i"\History-journal*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Profile %%i"\JumpListIconsRecentClosed\*.tmp /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Profile %%i"\Storage\data_*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Profile %%i"\Storage\index*. /s /q) >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\BrowserMetrics*.pma >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\crash*.pma >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\Default\"Service Worker"\CacheStorage\*. >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\Default\"Service Worker"\Database\*.log >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\Default\"Service Worker"\ScriptCache\*. >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\Default\Cache\Cache_Data\data*. >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\Default\Cache\Cache_Data\f*. >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\Default\Cache\Cache_Data\index. >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\Default\GPUCache\d*. >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\Default\GPUCache\i*. >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\Default\History-journal*. >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\Default\JumpListIconsRecentClosed\*.tmp >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\Default\Storage\data_*. >nul 2>&1
%_del% %localappdata%\Google\Chrome\"User Data"\Default\Storage\index*. >nul 2>&1
%prog2%

taskkill /F /IM "brave.exe" >nul 2>&1
del C:\Program Files\BraveSoftware\Brave-Browser\Application\SetupMetrics\*.pma >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\"Guest Profile"\"Service Worker"\CacheStorage\*. >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\"Guest Profile"\"Service Worker"\Database\*.log >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\"Guest Profile"\"Service Worker"\ScriptCache\*. >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\"Guest Profile"\Cache\Cache_Data\data*. >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\"Guest Profile"\Cache\Cache_Data\f*. >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\"Guest Profile"\Cache\Cache_Data\index. >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\"Guest Profile"\GPUCache\d*. >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\"Guest Profile"\GPUCache\i*. >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\"Guest Profile"\History-journal*. >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\"Guest Profile"\JumpListIconsRecentClosed\*.tmp >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\"Guest Profile"\Storage\data_*. >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\"Guest Profile"\Storage\index*. >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\BrowserMetrics*.pma >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\crash*.pma >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\Default\"Service Worker"\CacheStorage\*. >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\Default\"Service Worker"\Database\*.log >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\Default\"Service Worker"\ScriptCache\*. >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\Default\Cache\Cache_Data\data*. >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\Default\Cache\Cache_Data\f*. >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\Default\Cache\Cache_Data\index. >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\Default\GPUCache\d*. >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\Default\GPUCache\i*. >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\Default\History-journal*. >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\Default\JumpListIconsRecentClosed\*.tmp >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\Default\Storage\data_*. >nul 2>&1
%_del% %localappdata%\BraveSoftware\Brave-Browser\"User Data"\Default\Storage\index*. >nul 2>&1

taskkill /F /IM "vivaldi.exe" >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\"Guest Profile"\"Service Worker"\CacheStorage\*. >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\"Guest Profile"\"Service Worker"\Database\*.log /s /q >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\"Guest Profile"\"Service Worker"\ScriptCache\*. >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\"Guest Profile"\Cache\Cache_Data\data*. >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\"Guest Profile"\Cache\Cache_Data\f*. >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\"Guest Profile"\Cache\Cache_Data\index. >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\"Guest Profile"\GPUCache\d*. >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\"Guest Profile"\GPUCache\i*. >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\"Guest Profile"\History-journal*. >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\"Guest Profile"\JumpListIconsRecentClosed\*.tmp >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\"Guest Profile"\Storage\data_*. >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\"Guest Profile"\Storage\index*. >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\BrowserMetrics*.pma >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\crash*.pma >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\Default\"Service Worker"\CacheStorage\*. >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\Default\"Service Worker"\Database\*.log /s /q  >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\Default\"Service Worker"\ScriptCache\*. >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\Default\Cache\Cache_Data\data*. >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\Default\Cache\Cache_Data\f*. >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\Default\Cache\Cache_Data\index. >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\Default\GPUCache\d*. >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\Default\GPUCache\i*. >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\Default\History-journal*. >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\Default\JumpListIconsRecentClosed\*.tmp >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\Default\Storage\data_*. >nul 2>&1
%_del% %localappdata%\Vivaldi\"User Data"\Default\Storage\index*. >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Vivaldi\"User Data"\"Profile %%i"\"Service Worker"\CacheStorage\*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Vivaldi\"User Data"\"Profile %%i"\"Service Worker"\Database\*.log /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Vivaldi\"User Data"\"Profile %%i"\"Service Worker"\ScriptCache\*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Vivaldi\"User Data"\"Profile %%i"\Cache\Cache_Data\data*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Vivaldi\"User Data"\"Profile %%i"\Cache\Cache_Data\f*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Vivaldi\"User Data"\"Profile %%i"\Cache\Cache_Data\index. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Vivaldi\"User Data"\"Profile %%i"\GPUCache\d*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Vivaldi\"User Data"\"Profile %%i"\GPUCache\i*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Vivaldi\"User Data"\"Profile %%i"\History-journal*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Vivaldi\"User Data"\"Profile %%i"\JumpListIconsRecentClosed\*.tmp /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Vivaldi\"User Data"\"Profile %%i"\Storage\data_*. /s /q) >nul 2>&1
for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Vivaldi\"User Data"\"Profile %%i"\Storage\index*. /s /q) >nul 2>&1

%_del% %localappdata%\Spotify\Data\*.file >nul 2>&1
%_del% %localappdata%\Spotify\Browser\Cache\"Cache_Data"\f*. >nul 2>&1
%_del% %localappdata%\Spotify\Browser\GPUCache\*. >nul 2>&1

for /d %%F in (C:\Users\*) do del %%F\AppData\Roaming\Adobe\Common\"Media Cache files"\*.* /s /q >nul 2>&1

%prog3%

rd /s /q %SYSTEMDRIVE%\AMD >nul 2>&1
rd /s /q %SYSTEMDRIVE%\NVIDIA >nul 2>&1
rd /s /q %SYSTEMDRIVE%\INTEL >nul 2>&1

%_del% %LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db >nul 2>&1
%_del% %LocalAppData%\Microsoft\Windows\Explorer\iconcache_*.db >nul 2>&1
%_del% %ProgramData%\Microsoft\Windows Defender\Support\*.* >nul 2>&1
set sageset=reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\
%sageset%Active Setup Temp Folders" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%BranchCache" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%D3D Shader Cache" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Delivery Optimization Files" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Device Driver Packages" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Diagnostic Data Viewer database files" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Downloaded Program Files" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Feedback Hub Archive log files" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Internet Cache Files" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Language Pack" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Offline Pages Files" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Old ChkDsk Files" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Previous Installations" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Recycle Bin" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%RetailDemo Offline Content" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Service Pack Cleanup" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Setup Log Files" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%System error memory dump files" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%System error minidump files" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Temporary Files" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Temporary Setup Files" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Temporary Sync Files" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Thumbnail Cache" /v "StateFlags0064" /t REG_DWORD /d "0" /f >nul 2>&1
%sageset%Update Cleanup" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Upgrade Discarded Files" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%User file versions" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Windows Defender" /v "StateFlags0064" /t REG_DWORD /d "0" /f >nul 2>&1
%sageset%Windows Error Reporting Files" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Windows ESD installation files" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
%sageset%Windows Upgrade Log Files" /v "StateFlags0064" /t REG_DWORD /d "2" /f >nul 2>&1
cleanmgr /sagerun:64
taskkill /F /IM explorer.exe & start explorer
%prog4%
cls
echo:
echo:
call :color %rst% "     " %bgrn% "▓▒░                                      ░▒▓"
call :color %rst% "     " %bgrn% "▓▒░ Todos os processos  foram concluídos ░▒▓"
call :color %rst% "     " %bgrn% "▓▒░                                      ░▒▓"
echo:
echo      Lembre-se de reiniciar o Windows para
echo      que todas as alterações tenham efeito
echo:
echo      Voltando para o menu em 10 segundos...
timeout /t 10 >nul
cls
call :menu
::
::==========================================
::Configurações de hibernação.
:hibernacao
%telaprocesso%
cls
title W11bAlf %_ver% - Configurações de hibernação
echo:
echo:
call :color %rst% "             " %inv% "▓▒░                      ░▒▓"
call :color %rst% "             " %inv% "▓▒░ Hibernação - Configs ░▒▓"
call :color %rst% "             " %inv% "▓▒░                      ░▒▓"
echo:
echo   [1] Desativar hibernação             [Para SSDs]
echo   [2] Reduzir tamanho do hiberfil.sys  [Para HDDs]
echo:
choice /C:12 /N >nul

if %errorlevel%==2 (
%prog3%
powercfg /h /type reduced >nul 2>&1
%prog4%
echo:
call :color %grn% "            Arquivo de hibernação reduzido"
%progmenu%
pause >nul
cls
goto menu
)

if %errorlevel%==1 (
%prog3%
powercfg.exe /hibernate off >nul 2>&1
%prog4%
echo:
call :color %grn% "                Hibernação: desativada"      
%progmenu%
pause >nul
cls
goto menu
)
::==========================================

:ajuda
%telaprocesso%
cls
title W11bAlf %_ver% - Ajuda
echo:
echo:
call :color %rst% "            " %inv% "▓▒░                       ░▒▓"
call :color %rst% "            " %inv% "▓▒░         Ajuda         ░▒▓"
call :color %rst% "            " %inv% "▓▒░                       ░▒▓"
echo:
echo             [1] Reiniciar o Explorer
echo             [2] Reiniciar o Windows
echo             [3] Voltar ao menu principal
echo:
choice /C:123 /N
if %errorlevel%==3 call :menu
if %errorlevel%==2 call :reiniciarw
if %errorlevel%==1 call :reiniciare

:ajuda2
%telaprocesso%
cls
title W11bAlf %_ver% - Ajuda
echo:
echo:
call :color %rst% "            " %inv% "▓▒░                       ░▒▓"
call :color %rst% "            " %inv% "▓▒░         Ajuda         ░▒▓"
call :color %rst% "            " %inv% "▓▒░                       ░▒▓"
echo:
call :color %grn% "            [1] Reiniciar o Explorer - OK"
echo             [2] Reiniciar o Windows
echo             [3] Voltar ao menu principal
echo:
choice /C:123 /N >nul
if %errorlevel%==3 call :menu
if %errorlevel%==2 call :reiniciarw
if %errorlevel%==1 call :reiniciare

:reiniciarw
shutdown /r /t 0

:reiniciare
taskkill /F /IM explorer.exe >nul 2>&1
timeout /t 2 >nul 2>&1
start explorer.exe >nul 2>&1
timeout /t 2 >nul 2>&1
goto ajuda2

::==========================================

:color
echo %cor%[%~1%~2%cor%[%~3%~4%cor%[0m
::
goto :EOF
exit