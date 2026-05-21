@echo off
set _ver=1.0.0
chcp 65001 >nul
set "beep=echo "
title W11bALF - O365
mode con:cols=60 lines=40
setlocal EnableDelayedExpansion


:: Cores
set fgbk=[m[30m
set bgbk=[m[40m[97m

set fggy=[m[38;2;064;064;064m
set bggy=[m[48;2;032;032;032m[38;2;092;092;092m

set fggn=[m[92m
set bggn=[m[42m[97m

set fgrd=[m[31m
set bgrd=[m[41m[97m

set bgwe=[m[107m[30m
set "line=echo:&echo %fggy%────────────────────────────────────────────────────────────%bgbk%&echo:"

set "WINWORD=Word"
set "POWERPNT=Power Point"
set "EXCEL=Excel"
set "OUTLOOK=Outlook"
set "MSACCESS=Access"
set "MSPUB=Publisher"

set "powershell=PowerShell -ExecutionPolicy Unrestricted -Command"
set step1=░%fggy%
set step2=%bgbk%█
set step3=%fggn%█


::


:admin :: Requisitar permissões de administrador
call :w11balf_WHT
if not "%1"=="am_admin" (echo    Quando solicitado %bgwe% clique em %bggn% "SIM" %bgbk%& chcp 437 >nul & %powershell% "Start-Process -Verb RunAs -FilePath '%0' -ArgumentList 'am_admin'" & chcp 65001 >nul & exit /b)


:o365_folders :: Setar os locais que serão usados
set "o365_dir=%ProgramFiles%\Microsoft Office\root\Office16"
md %temp%\o365 >nul 2>&1
md %temp%\o365\bin >nul 2>&1

:: goto o365_menu
::


:o365_netchk
ver >nul & set ison=x & set netchk_c=x
cls
call :w11balf_WHT
echo    Verificando conexão com a internet...
for /f %%G in ('ping -n 1 -w 1000 8.8.8.8 ^| find /i /c "TTL"') do (set ison=%%G)
if %ison%==1 (goto o365_down) else (
	cls
	call :w11balf_RED
	echo %fgrd%   Há um problema na conexão com a internet.%bgbk%
	echo:
	echo    Deseja tentar se conectar novamente?
	echo    [1] Sim    %fggy%^|%bgbk%    [2] Não
	echo:
	call :choice netchk_c
	if !netchk_c!==1 (goto o365_netchk) else (exit)
)

::


:o365_down
cls
call :w11balf_WHT
echo %bggn%[1A▓▒░      Fazendo download dos arquivos necessários:      ░▒▓%bgbk%
%line%
echo    %step1% Baixando Office Deployment Tool
echo    %step1% Extraindo o ODT para a pasta temp\o365
echo    %step1% Deletando arquivo configuration.xml padrão
echo    %step1% Baixando o desinstalador do Office
echo:

echo [5A   %step2% Baixando Office Deployment Tool
curl -o "%temp%\o365\officedeploymenttool_19929-20090.exe" "https://download.microsoft.com/download/6c1eeb25-cf8b-41d9-8d0d-cc1dbc032140/officedeploymenttool_19929-20090.exe" >nul 2>&1
echo [1A   %step3% Baixando Office Deployment Tool

echo    %step2% Extraindo o ODT para a pasta temp\o365
"%temp%\o365\officedeploymenttool_19929-20090.exe" /quiet /extract:%temp%\o365\ >nul 2>&1
echo [1A   %step3% Extraindo o ODT para a pasta temp\o365

echo    %step2% Deletando arquivo configuration.xml padrão
del /f /s /q "%temp%\o365\configuration-Office365-x64.xml" >nul 2>&1
echo [1A   %step3% Deletando arquivo configuration.xml padrão

echo    %step2% Baixando o desinstalador do Office
::
:: Link do script original:
:: https://github.com/abbodi1406/BatUtil/tree/master/OfficeScrubber
::
:: Originalmente o script não pode ser executado a partir da pasta %temp%
:: Fiz com que isso seja possível alterando apenas 2 caracteres no código (::).
:: Por isso o script está sendo baixado de um repositório pessoal.
::
for %%G in (

CleanOffice.txt
OffScrub03.vbs
OffScrub07.vbs
OffScrub10.vbs
OffScrubC2R.vbs
OffScrub_O15msi.vbs
OffScrub_O16msi.vbs

) do (
	if not exist "%temp%\o365\bin\%%G" (curl -o "%temp%\o365\bin\%%G" "https://raw.githubusercontent.com/abbodi1406/BatUtil/refs/heads/master/OfficeScrubber/bin/%%G" >nul 2>&1))


curl -o "%temp%\o365\OfficeScrubber.cmd" "https://raw.githubusercontent.com/ru-bem/W11bALF/refs/heads/main/Office/OfficeScrubber.cmd" >nul 2>&1
echo [1A   %step3% Baixando o desinstalador do Office
goto o365_menu


::
:__
::


:choice
echo ^>^>     ^<^<
set /p "%1=[1A[4C"
goto:eof

:msg
msg * Esta não é uma opção válida^^! & goto %1
goto:eof

::
:__
::


:o365_menu
cls
call:w11balf_WHT
echo [3A

if not exist "%o365_dir%" (
	echo %bgwe%▓▒░                Status: %bgrd% Não instalado %bgwe%               ░▒▓
) else (
	echo %bgwe%▓▒░                  Status: %bggn% Instalado %bgwe%                 ░▒▓
)
echo %bgwe%▓▒░                                                      ░▒▓%bgbk%
echo %bggn%▓▒░          Digite um número e pressione ENTER          ░▒▓%bgbk%

echo:
echo:
echo:
echo %bgwe%    1 %bgbk% Instalar o Office365

if not exist "%o365_dir%" (
	echo %bggy%    2 %fggy% Desinstalar o Office365
	echo %bggy%    3 %fggy% Ativar o Office365
) else (
	echo %bgwe%    2 %bgbk% Desinstalar o Office365
	echo %bgwe%    3 %bgbk% Ativar o Office365
)
%line%
if exist "%o365_dir%\WINWORD.EXE"  (echo %bgwe%    4 %bgbk% Iniciar o Word)        else (echo %bggy%    4 %fggy% Iniciar o Word       )
if exist "%o365_dir%\EXCEL.EXE"    (echo %bgwe%    5 %bgbk% Iniciar o Excel)       else (echo %bggy%    5 %fggy% Iniciar o Excel      )
if exist "%o365_dir%\POWERPNT.EXE" (echo %bgwe%    6 %bgbk% Iniciar o Power Point) else (echo %bggy%    6 %fggy% Iniciar o Power Point)
if exist "%o365_dir%\OUTLOOK.EXE"  (echo %bgwe%    7 %bgbk% Iniciar o Outlook)     else (echo %bggy%    7 %fggy% Iniciar o Outlook    )
if exist "%o365_dir%\MSACCESS.EXE" (echo %bgwe%    8 %bgbk% Iniciar o Access)      else (echo %bggy%    8 %fggy% Iniciar o Access     )
if exist "%o365_dir%\MSPUB.EXE"    (echo %bgwe%    9 %bgbk% Iniciar o Publisher)   else (echo %bggy%    9 %fggy% Iniciar o Publisher  )
%line%

echo %bgwe%    X %bgbk% Sair
%line%

call :choice o365_escolha

if %o365_escolha%==1 if exist "%o365_dir%" (goto o365_exist) else (goto o365_xml_del)
if %o365_escolha%==2 if not exist "%o365_dir%" (%beep% & msg * O Office365 ainda não está instalado. & goto o365_menu) else (goto o365_del)
if %o365_escolha%==3 if not exist "%o365_dir%" (%beep% & msg * O Office365 ainda não está instalado. & goto o365_menu) else (goto o365_act)
if %o365_escolha%==4 set o365_open=WINWORD&  call :o365_open
if %o365_escolha%==5 set o365_open=EXCEL&    call :o365_open
if %o365_escolha%==6 set o365_open=POWERPNT& call :o365_open
if %o365_escolha%==7 set o365_open=OUTLOOK&  call :o365_open
if %o365_escolha%==8 set o365_open=MSACCESS& call :o365_open
if %o365_escolha%==9 set o365_open=MSPUB&    call :o365_open
if /i %o365_escolha%==X (rd /s /q %temp%\o365 >nul 2>&1 & exit)
call :msg o365_menu


:o365_open
if exist "%o365_dir%\%o365_open%.exe" (

	cls & call :w11balf_WHT
	%line%
	echo     %bggn% !%o365_open%! %bgbk% está em execução.
	echo      Para voltar a usar o script feche-o e aguarde.
	pushd "%o365_dir%"
	"%o365_open%.exe"
	popd
	call :o365_open_loop

) else (

	%beep% & msg * O !%o365_open%! ainda não está instalado.& goto o365_menu

)
goto:eof


:o365_open_loop
timeout /t 2 >nul & tasklist | find /i "%o365_open%.exe" >nul && (goto o365_open_loop) || (goto o365_menu)
goto:eof


::


:__


::


:: Deleta o arquivo XML de configuração caso tenha sido criado anteriormente pelo programa
:o365_xml_del
del /f /s /q %temp%\o365\o365list.xml >nul 2>&1
goto o365i_esc

:: Office 365 Idioma : Escolha
:o365i_esc
cls
call:w11balf_WHT
echo %bggn%[1A▓▒░            Escolha o idioma do Office365:            ░▒▓%bgbk%
echo:
echo:
echo %bgwe%    1 %bgbk% Português_BR
echo %bgwe%    2 %bgbk% Inglês
echo %bgwe%    3 %bgbk% Espanhol
echo %bgwe%    4 %bgbk% Francês
echo %bgwe%    5 %bgbk% Italiano
%line%
echo %bgwe%    0 %bgbk% Voltar ao menu principal
echo:
echo ^>^>     ^<^<
set /p "idioma=[1A[4C"

if %idioma%==0 goto o365_menu
if %idioma%==1 set "idioma=pt-br" & set idiomanome=Português_BR& goto o365i_con
if %idioma%==2 set "idioma=en-us" & set idiomanome=Inglês&       goto o365i_con
if %idioma%==3 set "idioma=es-es" & set idiomanome=Espanhol&     goto o365i_con
if %idioma%==4 set "idioma=fr-fr" & set idiomanome=Francês&      goto o365i_con
if %idioma%==5 set "idioma=it-it" & set idiomanome=Italiano&     goto o365i_con

msg * Esta não é uma opção válida! & goto o365i_esc

:: Office 365 Idioma : Confirmação
:o365i_con
cls
call:w11balf_WHT
echo %bggn%[1A▓▒░                Confirme a sua escolha                ░▒▓%bgbk%

%line%

echo    Você escolheu o idioma %bggn% %idiomanome% %bgbk%

%line%

echo %bgwe%    1 %bgbk%%fggn% Isso mesmo, quero continuar.
echo %bgwe%    2 %bgbk% Desejo alterar o idioma.
echo:
call :choice o365i_con
if %o365i_con%==3 goto o365i_con
if %o365i_con%==2 goto o365i_esc
if %o365i_con%==1 goto o365p_esc_set
msg * Esta não é uma opção válida! & goto o365i_con


:o365p_esc_set
set "o365_wrd_01=%bggn%  Word        %reset%"
set "o365_wrd_00=%bggy%  Word        %reset%"
set "o365_acs_01=%bggn%  Access      %reset%"
set "o365_acs_00=%bggy%  Access      %reset%"
set "o365_ppt_01=%bggn%  PowerPoint  %reset%"
set "o365_ppt_00=%bggy%  PowerPoint  %reset%"
set "o365_xls_01=%bggn%  Excel       %reset%"
set "o365_xls_00=%bggy%  Excel       %reset%"
set "o365_olk_01=%bggn%  Outlook     %reset%"
set "o365_olk_00=%bggy%  Outlook     %reset%"
set "o365_psr_01=%bggn%  Publisher   %reset%"
set "o365_psr_00=%bggy%  Publisher   %reset%"

set o365_add_wrd=1
set o365_add_acs=0
set o365_add_ppt=1
set o365_add_xls=1
set o365_add_olk=0
set o365_add_psr=0

:o365p_esc
cls
call :w11balf_WHT
echo %bggn%[1A▓▒░        Personalize a instalação do Office 365        ░▒▓%bgbk%

%line%
echo        Idioma selecionado: %bggn% %idiomanome% %bgbk%
%line%

echo %bgwe%      %bggy%              %bgbk%
echo %bgwe%    1 %bgbk%!o365_wrd_0%o365_add_wrd%!
echo %bgwe%    2 %bgbk%!o365_acs_0%o365_add_acs%!
echo %bgwe%    3 %bgbk%!o365_ppt_0%o365_add_ppt%!
echo %bgwe%    4 %bgbk%!o365_xls_0%o365_add_xls%!
echo %bgwe%    5 %bgbk%!o365_olk_0%o365_add_olk%!
echo %bgwe%    6 %bgbk%!o365_psr_0%o365_add_psr%!
echo %bgwe%      %bggy%              %bgbk%

%line%
echo %bgwe%      %bggy%
echo %bgwe%    7 %bgbk%  Continuar
echo %bgwe%    8 %bgbk%  Voltar e mudar o idioma
echo %bgwe%      %bggy%
%line%

call :choice o365p_esc

if %o365p_esc%==1 (if %o365_add_wrd%==1 (set o365_add_wrd=0& goto o365p_esc) else (set o365_add_wrd=1& goto o365p_esc))
if %o365p_esc%==2 (if %o365_add_acs%==1 (set o365_add_acs=0& goto o365p_esc) else (set o365_add_acs=1& goto o365p_esc))
if %o365p_esc%==3 (if %o365_add_ppt%==1 (set o365_add_ppt=0& goto o365p_esc) else (set o365_add_ppt=1& goto o365p_esc))
if %o365p_esc%==4 (if %o365_add_xls%==1 (set o365_add_xls=0& goto o365p_esc) else (set o365_add_xls=1& goto o365p_esc))
if %o365p_esc%==5 (if %o365_add_olk%==1 (set o365_add_olk=0& goto o365p_esc) else (set o365_add_olk=1& goto o365p_esc))
if %o365p_esc%==6 (if %o365_add_psr%==1 (set o365_add_psr=0& goto o365p_esc) else (set o365_add_psr=1& goto o365p_esc))
if %o365p_esc%==7 (goto o365p_res)
if %o365p_esc%==8 (goto o365i_con)

call :msg o365p_esc

:o365p_res
set /a o365_sum=%o365_add_wrd%+%o365_add_acs%+%o365_add_ppt%+%o365_add_xls%+%o365_add_olk%+%o365_add_psr%
if %o365_sum%==0 msg * Selecione ao menos um programa antes de continuar.&goto o365p_esc
cls
call :w11balf_WHT
echo %bggn%[1A▓▒░                        Resumo                        ░▒▓%bgbk%
echo %bggn%▓▒░        Os programas em verde serão instalados        ░▒▓%bgbk%

%line%
echo     Idioma selecionado: %bggn% %idiomanome% %bgbk%
%line%

echo     !o365_wrd_0%o365_add_wrd%! !o365_acs_0%o365_add_acs%! !o365_ppt_0%o365_add_ppt%!%bgbk%
echo     !o365_xls_0%o365_add_xls%! !o365_olk_0%o365_add_olk%! !o365_psr_0%o365_add_psr%!%bgbk%

%line%
echo:
echo     Deseja iniciar a instalação agora?
echo:
echo %bgwe%    1 %bgbk% Sim
echo %bgwe%    2 %bgbk% Não, quero voltar.
echo:

call :choice o365p_res

if %o365p_res%==2 goto o365p_esc
if %o365p_res%==1 goto o365_xml

call :msg o365p_res

:o365_xml
cls
call :w11balf_WHT
echo %bggn%[1A▓▒░                Instalando o Office365                ░▒▓%bgbk%

%line%
echo     Você será notificado ao fim do processo.
echo     É permitido usar o computador normalmente.
%line%

echo    %step1% Criando o arquivo XML
echo    %step1% Configurando o idioma escolhido
echo    %step1% Impedindo a instalação de bloat
echo    %step1% Configurando os programas escolhidos
%line%


echo [7A   %step2% Criando o arquivo XML
::
type > %temp%\o365\o365list.xml >nul 2>&1

for %%G in (
"<Configuration ID="e080f356-4291-4788-a421-330bd43b9e1b">",
"  <Add OfficeClientEdition="64" Channel="Current">",
"    <Product ID="O365ProPlusRetail">"
)  do echo %%~G >> %temp%\o365\o365list.xml
::
echo [1A   %step3% Criando o arquivo XML


echo    %step2% Configurando o idioma escolhido
::
for %%G in (
"      <Language ID="!idioma!" />"
) do echo %%~G >> %temp%\o365\o365list.xml
::
echo [1A   %step3% Configurando o idioma escolhido


echo    %step2% Impedindo a instalação de bloat
::
for %%G in (
"      <ExcludeApp ID="Groove" />",
"      <ExcludeApp ID="Lync" />",
"      <ExcludeApp ID="OneDrive" />",
"      <ExcludeApp ID="OneNote" />",
"      <ExcludeApp ID="Teams" />",
"      <ExcludeApp ID="Bing" />"
) do echo %%~G >> %temp%\o365\o365list.xml
::
echo [1A   %step3% Impedindo a instalação de bloat


echo    %step2% Configurando os programas escolhidos
::
if %o365_add_wrd%==0 (for %%G in ("      <ExcludeApp ID="Word" />") do echo %%~G >> %temp%\o365\o365list.xml)
if %o365_add_xls%==0 (for %%G in ("      <ExcludeApp ID="Excel" />") do echo %%~G >> %temp%\o365\o365list.xml)
if %o365_add_ppt%==0 (for %%G in ("      <ExcludeApp ID="PowerPoint" />") do echo %%~G >> %temp%\o365\o365list.xml)
if %o365_add_olk%==0 (for %%G in ("      <ExcludeApp ID="Outlook" />") do echo %%~G >> %temp%\o365\o365list.xml)
if %o365_add_acs%==0 (for %%G in ("      <ExcludeApp ID="Access" />") do echo %%~G >> %temp%\o365\o365list.xml)
if %o365_add_psr%==0 (for %%G in ("      <ExcludeApp ID="Publisher" />") do echo %%~G >> %temp%\o365\o365list.xml)

for %%G in (
"    </Product>",
"  </Add>",
"  <Updates Enabled="TRUE" />",
"  <RemoveMSI />",
"  <Display Level="None" AcceptEULA="TRUE" />",
"</Configuration>"
) do echo %%~G >> %temp%\o365\o365list.xml
::
echo [1A   %step3% Configurando os programas escolhidos
%line%
echo    Iniciando instalação em 7 segundos...
timeout /t 7 /nobreak >nul

:o365_add
cls
call :w11balf_WHT
echo %bggn%[1A▓▒░                Instalando o Office365                ░▒▓%bgbk%

%line%
echo    Você será notificado ao fim do processo.
echo    É permitido usar o computador normalmente.
%line%

%temp%\o365\setup.exe /configure %temp%\o365\o365list.xml
echo [5A%fggn%   Office instalado com sucesso!            
echo    Iniciando a ativação em 10 segundos...     %bgbk%
echo:
echo    Uma janela surgirá na sua tela a qualquer momento.
echo    Isso é esperado e faz parte do processo, é só aguardar.
echo:
%beep% & msg * /time:10 O Office foi instalado com sucesso^^!
timeout /t 7 /nobreak >nul
goto o365_act

:o365_act
cls
call :w11balf_WHT
echo %bggn%[1A▓▒░                 Ativando o Office365                 ░▒▓%bgbk%

%line%
echo    Ativando o Office 365, aguarde alguns segundos...
echo:
echo    Uma janela surgirá na sua tela a qualquer momento.
echo    Isso é esperado e faz parte do processo, é só aguardar.
echo:

chcp 437 >nul
%powershell% "& ([ScriptBlock]::Create((irm https://get.activated.win))) /ohook" >nul 2>&1
chcp 65001 >nul

echo [1A%fggn%   O Office365 está ativado^^!                         

%line%
echo    Pressione qualquer tecla para voltar ao menu principal.
pause >nul
goto o365_menu


:o365_exist
cls
title W11bALF O365: Office detectado^^!
call :w11balf_RED
echo [1A%bggn%▓▒░             O OFFICE AINDA ESTÁ INSTALADO.           ░▒▓%bgbk%
%line%
echo    Os programas na cor %bggn% verde %bgbk% foram detectados:
%line%

for %%G in (WINWORD POWERPNT EXCEL) do (
	if exist "%o365_dir%\%%G.exe" (
		<nul set /p ="%fgbk%---%bgbk%%fggn%!%%G!%bgbk% "
	) else (
		<nul set /p ="%fgbk%---%bgbk%%fggy%!%%G!%bgbk%"
	)
)
echo:
for %%G in (OUTLOOK MSACCESS MSPUB) do (
	if exist "%o365_dir%\%%G.exe" (
		<nul set /p ="%fgbk%---%bgbk%%fggn%!%%G!%bgbk%"
	) else (
		<nul set /p ="%fgbk%---%bgbk%%fggy%!%%G!%bgbk%"
	)
)
echo:
%line%
echo    Se algum conjunto do Office já estiver instalado,
echo    instalá-lo novamente 'por cima' provavelmente
echo    causará erros.
echo:
echo    %bgwe% DESINSTALE o Office %bgbk% e retorne para reinstalá-lo.
%line%
echo    Pressine qualquer tecla para voltar ao menu principal
timeout /t 1 /nobreak >nul 2>&1
pause >nul 2>&1
goto o365_menu

:o365_del
cls
title W11bALF O365: Desinstalação
call :w11balf_WHT
echo [1A%bggn%▓▒░             Desinstalação do Office 365.             ░▒▓%bgbk%
%line%
echo    Deseja remover completamente o Office e todos
echo    os arquivos relacionados a instalações antigas?
echo:
echo    (Pode levar algum tempo dependendo do seu PC)
%line%
echo %bgwe%    1 %bgbk%  Sim, desinstalar agora.
echo %bgwe%    2 %bgbk%  Voltar ao menu principal.
echo:
call :choice o365_del_con
if %o365_del_con%==2 goto o365_menu
if %o365_del_con%==1 goto o365_del1
call :msg o365_del

:o365_del1
cls
title W11bALF O365: Desinstalando...
call :w11balf_WHT
echo [1A%bggn%▓▒░                Desinstalando o Office                ░▒▓%bgbk%

%line%
echo :    Esse processo pode demorar, então você será
echo :    notificado ao fim do processo.
echo :
echo :    É permitido usar o computador enquanto aguarda.
%line%

:: start /min /wait %temp%\o365\OfficeScrubber.cmd >nul 2>&1

echo :[7A%fggn%    Office desinstalado com sucesso^^! %bgbk%          
echo :    Pressione qualquer tecla para voltar.      
echo :                                                           
echo :                                                           
%beep% & msg * /time:10 O Office foi desinstalado com sucesso!
pause >nul
goto o365_menu

:::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::

:w11balf_WHT
echo %bgwe%▓▒░                                                      ░▒▓
echo %bgwe%▓▒░             █ █ █ ▄█ ▄█  █▄▄ ▄▀█ █   █▀▀             ░▒▓
echo %bgwe%▓▒░             ▀▄▀▄▀  █  █  █▄█ █▀█ █▄▄ █▀              ░▒▓
echo %bgwe%▓▒░                                                      ░▒▓
echo %bgwe%▓▒░                   Office365 v%_ver%                   ░▒▓
echo %bgwe%▓▒░                                                      ░▒▓%bgbk%
echo:
goto:eof

:w11balf_RED
echo %bgrd%▓▒░                                                      ░▒▓
echo %bgrd%▓▒░             █ █ █ ▄█ ▄█  █▄▄ ▄▀█ █   █▀▀             ░▒▓
echo %bgrd%▓▒░             ▀▄▀▄▀  █  █  █▄█ █▀█ █▄▄ █▀              ░▒▓
echo %bgrd%▓▒░                                                      ░▒▓
echo %bgrd%▓▒░                   Office365 v%_ver%                   ░▒▓
echo %bgrd%▓▒░                                                      ░▒▓%bgbk%
echo:
goto:eof

:w11balf_GRN
echo %bggn%▓▒░                                                      ░▒▓
echo %bggn%▓▒░             █ █ █ ▄█ ▄█  █▄▄ ▄▀█ █   █▀▀             ░▒▓
echo %bggn%▓▒░             ▀▄▀▄▀  █  █  █▄█ █▀█ █▄▄ █▀              ░▒▓
echo %bggn%▓▒░                                                      ░▒▓
echo %bggn%▓▒░                   Office365 v%ver%                   ░▒▓
echo %bggn%▓▒░                                                      ░▒▓%bgbk%
echo:
goto:eof
