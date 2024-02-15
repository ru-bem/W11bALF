@echo off
setlocal EnableDelayedExpansion
chcp 65001 >nul
set som=echo 
mode con:cols=60 lines=33

:: 0 = Valor padrão, o programa iniciará normalmente.
:: 1 = Executará automaticamente as atividades recomendadas.
:: 2 = Execuratá automaticamente TODAS as atividades. (Cuidado)
set "balfmode=0"

:: Quantos segundos esperar até o início do modo automático. (Valor padrão = 5)
set "balftime=5"

:: Modo silencioso com muito menos informações na tela. Funciona SOMENTE em conjunto com o MODO BALF.
:: 0 = Modo Silencioso Desativado (Padrão)
:: 1 = Modo Silencioso Ativado
set "silent=0"

:: Ativa o modo de limpeza profunda mas aumenta o tempo de execução consideravelmente. (Valor padrão = 0)
set "deepclean=0"

:::::::::::::::::::::::::::::::::::::::

title Iniciando o W11bALF
echo:
echo    Iniciando o programa, aguarde...
echo:
:::: Versão
set _ver=v1.0.0

:::: Cores
set cor=
set cinza=[90m
set verde=[92m
set bverd=[42m[97m
set vrmlh=[31m
set bvmlh=[41m[97m
set branc=[107m[30m
set fbrnc=[97m
set reset=[0m[97m

:: Limpeza
set delfile=del /f /s /q

:: Enfeites
set "wline=echo [107m[30m▓▒░                                                      ░▒▓[0m[97m& echo [107m[30m▓▒░                                                      ░▒▓[0m[97m"
set "underline=echo [90m____________________________________________________________[97m"
set "middleline=echo [90m────────────────────────────────────────────────────────────[97m"

:: Progresso
(set "endmenu=echo [92m   Processo concluído com sucesso!                          %reset%& echo    Pressione qualquer tecla para voltar ao menu            & pause >nul & goto w11menu")

:: Processos separados
set "svc_tele=cls & title W11bAlf %_ver% - Serviços e Telemetria        & call :w11balf_wht & echo [107m[30m▓▒░     Desativando Serviços e Reduzindo Telemetria.     ░▒▓& %wline% & echo [1A[97m"
set "bloatwre=cls & title W11bAlf %_ver% - Remoção de Bloatware         & call :w11balf_wht & echo [107m[30m▓▒░       Removendo Aplicativos Inúteis do Sistema       ░▒▓& %wline% & echo [1A[97m"
set "winconfg=cls & title W11bAlf %_ver% - Configurações do Windows     & call :w11balf_wht & echo [107m[30m▓▒░          Fazendo alguns ajustes no Sistema.          ░▒▓& %wline% & echo [1A[97m"
set "limpezao=cls & title W11bAlf %_ver% - Limpeza do sistema           & call :w11balf_wht & echo [107m[30m▓▒░                  Limpeza do Sistema                  ░▒▓& %wline% & echo [1A[97m"
set "limpbrut=cls & title W11bAlf %_ver% - Limpeza do sistema - Brutal  & call :w11balf_wht & echo [41m[97m▓▒░      Limpeza do Sistema - Modo Profundo Ativado      ░▒▓& %wline% & echo [1A[97m"
set "medgecfg=cls & title W11bAlf %_ver% - Configuração do MS Edge      & call :w11balf_wht & echo [107m[30m▓▒░               Configuração do MS Edge.               ░▒▓& %wline% & echo [1A[97m"
set "startmnu=cls & title W11bAlf %_ver% - Limpeza do Menu Iniciar      & call :w11balf_wht & echo [107m[30m▓▒░               Limpeza do Menu Iniciar.               ░▒▓& %wline% & echo [1A[97m"
set "hiberfil=cls & title W11bAlf %_ver% - Configurações de Hibernação  & call :w11balf_wht & echo [107m[30m▓▒░             Configurações de Hibernação.             ░▒▓& %wline% & echo [1A[97m"
set "clwinsxs=cls & title W11bAlf %_ver% - Limpeza da pasta WinSxS      & call :w11balf_wht & echo [107m[30m▓▒░               Limpeza da pasta WinSxS.               ░▒▓& %wline% & echo [1A[97m"
set "ativaw11=cls & title W11bAlf %_ver% - Ativação do Windows          & call :w11balf_wht & echo [107m[30m▓▒░                 Ativação do Windows.                 ░▒▓& %wline% & echo [1A[97m"

:: Requisitar permissões de administrador
if not "%1"=="am_admin" (echo    Surgirá na tela um pedido de elevação. & echo    Para que o programa funcione, escolha "sim". & chcp 437 >nul & powershell -command "Start-Process -Verb RunAs -FilePath '%0' -ArgumentList 'am_admin'" & chcp 65001 >nul & exit /b)

::

:admincontinue
:: Verifica a versão do Windows
call :w11balf_wht
echo [107m[30m▓▒░           Verificando versão do Windows...           ░▒▓
echo [107m[30m▓▒░                                                      ░▒▓[0m[97m
ver | find "10.0.2" > nul && (goto w11menu) || (goto nw11)

::

:nw11
%som%
cls
title Versão do sistema não compatível
call :w11balf_red
echo [41m[97m▓▒░          VOCÊ NÃO ESTÁ USANDO O WINDOWS 11.          ░▒▓
echo [41m[97m▓▒░                                                      ░▒▓
echo [0m[97m
echo    Tenha em mente que o programa não foi testado em outros
echo    sistemas, portanto, podem ocorrer erros inesperados.
%underline%
echo [97m
echo    Deseja continuar mesmo assim?
echo:
echo    [1] [41m[97m SIM [0m [90m^| [97mContinuarei por minha conta e risco.
echo    [2] [42m[97m NÃO [0m [90m^| [97mAtualizarei o sistema antes.
echo:
choice /C 12  /N
if %errorlevel%==2 exit
if %errorlevel%==1 goto w11menu

::
:w11menu
if %balfmode% NEQ 0 (goto oneclick)
cls
title W11bAlf %_ver%
echo [0m[97m░▒▓█[107m[30m                                                    [0m[97m█▓▒░
echo [0m[97m░▒▓█[107m[30m                                                    [0m[97m█▓▒░
echo ░▒▓█[107m[30m            [32m█ █ █ ▄█ ▄█  █▄▄ ▄▀█ █   █▀▀[107m[30m            [0m[97m█▓▒░
echo ░▒▓█[107m[30m            [32m▀▄▀▄▀  █  █  █▄█ █▀█ █▄▄ █▀ [107m[30m            [0m[97m█▓▒░
echo ░▒▓█[107m[30m                                                    [0m[97m█▓▒░
echo ░▒▓█[107m[30m           W11 but A Little Faster %_ver%           [0m[97m█▓▒░
echo ░▒▓█[107m[30m           %bverd% github.com/rubem-psd/W11bALF %branc%           [0m[97m█▓▒░
echo ░▒▓█[107m[30m                                                    [0m[97m█▓▒░
echo [0m[97m░▒▓█[107m[30m                                                    [0m[97m█▓▒░
echo ░▒▓█[107m[30m       [0m[97m                                             █▓▒░
echo ░▒▓█[107m[30m       [0m[97m                                             █▓▒░
echo ░▒▓█[107m[30m [ 1]  [0m[97m  ONE-CLICK ^| Modo automático                █▓▒░
echo ░▒▓████████[90m─────────────────────────────────────────────%reset%█▓▒░
echo ░▒▓█[107m[30m [ 2]  [0m[97m  Serviços e Telemetria [90m─────────────────────%reset%█▓▒░
echo ░▒▓█[107m[30m [ 3]  [0m[97m  Desinstalar Bloatware [90m─────────────────────%reset%█▓▒░
echo ░▒▓█[107m[30m [ 4]  [0m[97m  Configurar o Windows [90m──────────────────────%reset%█▓▒░
echo ░▒▓█[107m[30m [ 5]  [0m[97m  Limpeza do Sistema [90m────────────────────────%reset%█▓▒░
if %deepclean%==1 (echo [1A░▒▓█[107m[30m [ 5]  [0m[97m  Limpeza do Sistema [90m^| [92mModo profundo ativado[90m %reset%█▓▒░)
echo ░▒▓█[107m[30m [ 6]  [0m[97m  Configurar Microsoft Edge [90m─────────────────%reset%█▓▒░
echo ░▒▓█[107m[30m [ 7]  [0m[97m  Limpar Menu Iniciar e Taskbar [90m─────────────%reset%█▓▒░
echo ░▒▓█[107m[30m [ 8]  [0m[97m  Configurar Hibernação [90m─────────────────────%reset%█▓▒░
echo ░▒▓█[107m[30m [ 9]  [0m[97m  Limpar a pasta WinSxS [90m─────────────────────%reset%█▓▒░
echo ░▒▓█[107m[30m [10]  [0m[97m  Ativar o Windows [90m──────────────────────────%reset%█▓▒░
echo ░▒▓████████[90m─────────────────────────────────────────────%reset%█▓▒░
echo ░▒▓█[107m[30m [ A]  [0m[97m  Visitar a página do projeto [90m───────────────%reset%█▓▒░
echo ░▒▓█[107m[30m [ C]  [0m[97m  Configurações [90m─────────────────────────────%reset%█▓▒░
echo ░▒▓█[107m[30m [ E]  [0m[97m  Extras [90m────────────────────────────────────%reset%█▓▒░
echo ░▒▓█[107m[30m [ 0]  [0m[97m  Sair [90m──────────────────────────────────────%reset%█▓▒░
echo ░▒▓█[107m[30m       [0m[97m                                             █▓▒░
echo ░▒▓█[107m[30m       [0m[97m                                             █▓▒░
echo ░▒▓█[107m[30m                                                    [0m[97m█▓▒░
echo ░▒▓█%branc%        [100m[97m Digite um número e pressione ENTER %branc%        [0m[97m█▓▒░
echo ░▒▓█[107m[30m                                                    [0m[97m█▓▒░
set /p "w11c=⠀⠀⠀>>["

if /i %w11c%==e (goto extras)
if /i %w11c%==c (goto configs)
if /i %w11c%==a start https://github.com/rubem-psd/W11bALF & goto w11menu
if %w11c%==10 (%ativaw11% & call :ativaw11 & %endmenu%)
if %w11c%==9 (%clwinsxs% & call :clwinsxs & %endmenu%)
if %w11c%==8 (set hiberauto=0 & %hiberfil% & call :hiberfil & %endmenu%)
if %w11c%==7 (call :startmnuaviso)
if %w11c%==6 (call :medgecfgaviso)
if %w11c%==5 if %deepclean%==0 (%limpezao% & call :limpezao & %endmenu%) else (%limpbrut% & call :limpezao & %endmenu%)
if %w11c%==4 (%winconfg% & call :winconfg & %endmenu%) 
if %w11c%==3 (%bloatwre% & call :bloatwre & %endmenu%)
if %w11c%==2 (%svc_tele% & call :svc_tele & %endmenu%)
if %w11c%==1 (call :oneclick)
if %w11c%==0 call :msg "Obrigado por usar o W11bALF!" "W11bALF %_ver%" "2" & exit
msg * /time:2 Esta não é uma opção válida. & goto w11menu

::
::
::

:oneclick
set "oc_octitulo=echo [107m[30m▓▒░             [42m[97m    Otimização ONE CLICK    [107m[30m             ░▒▓"
set "oc_svc_tele=echo [107m[30m▓▒░     Desativando Serviços e Reduzindo Telemetria.     ░▒▓"
set "oc_bloatwre=echo [107m[30m▓▒░       Removendo Aplicativos Inúteis do Sistema       ░▒▓"
set "oc_winconfg=echo [107m[30m▓▒░          Fazendo alguns ajustes no Sistema.          ░▒▓"
set "oc_limpezao=echo [107m[30m▓▒░                  Limpeza do Sistema                  ░▒▓"
set "oc_medgecfg=echo [107m[30m▓▒░               Configuração do MS Edge.               ░▒▓"
set "oc_startmnu=echo [107m[30m▓▒░               Limpeza do Menu Iniciar.               ░▒▓"
set "oc_hiberfil=echo [107m[30m▓▒░             Configurações de Hibernação.             ░▒▓"
set "oc_clwinsxs=echo [107m[30m▓▒░               Limpeza da pasta WinSxS.               ░▒▓"
set "oc_silenton=echo [1A[42m[97m▓▒░               Modo Silencioso Ativado.               ░▒▓%reset%"

set "oneclick=cls & title W11bAlf %_ver% - Otimização OneClick & call :w11balf_wht"
set "oneclick0=%oneclick% & %oc_octitulo%& %wline% [97m"
set "oneclick1=%oneclick% & %oc_svc_tele%& %wline% [97m"
set "oneclick2=%oneclick% & %oc_bloatwre%& %wline% [97m"
set "oneclick3=%oneclick% & %oc_winconfg%& %wline% [97m"
set "oneclick4=%oneclick% & %oc_limpezao%& %wline% [97m"
set "oneclick5=%oneclick% & %oc_medgecfg%& %wline% [97m"
set "oneclick6=%oneclick% & %oc_startmnu%& %wline% [97m"
set "oneclick7=%oneclick% & %oc_hiberfil%& %wline% [97m"
set "oneclick8=%oneclick% & %oc_clwinsxs%& %wline% [97m"

set occ_10=1
set occ_20=1
set occ_30=1
set occ_40=1
set occ_50=0
set occ_60=0
set occ_70=1
set occ_80=0

:oneclick0
%oneclick0%
echo    As opções recomendadas já estão ativadas [92m(em verde)[0m[97m.
echo    Personalize a automação com os números do teclado:
echo:

:oc_escolha
set ocs_10=[0m[97m   [1][31m ██[0m[90m
set ocs_20=[0m[97m   [2][31m ██[0m[90m
set ocs_30=[0m[97m   [3][31m ██[0m[90m
set ocs_40=[0m[97m   [4][31m ██[0m[90m
set ocs_50=[0m[97m   [5][31m ██[0m[90m Ajustar o Edge para maior privacidade [100m[37m Cuidado %reset%
set ocs_60=[0m[97m   [6][31m ██[0m[90m Limpar Menu Iniciar e Taskbar         [100m[37m Cuidado %reset%
set ocs_70=[0m[97m   [7][31m ██[0m[90m
set ocs_80=[0m[97m   [8][31m ██[0m[90m

set "ocs_11=Otimizar serviços e Telemetria"
set "ocs_21=Remover Bloatware do Sistema"
set "ocs_31=Ajustes nas configurações do Windows"
set "ocs_41=Limpar profundamente o sistema"
set "ocs_51=Ajustar o Edge para maior privacidade"
set "ocs_61=Limpar Menu Iniciar e Taskbar        "
set "ocs_71=Configuração de Hibernação"
set "ocs_81=Limpeza da pasta WinSxS"

if %occ_10%==1 set ocs_10=[0m[97m   [1][92m ██[0m[97m
if %occ_20%==1 set ocs_20=[0m[97m   [2][92m ██[0m[97m
if %occ_30%==1 set ocs_30=[0m[97m   [3][92m ██[0m[97m
if %occ_40%==1 set ocs_40=[0m[97m   [4][92m ██[0m[97m
if %occ_50%==1 set ocs_50=[0m[97m   [5][92m ██[0m[97m Ajustar o Edge para maior privacidade %bvmlh% Cuidado %reset%
if %occ_60%==1 set ocs_60=[0m[97m   [6][92m ██[0m[97m Limpar Menu Iniciar e Taskbar         %bvmlh% Cuidado %reset%
if %occ_70%==1 set ocs_70=[0m[97m   [7][92m ██[0m[97m
if %occ_80%==1 set ocs_80=[0m[97m   [8][92m ██[0m[97m

set %errorlevel%=

echo %ocs_10% %ocs_11%
echo %ocs_20% %ocs_21%
echo %ocs_30% %ocs_31%
echo %ocs_40% %ocs_41%
%middleline%
echo %ocs_50%
echo %ocs_60%
%middleline%
echo %ocs_70% %ocs_71%
echo %ocs_80% %ocs_81%

echo:
echo    [0m[97m[9] ██ Iniciar o processo / Voltar ao menu principal
echo:
if %balfmode% NEQ 0 (goto oc_resultado)
%middleline%
choice /c 123456789 /n >nul
if %errorlevel%==9 goto oc_resultado
if %errorlevel%==8 (if %occ_80%==1 (set occ_80=0) else (set occ_80=1) & goto :oneclick0)
if %errorlevel%==7 (if %occ_70%==1 (set occ_70=0) else (set occ_70=1) & goto :oneclick0)
if %errorlevel%==6 (if %occ_60%==1 (set occ_60=0) else (set occ_60=1) & goto :oneclick0)
if %errorlevel%==5 (if %occ_50%==1 (set occ_50=0) else (set occ_50=1) & goto :oneclick0)
if %errorlevel%==4 (if %occ_40%==1 (set occ_40=0) else (set occ_40=1) & goto :oneclick0)
if %errorlevel%==3 (if %occ_30%==1 (set occ_30=0) else (set occ_30=1) & goto :oneclick0)
if %errorlevel%==2 (if %occ_20%==1 (set occ_20=0) else (set occ_20=1) & goto :oneclick0)
if %errorlevel%==1 (if %occ_10%==1 (set occ_10=0) else (set occ_10=1) & goto :oneclick0)
cls & goto oneclick0

:oc_resultado
chcp 65001 >nul
cls
%oneclick0%
echo    Você escolheu automatizar os seguintes processos:
if %balfmode%==1 (echo [1A   Automatizando os processos recomendados:            )
if %balfmode%==2 (echo [1A   Automatizando todos os processos:                   )
if %balfmode%==2 (set occ_10=1 & set occ_20=1 & set occ_30=1 & set occ_40=1 & set occ_50=1 & set occ_60=1 & set occ_70=1 & set occ_80=1)
echo:
if %occ_10%==1  (echo    [92m██[0m[97m %ocs_11%)
if %occ_20%==1  (echo    [92m██[0m[97m %ocs_21%)
if %occ_30%==1  (echo    [92m██[0m[97m %ocs_31%)
if %occ_40%==1  (echo    [92m██[0m[97m %ocs_41%)
if %occ_50%==1  (echo    [92m██[0m[97m %ocs_51% %bvmlh% Cuidado %reset%)
if %occ_60%==1  (echo    [92m██[0m[97m %ocs_61% %bvmlh% Cuidado %reset%)
if %occ_70%==1  (echo    [92m██[0m[97m %ocs_71%)
if %occ_80%==1  (echo    [92m██[0m[97m %ocs_81%)
echo:
echo    Deseja continuar com essas escolhas?
if %balfmode% NEQ 0 (echo [1A   Iniciando os processos em %balftime% segundos. & timeout /t %balftime% /nobreak >nul & if %silent%==1 (set "silent=>nul 2>&1" & goto oc_acao_silent) else (goto oc_acao))
if %occ_10%==0 if %occ_20%==0 if %occ_30%==0 if %occ_40%==0 if %occ_50%==0 if %occ_60%==0 if %occ_70%==0 if %occ_80%==0 (echo [4A[41m[97m   Nenhuma opção foi escolhida. Volte e faça sua escolha.   [0m[97m)
echo:
echo    [1] Continuar
echo    [2] Alterar opções
echo    [3] Voltar ao menu principal
choice /c 123 /n >nul
if %errorlevel%==3 goto w11menu
if %errorlevel%==2 goto oneclick0
if %errorlevel%==1 goto oc_acao

:oc_acao
cls & %oneclick0%
if %occ_10%==1 (call :oneclick1)
if %occ_20%==1 (call :oneclick2)
if %occ_30%==1 (call :oneclick3)
if %occ_40%==1 (call :oneclick4)
set "ison=0" & ping www.google.com -n 1 -w 1000 >nul 2>&1 && (set "ison=1") || (set "ison=0")
if %ison%==0 set occ_50=0
if %occ_50%==1 (call :oneclick5)
if %occ_60%==1 (call :oneclick6)
if %occ_70%==1 (call :oneclick7)
if %occ_80%==1 (call :oneclick8)
goto oc_end

:oc_acao_silent
cls
echo [107m[30m▓▒░                                                      ░▒▓
echo ▓▒░     W11bALF %_ver% - Modo automático silencioso.     ░▒▓
echo ▓▒░                                                      ░▒▓%reset%
echo:
if %occ_10%==1 (echo    Serviços e Telemetria     & call :svc_tele %silent%)
if %occ_20%==1 (echo    Removendo Bloatware       & call :bloatwre %silent%)
if %occ_30%==1 (echo    Configurando o Windows    & call :winconfg %silent%)
if %occ_40%==1 (echo    Limpando o Sistema        & call :limpezao %silent%)
if %occ_50%==1 (echo    Configurando o Edge       & call :medgecfg %silent%)
if %occ_60%==1 (echo    Limpando o Menu Iniciar e a Taskbar & call :startmnu %silent%)
if %occ_70%==1 (echo    Configurando a Hibernação & set hiberauto=1 & call :hiberfil %silent%)
if %occ_80%==1 (echo    Limpando a pasta WinSxS   & call :clwinsxs %silent%)
echo:
echo %verde%   Obrigado por usar o W11bALF^!
echo    Fechando o programa em 10 segundos... & timeout /t 10 /nobreak >nul & exit

:oc_end
cls
echo [42m[97m▓▒░                                                      ░▒▓
echo [42m[97m▓▒░             █ █ █ ▄█ ▄█  █▄▄ ▄▀█ █   █▀▀             ░▒▓
echo [42m[97m▓▒░             ▀▄▀▄▀  █  █  █▄█ █▀█ █▄▄ █▀              ░▒▓
echo [42m[97m▓▒░                                                      ░▒▓
echo [42m[97m▓▒░                 Otimização ONE CLICK                 ░▒▓
echo [42m[97m▓▒░                                                      ░▒▓[0m[97m
echo:
echo    O modo OneClick do W11bALF foi concluído com sucesso.
echo    Pressione qualquer tecla para voltar ao menu principal.
if %balfmode% NEQ 0 (echo [1A   Fechando o programa em 10 segundos...                    & timeout /t 10 /nobreak >nul & exit)
pause >nul
goto w11menu

:oneclick1
%oneclick1%
call :svc_tele
echo    [92mProcesso concluído!                                      [0m[97m& echo    Avançando para próxima etapa                             & echo    ... & timeout /t 2 >nul
goto:eof

:oneclick2
%oneclick2%
call :bloatwre
echo    [92mProcesso concluído!                                      [0m[97m& echo    Avançando para próxima etapa                             & echo    ... & timeout /t 2 >nul
goto:eof

:oneclick3
%oneclick3%
call :winconfg
echo    [92mProcesso concluído!                                      [0m[97m& echo    Avançando para próxima etapa                             & echo    ... & timeout /t 2 >nul
goto:eof

:oneclick4
%oneclick4%
call :limpezao
echo    [92mProcesso concluído!                                      [0m[97m& echo    Avançando para próxima etapa                             & echo    ... & timeout /t 2 >nul
goto:eof

:oneclick5
%oneclick5%
call :medgecfg
echo    [92mProcesso concluído!                                      [0m[97m& echo    Avançando para próxima etapa                             & echo    ... & timeout /t 2 >nul
goto:eof

:oneclick6
%oneclick6%
call :startmnu
echo    [92mProcesso concluído!                                      [0m[97m& echo    Avançando para próxima etapa                             & echo    ... & timeout /t 2 >nul
goto:eof


:oneclick7
%oneclick7%
set hiberauto=1 & call :hiberfil
echo    [92mProcesso concluído!                                      [0m[97m& echo    Avançando para próxima etapa                             & echo    ... & timeout /t 2 >nul
goto:eof

:oneclick8
%oneclick8%
call :clwinsxs
echo    [92mProcesso concluído!                                      [0m[97m& echo    Avançando para próxima etapa                             & echo    ... & timeout /t 2 >nul
goto:eof

::
::
::

:svc_tele
set "endtask=schtasks /end /tn "
set "dsbltsk=schtasks /change /tn "

set progstep1=░[90m
set progstep2=█
set progstep3=[92m█

:: Tela principal - Serviços e telemetria
echo    %progstep1% Desativando alguns serviços... %reset%
echo ⠀  %progstep1% Alterando outros para o modo manual... %reset%
echo    %progstep1% Alterando outros para o modo automático com delay... %reset%
echo    %progstep1% Setando alguns essenciais para o modo automático... %reset%
echo    %progstep1% Reduzindo a Telemetria... %reset%

timeout /t 1 >nul

:: Serviços para desativar
echo [5A   %progstep2% Desativando alguns serviços... %reset%

for %%G in (AJRouter AppVClient AssignedAccessManagerSvc DiagTrack DialogBlockingService NetTcpPortSharing RemoteAccess RemoteRegistry UevAgentService shpamsvc ssh-agent tzautoupdate uhssvc XblAuthManager XblGameSave XboxNetApiSvc) do (sc config %%G start= disabled >nul 2>&1)
	
echo [1A   %progstep3% Desativando alguns serviços... %reset%
:: Serviços para alterar para o modo manual
echo    %progstep2% Alterando outros para o modo manual... %reset%

for %%G in (ALG AppIDSvc AppMgmt AppReadiness AppXSvc Appinfo AxInstSV BDESVC BTAGService BcastDVRUserService_dc2a4 BluetoothUserService_dc2a4 Browser CDPSvc COMSysApp CaptureService_dc2a4 CertPropSvc ClipSVC ConsentUxUserSvc_dc2a4 CredentialEnrollmentManagerUserSvc_dc2a4 CscService DcpSvc DevQueryBroker DeviceAssociationBrokerSvc_dc2a4 DeviceAssociationService DeviceInstall DevicePickerUserSvc_dc2a4 DevicesFlowUserSvc_dc2a4 DisplayEnhancementService DmEnrollmentSvc DsSvc DsmSvc EFS EapHost EntAppSvc FDResPub Fax FrameServer FrameServerMonitor GraphicsPerfSvc HomeGroupListener HomeGroupProvider HvHost IEEtwCollectorService IKEEXT InstallService InventorySvc IpxlatCfgSvc KtmRm LicenseManager LxpSvc MSDTC MSiSCSI McpManagementService MessagingService_dc2a4 MicrosoftEdgeElevationService MixedRealityOpenXRSvc MsKeyboardFilter NPSMSvc_dc2a4 NaturalAuthentication NcaSvc NcbService NcdAutoSetup NetSetupSvc Netlogon Netman NgcCtnrSvc NgcSvc NlaSvc P9RdrService_dc2a4 PNRPAutoReg PNRPsvc PcaSvc PeerDistSvc PenService_dc2a4 PerfHost PhoneSvc PimIndexMaintenanceSvc_dc2a4 PlugPlay PolicyAgent PrintNotify PrintWorkflowUserSvc_dc2a4 PushToInstall QWAVE RasAuto RasMan RetailDemo RmSvc RpcLocator SCPolicySvc SCardSvr SDRSVC SEMgrSvc SNMPTRAP SNMPTrap SSDPSRV ScDeviceEnum SecurityHealthService Sense SensorDataService SensorService SensrSvc SessionEnv SharedAccess SharedRealitySvc SmsRouter SstpSvc StateRepository StiSvc StorSvc TabletInputService TapiSrv TextInputManagementService TieringEngineService TimeBroker TimeBrokerSvc TokenBroker TroubleshootingSvc TrustedInstaller UI0Detect UdkUserSvc_dc2a4 UmRdpService UnistoreSvc_dc2a4 UserDataSvc_dc2a4 UsoSvc VSS VacSvc W32Time WEPHOSTSVC WFDSConMgrSvc WMPNetworkSvc WManSvc WPDBusEnum WSService WaaSMedicSvc WalletService WarpJITSvc WbioSrvc WcsPlugInService WdNisSvc WdiServiceHost WdiSystemHost WebClient Wecsvc WerSvc WiaRpc WinHttpAutoProxySvc WinRM WpcMonSvc WpnService WwanSvc XblAuthManager XblGameSave XboxGipSvc XboxNetApiSvc autotimesvc bthserv camsvc cbdhsvc_dc2a4 cloudidsvc dcsvc defragsvc diagnosticshub.standardcollector.service diagsvc dmwappushservice dot3svc edgeupdate edgeupdatem embeddedmode fdPHost fhsvc hidserv icssvc lfsvc lltdsvc lmhosts msiserver netprofm p2pimsvc p2psvc perceptionsimulation pla seclogon smphost spectrum svsvc swprv upnphost vds vm3dservice vmicguestinterface vmicheartbeat vmickvpexchange vmicrdv vmicshutdown vmictimesync vmicvmsession vmicvss vmvss wbengine wcncsvc webthreatdefsvc wercplsupport wisvc wlidsvc wlpasvc wmiApSrv workfolderssvc wuauserv wudfsvc) do (sc config %%G start= demand >nul 2>&1)

echo [1A   %progstep3% Alterando outros para o modo manual... %reset%

:: Serviços para alterar para o modo automático com delay
echo    %progstep2% Alterando outros para o modo automático com delay... %reset%

for %%G in (BITS DoSvc MapsBroker WSearch sppsvc wscsvc) do (sc config %%G start= delayed-auto >nul 2>&1)

echo [1A   %progstep3% Alterando outros para o modo automático com delay... %reset%

:: Serviços para alterar para o modo automático
echo    %progstep2% Setando alguns essenciais para o modo automático... %reset%

for %%G in (AudioEndpointBuilder Audiosrv BFE BrokerInfrastructure BthAvctpSvc BthHFSrv CDPUserSvc_dc2a4 CoreMessagingRegistrar CryptSvc DPS DcomLaunch Dhcp DispBrokerDesktopSvc Dnscache DusmSvc EventLog EventSystem FontCache KeyIso LSM LanmanServer LanmanWorkstation MpsSvc OneSyncSvc_dc2a4 Power ProfSvc RpcEptMapper RpcSs SENS SamSs Schedule SgrmBroker ShellHWDetection Spooler SysMain SystemEventsBroker TermService Themes TrkWks UserManager VGAuthService VMTools VaultSvc Wcmsvc WinDefend Winmgmt WlanSvc WpnUserService_dc2a4 gpsvc iphlpsvc mpssvc nsi tiledatamodelsvc webthreatdefusersvc_dc2a4) do (sc config %%G start= auto >nul 2>&1)

echo [1A   %progstep3% Setando alguns essenciais para o modo automático... %reset%
:: Telemetria
echo    %progstep2% Reduzindo a Telemetria... %reset%

for %%G in ("Office 15 Subscription Heartbeat" OfficeTelemetryAgentFallBack OfficeTelemetryAgentFallBack2016 OfficeTelemetryAgentLogOn OfficeTelemetryAgentLogOn2016) do (schtasks /end /tn "\Microsoft\Office\%%~G" >nul 2>&1 & schtasks /change /tn "\Microsoft\Office\%%~G" /disable >nul 2>&1)

for %%G in ("AppID\SmartScreenSpecific" "Application Experience\AitAgent" "Application Experience\Microsoft Compatibility Appraiser" "Application Experience\ProgramDataUpdater" "Application Experience\StartupAppTask" "Autochk\Proxy" "CloudExperienceHost\CreateObjectTask" "Customer Experience Improvement Program\BthSQM" "Customer Experience Improvement Program\Consolidator" "Customer Experience Improvement Program\KernelCeipTask" "Customer Experience Improvement Program\Uploader" "Customer Experience Improvement Program\UsbCeip" "DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" "DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver" "DiskFootprint\Diagnostics" "FileHistory\File History (maintenance mode)" "Maintenance\WinSAT" "NetTrace\GatherNetworkInfo" "PI\Sqm-Tasks" "Power Efficiency Diagnostics\AnalyzeSystem" "Shell\FamilySafetyMonitor" "Shell\FamilySafetyRefresh" "Shell\FamilySafetyUpload" "Windows Error Reporting\QueueReporting" "WindowsUpdate\Automatic App Update") do (schtasks /end /tn "\Microsoft\Windows\%%~G" >nul 2>&1 & schtasks /change /tn "\Microsoft\Windows\%%~G" /disable >nul 2>&1)

echo [1A   %progstep3% Reduzindo a Telemetria... %reset%
echo:
goto:eof

::
::
::

:bloatwre
set /a "prog_total=63"
set /a "prog_etapa=0"
set /a bloatun=0
set "barsize=47"

%bloatwre%
echo:
echo:
echo:
dir /b /a:d %LocalAppData%\Packages > %temp%\bloatlist.txt
dir /b /a:d %SystemRoot%\SystemApps >> %temp%\bloatlist.txt

for %%N in (46928bounde.EclipseManager 7EE7776C.LinkedInforWindows 9E2F88E3.Twitter ActiproSoftwareLLC.562882FEEB491 AdobeSystemIncorporated.AdobePhotoshop ClearChannelRadioDigital.iHeartRadio Clipchamp.Clipchamp D5EA27B7.Duolingo-LearnLanguagesforFree Flipboard.Flipboard king.com.CandyCrushSaga king.com.CandyCrushSodaSaga Microsoft.3DBuilder Microsoft.549981C3F5F10 Microsoft.Advertising.Xaml Microsoft.Appconnector Microsoft.BingFinance Microsoft.BingFoodAndDrink Microsoft.BingNews Microsoft.BingSports Microsoft.BingTranslator Microsoft.BingTravel Microsoft.BingWeather Microsoft.CommsPhone Microsoft.GetHelp Microsoft.Getstarted Microsoft.GroupMe10 Microsoft.ConnectivityStore Microsoft.FreshPaint Microsoft.Messaging Microsoft.Microsoft3DViewer Microsoft.MicrosoftOfficeHub Microsoft.MicrosoftPowerBIForWindows Microsoft.MicrosoftSolitaireCollection Microsoft.MinecraftUWP Microsoft.MixedReality.Portal Microsoft.NetworkSpeedTest Microsoft.Office.OneNote Microsoft.Office.Sway Microsoft.OfficeLens Microsoft.OneConnect Microsoft.People Microsoft.PowerAutomateDesktop Microsoft.Print3D Microsoft.SkypeApp Microsoft.Todos Microsoft.Wallet Microsoft.Windows.Phone Microsoft.WindowsFeedbackHub Microsoft.WindowsMaps Microsoft.WindowsPhone Microsoft.Xbox.TCUI Microsoft.XboxApp Microsoft.XboxGameOverlay Microsoft.XboxGamingOverlay Microsoft.XboxIdentityProvider Microsoft.XboxSpeechToTextOverlay Microsoft.YourPhone Microsoft.ZuneVideo PandoraMediaInc.29680B314EFC2 ShazamEntertainmentLtd.Shazam SpotifyAB.SpotifyMusic Microsoft.Windows.Cortana ReincubateLtd.CamoStudio) do (
	chcp 437 > nul
	findstr /i "%%~N" %temp%\bloatlist.txt >nul
	if !errorlevel!==0 (set /a bloatun+=1 & PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage '%%N' | Remove-AppxPackage" >nul)
	chcp 65001 > nul
	echo [3A[97m   Procurando por %%N...                                    
	set /a prog_etapa+=1
	set /a "porcentagem=(!prog_etapa!*100)/%prog_total%"	
	set /a "barras=(!porcentagem!*%barsize%)/100"
	set "barrap="
	for /L %%i in (1 1 !barras!) do set "barrap=!barrap!▄"
	echo [1A   !bloatun! programas desinstalados.
	echo:
	echo [1A   [97m█!barrap![0m[107m[30m !porcentagem!%% [0m)
echo [3A[97m   Pesquisa por bloatwares concluída.                       
echo [1B[92m   █!barrap![0m[42m[97m !porcentagem!%% [0m
echo:
if exist "%localappdata%\Microsoft\OneDrive\OneDrive.exe" (
	ping www.google.com -n 1 -w 1000 >nul 2>&1 | find /i "TTL=" >nul && (
		echo    OneDrive detectado ^| Desinstalando...
		winget uninstall Microsoft.OneDrive --accept-source-agreements >nul 2>&1
	) || (
		echo    OneDrive detectado ^| Desinstalando...
		%SystemRoot%\System32\OneDriveSetup.exe /silent /uninstall >nul 2>&1
	)
)
	echo [1A                                                            
goto:eof

::
::
::

:winconfg
echo    Fazendo alguns ajustes no Windows...
for %%G in (AllowAutoGameMode AutoGameModeEnabled) do (reg add HKCU\Software\Microsoft\GameBar /v %%G /t REG_DWORD /d 1 /f >nul 2>&1)
for %%G in (RestrictImplicitInkCollection RestrictImplicitTextCollection) do (reg add HKCU\Software\Microsoft\InputPersonalization /v %%G /t REG_DWORD /d 1 /f >nul 2>&1)
for %%G in (EnableHwkbTextPrediction MultilingualEnabled) do (reg add HKCU\Software\Microsoft\Input\Settings /v %%G /t REG_DWORD /d 0 /f >nul 2>&1)
for %%G in (SubscribedContent-338393Enabled SubscribedContent-353694Enabled SubscribedContent-353696Enabled OemPreInstalledAppsEnabled PreInstalledAppsEnabled PreInstalledAppsEverEnabled SilentInstalledAppsEnabled SoftLandingEnabled SubscribedContent-310093Enabled SubscribedContent-314563Enabled SubscribedContent-338389Enabled SubscribedContent-338393Enabled SubscribedContent-353694Enabled SubscribedContent-353696Enabled SubscribedContent-353698Enabled SystemPaneSuggestionsEnabled) do (reg add HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v %%G /t REG_DWORD /d 0 /f >nul 2>&1)
for %%G in (HideFileExt IconsOnly NavPaneShowAllFolders ShowSyncProviderNotifications ShowTaskViewButton Start_TrackProgs TaskbarAnimations) do (reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v %%G /t REG_DWORD /d 0 /f >nul 2>&1)
for %%G in (LaunchTo ListviewAlphaSelect ListviewShadow NavPaneExpandToCurrentFolder) do (reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v %%G /t REG_DWORD /d 1 /f >nul 2>&1)
for %%G in (Accessibility AppSync BrowserSettings Credentials DesktopTheme Language PackageState Personalization StartLayout Windows) do (reg add HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\%%G /v Enabled /t reg_DWORD /d 0 /f >nul 2>&1)
for %%G in (DisableApplicationSettingSync DisableAppSyncSettingSync DisableCredentialsSettingSync DisableCredentialsSettingSyncUserOverride DisableDesktopThemeSettingSync DisableDesktopThemeSettingSyncUserOverride DisablePersonalizationSettingSync DisablePersonalizationSettingSyncUserOverride DisableSettingSync DisableStartLayoutSettingSync DisableStartLayoutSettingSyncUserOverride DisableSyncOnPaidNetwork DisableWebBrowserSettingSync DisableWebBrowserSettingSyncUserOverride DisableWindowsSettingSync DisableWindowsSettingSyncUserOverride) do (reg add HKLM\Software\Policies\Microsoft\Windows\SettingSync /v %%G /t reg_DWORD /d 2 /f >nul 2>&1)
for %%G in (DisableAppSyncSettingSyncUserOverride DisableApplicationSettingSyncUserOverride DisableSettingSyncUserOverride) do (reg add HKLM\Software\Policies\Microsoft\Windows\SettingSync /v %%G  /t reg_dword /d 1 /f >nul 2>&1)
for %%G in (IsAADCloudSearchEnabled IsDeviceSearchHistoryEnabled IsDynamicSearchBoxEnabled IsMSACloudSearchEnabled) do (reg add HKCU\Software\Microsoft\Windows\CurrentVersion\SearchSettings /v %%G /t REG_DWORD /d 0 /f >nul 2>&1)
for %%G in (AppsUseLightTheme SystemUsesLightTheme) do (reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize /v %%G /t REG_DWORD /d 0 /f >nul 2>&1)
for %%G in (AlwaysHibernateThumbnails EnableAeroPeek) do (reg add HKCU\Software\Microsoft\Windows\DWM /v %%G /t REG_DWORD /d 0 /f >nul 2>&1)
for %%G in (AllowAutoConnectToWiFiSenseHotspots AllowWiFiHotSpotReporting) do (reg add HKLM\Software\Microsoft\PolicyManager\default\WiFi\%%G /v Value /t REG_DWORD /d 0 /f >nul 2>&1)
for %%G in (ModelDownloadAllowed VoiceActivationOn) do (reg add HKLM\Software\Microsoft\Speech_OneCore\Preferences /v %%G /t REG_DWORD /d 0 /f >nul 2>&1)
for %%G in (PublishUserActivities UploadUserActivities) do (reg add HKLM\Software\Policies\Microsoft\Windows\System /v %%G /t REG_DWORD /d 0 /f >nul 2>&1)
for %%G in ("AdvertisingInfo /v Enabled" "CPSS\Store\InkingAndTypingPersonalization /v Value" "Feeds\DSB /v ShowDynamicContent" "GameDVR /v AppCaptureEnabled" "Privacy /v TailoredExperiencesWithDiagnosticDataEnabled" "Search /v SearchboxTaskbarMode" "UserProfileEngagement /v ScoobeSystemSettingEnabled") do (reg add HKCU\Software\Microsoft\Windows\CurrentVersion\%%~G /t REG_DWORD /d 0 /f >nul 2>&1)
for %%G in ("DragFullWindows /t REG_SZ /d 1" "FontSmoothing /t REG_SZ /d 2" "JPEGImportQuality /t REG_DWORD /d 100" "UserPreferencesMask /t REG_BINARY /d 9012038010000000") do (reg add "HKCU\Control Panel\Desktop" /v %%~G /f >nul 2>&1)
for %%G in ("GameBar /v UseNexusForGameBarEnabled /t REG_DWORD /d 0" "InputPersonalization\TrainedDataStore /v HarvestContacts /t REG_DWORD /d 0" "Input\Settings\proc_1\loc_0409\im_1 /v Prediction /t REG_DWORD /d 0" "MediaPlayer\Preferences /v UsageTracking /t REG_DWORD /d 0" "Personalization\Settings /v AcceptedPrivacyPolicy /t REG_DWORD /d 0" "Siuf\Rules /v NumberOfSIUFInPeriod /t REG_DWORD /d 0" "Speech_OneCore\Settings\OnlineSpeechPrivacy /v HasAccepted /t REG_DWORD /d 0" "Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps /v AgentActivationEnabled /t REG_DWORD /d 0" "Windows\CurrentVersion\Diagnostics\DiagTrack /v ShowedToastAtLevel /t REG_DWORD /d 1" "Windows\CurrentVersion\Explorer\AutoplayHandlers /v DisableAutoPlay /t REG_DWORD /d 1" "Windows\CurrentVersion\Explorer\VisualEffects /v VisualFXSetting /t REG_DWORD /d 3" "Windows\CurrentVersion\SettingSync /v SyncPolicy /t reg_DWORD /d 5") do (reg add HKCU\Software\Microsoft\%%~G /f >nul 2>&1)
for %%G in ("CapabilityAccessManager\ConsentStore\location /v Value /t REG_SZ /d Deny" "Device Metadata /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1" "Diagnostics\DiagTrack\EventTranscriptKey /v EnableEventTranscript /t REG_DWORD /d 0" "Policies\DataCollection /v AllowTelemetry /t REG_DWORD /d 0" "Policies\DataCollection /v MaxTelemetryAllowed /t REG_DWORD /d 1") do (reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\%%~G" /f >nul 2>&1)
for %%G in ("SQMClient\Windows /v CEIPEnable /t REG_DWORD /d 0" "Windows\DataCollection /v AllowTelemetry /t REG_DWORD /d 0" "AppCompat /v AITEnable /t REG_DWORD /d 0" "AppCompat /v DisableUAR /t REG_DWORD /d 1" "MRT /v DontOfferThroughWUAU /t REG_DWORD /d 1") do (reg add HKLM\Software\Policies\Microsoft\%%~G /f >nul 2>&1)
for %%G in (AutoLogger-Diagtrack-Listener SQMLogger) do (reg add HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\%%G /v Start /t REG_DWORD /d 0 /f >nul 2>&1)
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\International\User Profile" /v HttpAcceptLanguageOptOut /t REG_DWORD /d 1 /f >nul 2>&1
reg add HKLM\System\Maps /v AutoUpdateEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32 /f /ve >nul 2>&1
reg add HKCU\Software\Policies\Microsoft\Windows\Explorer /v DisableSearchBoxSuggestions /t REG_DWORD /d 1 /f >nul 2>&1
reg add HKCU\System\GameConfigStore /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg delete HKCU\Software\Microsoft\Siuf\Rules /v PeriodInNanoSeconds /f >nul 2>&1
taskkill /f /im explorer.exe >nul 2>&1 & start explorer.exe >nul 2>&1
timeout /t 1 >nul 2>&1
:: Checagem dupla
tasklist /fi "imagename eq explorer.exe" 2>nul | find /i "explorer.exe" >nul
if %errorlevel% NEQ 0 (timeout /t 1 >nul & start explorer.exe >nul 2>&1)
tasklist /fi "imagename eq explorer.exe" 2>nul | find /i "explorer.exe" >nul
if %errorlevel% NEQ 0 (timeout /t 1 >nul & start explorer.exe >nul 2>&1)
echo [2A                                                            
goto:eof

::
::
::

:limpezao
set /a "prog_total=0"
set /a "prog_etapa=0"
set "barsize=47"

set progstep1=░[90m
set progstep2=█
set progstep3=[92m█

echo    %progstep1% Cache do Microsoft Edge
echo    %progstep1% Cache da Ferramenta de Captura
echo    %progstep1% Cache de alguns outros programas
echo    %progstep1% Pastas de Drivers não usados
echo    %progstep1% .tmp .log .chk .old .bak .dmp

echo [5A   %progstep2% Cache do Microsoft Edge
taskkill /f /im "msedge.exe" >nul 2>&1
del /f /s /q "%localappdata%\Microsoft\Edge\User Data\*.log" >nul 2>&1
del /f /s /q "%localappdata%\Microsoft\Edge\User Data\*.pma" >nul 2>&1
del /f /s /q "%localappdata%\Microsoft\Edge\User Data\*.dmp" >nul 2>&1
del /f /s /q "%localappdata%\Microsoft\Edge\User Data\data_*." >nul 2>&1
del /f /s /q "%localappdata%\Microsoft\Edge\User Data\f_*." >nul 2>&1
del /f /s /q "%localappdata%\Microsoft\Edge\User Data\*index." >nul 2>&1
echo [1A   %progstep3% Cache do Microsoft Edge[0m[97m
::
echo    %progstep2% Cache da Ferramenta de captura
del /f /s /q "%localappdata%\Packages\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\TempState\ScreenClip\*" >nul 2>&1
echo [1A   %progstep3% Cache da Ferramenta de captura[0m[97m
::
echo    %progstep2% Cache de alguns outros programas
::Capcut
taskkill /f /im "capcut.exe" >nul 2>&1
rd /s /q "%localappdata%\CapCut\User Data\Cache" >nul 2>&1
::OneDrive
taskkill /f /im "onedrive.exe" >nul 2>&1
del /f /s /q "%localappdata%\Microsoft\OneDrive\*.odl" >nul 2>&1
del /f /s /q "%localappdata%\Microsoft\OneDrive\*.aodl" >nul 2>&1
del /f /s /q "%localappdata%\Microsoft\OneDrive\*.otc" >nul 2>&1
del /f /s /q "%localappdata%\Microsoft\OneDrive\*.qmlc" >nul 2>&1
::Spotify
taskkill /f /im "spotify.exe" >nul 2>&1
del /f /s /q %localappdata%\Spotify\*.log >nul 2>&1
del /f /s /q %localappdata%\Spotify\*.pma >nul 2>&1
del /f /s /q %localappdata%\Spotify\data_*. >nul 2>&1
del /f /s /q %localappdata%\Spotify\f_*. >nul 2>&1
del /f /s /q %localappdata%\Spotify\Data\*.file >nul 2>&1
::Adobe...
del /f /s /q "%appdata%\Adobe\Common\Media Cache files\*.*">nul 2>&1
echo [1A   %progstep3% Cache de alguns outros programas[0m[97m

echo    %progstep2% Pastas de Drivers não usados
rd /s /q %SYSTEMDRIVE%\AMD >nul 2>&1
rd /s /q %SYSTEMDRIVE%\NVIDIA >nul 2>&1
rd /s /q %SYSTEMDRIVE%\INTEL >nul 2>&1
echo [1A   %progstep3% Pastas de Drivers não usados[0m[97m

del /f /s /q %LocalAppData%\Microsoft\Windows\Explorer\*.* >nul 2>&1
del /f /s /q %systemdrive%\$Recycle.Bin\*.* >nul 2>&1
del /f /s /q %temp%\*.* >nul 2>&1
del /f /s /q %windir%\temp\*.* >nul 2>&1
del /f /s /q %ProgramData%\Microsoft\Windows Defender\Support\*.* >nul 2>&1

set "winclean=%WinDir%"
if %deepclean%==1 (set "winclean=%SystemDrive%")

echo    %progstep2% Procurando arquivos .tmp que podem ser deletados 1/6
forfiles /p %winclean%\ /m *.tmp /s /c "cmd /c echo @path" 2>nul >%temp%\limplist.txt
echo [1A   %progstep2% Procurando arquivos .log que podem ser deletados 2/6
forfiles /p %winclean%\ /m *.log /s /c "cmd /c echo @path" 2>nul >>%temp%\limplist.txt
echo [1A   %progstep2% Procurando arquivos .chk que podem ser deletados 3/6
forfiles /p %winclean%\ /m *.chk /s /c "cmd /c echo @path" 2>nul >>%temp%\limplist.txt
echo [1A   %progstep2% Procurando arquivos .old que podem ser deletados 4/6
forfiles /p %winclean%\ /m *.old /s /c "cmd /c echo @path" 2>nul >>%temp%\limplist.txt
echo [1A   %progstep2% Procurando arquivos .bak que podem ser deletados 5/6
forfiles /p %winclean%\ /m *.bak /s /c "cmd /c echo @path" 2>nul >>%temp%\limplist.txt
echo [1A   %progstep2% Procurando arquivos .dmp que podem ser deletados 6/6
forfiles /p %winclean%\ /m *.dmp /s /c "cmd /c echo @path" 2>nul >>%temp%\limplist.txt
for /f %%G in ('findstr /r /c:"." %temp%\limplist.txt ^| find /c "."') do set /a prog_total+=%%G
echo [1A   %progstep2% Deletando arquivos .tmp .log .chk .old .bak .dmp    
echo:
for /f %%G in ('findstr /r /c:"." %temp%\limplist.txt') do (
	del /f /s /q %%~G >nul 2>&1
	set /a prog_etapa+=1
	set /a "porcentagem=(!prog_etapa!*100)/%prog_total%"
	set /a "barras=(!porcentagem!*%barsize%)/100"
	set "barrap="
	for /L %%i in (1 1 !barras!) do set "barrap=!barrap!█"
	echo [1A   [97m█!barrap![0m[107m[30m !porcentagem!%% [0m)
echo [2A   %progstep3% Arquivos .tmp .log .chk .old .bak .dmp deletados[0m[97m
echo    [92m█!barrap![0m[42m[97m !porcentagem!%% [0m
del /f /s /q %temp%\limplist.txt >nul 2>&1
%underline%
echo:
goto:eof

::
::

:medgecfgaviso
set "ison=0" & ping www.google.com -n 1 -w 1000 >nul 2>&1 && (set "ison=1") || (set "ison=0")
if %ison%==0 msg * Não é possível utilizar essa função sem conexão com a internet. & goto w11menu
%medgecfg%
echo    Essa função irá configurar o seu Microsoft Edge para 
echo    maior privacidade mas também %bvmlh% deslogará você da sua %reset%
echo    %bvmlh% conta do Edge e de várias outras sessões ativas. %reset%
echo:
echo %branc%   Isso é recomendado apenas para NOVAS INSTALAÇÕES DO W11  %reset%
echo:
echo    Deseja continuar?
echo:
echo    [1] Sim, quero continuar.
echo    [2] Não, quero voltar ao menu principal.
echo:
set /p "medgecfgconf=⠀⠀⠀["
if %medgecfgconf%==2 goto w11menu
if %medgecfgconf%==1 (%medgecfg% & call :medgecfg & %endmenu%)
msg * Esta não é uma opção válida. & goto medgecfgaviso

:medgecfg
%medgecfg%
echo    Configurando o Microsoft Edge...
taskkill /F /IM "msedge.exe" >nul 2>&1
curl -o "%localappdata%\Microsoft\Edge\User Data\Default\Preferences." "https://raw.githubusercontent.com/rubem-psd/W11bALF/main/Recursos/Navegadores/Microsoft%%20Edge/Preferences" >nul 2>&1
curl -o "%localappdata%\Microsoft\Edge\User Data\Default\Secure Preferences." "https://raw.githubusercontent.com/rubem-psd/W11bALF/main/Recursos/Navegadores/Microsoft%%20Edge/Secure%%20Preferences" >nul 2>&1
%underline%
echo:
goto:eof

::
::

:startmnuaviso
%startmnu%
echo    Essa função irá desfixar %bvmlh% TODOS OS ÍCONES do %reset%
echo    %bvmlh% menu iniciar e da barra de tarefas. %reset%
echo:
echo    Se você já personalizou o menu iniciar e a barra de
echo    tarefas  essa função não será útil para você.
echo:
echo %branc%   Isso é recomendado APENAS para NOVAS INSTALAÇÕES DO W11  %reset%
echo    Deseja continuar?
echo:
echo    [1] Sim, quero continuar.
echo    [2] Não, quero voltar ao menu principal.
echo:
set /p "startmnuconf=⠀⠀⠀["
if %startmnuconf%==2 goto w11menu
if %startmnuconf%==1 (%startmnu% & call :startmnu & %endmenu%)
msg * Esta não é uma opção válida. & goto startmnuaviso

:startmnu
echo    Desfixando ícones da barra de tarefas...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" /v "Favorites" /t REG_BINARY /d "ff" /f >nul 2>&1
echo    Desfixando ícones do menu iniciar...
echo -----BEGIN CERTIFICATE----- > %temp%\start2enc.bin
for %%G in (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 "TSz1QZdkum5Y3uC7wc7paXh1rm11nwluCC7jiA==") do (echo %%~G >> %temp%\start2enc.bin) >nul 2>&1
echo -----END CERTIFICATE----- >> %temp%\start2enc.bin
del /f /s /q %localappdata%\Packages\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\LocalState\start2.bin >nul 2>&1
certutil -decode %temp%\start2enc.bin %localappdata%\Packages\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\LocalState\start2.bin >nul 2>&1
timeout /t 1 >nul 2>&1
taskkill /f /im explorer.exe >nul 2>&1 & start explorer.exe >nul 2>&1
timeout /t 1 >nul 2>&1
tasklist /fi "imagename eq explorer.exe" 2>nul | find /i "explorer.exe" >nul
%underline%
echo:
goto:eof

::
::
::

:hiberfil
echo [90m------------------[0m[97m  HDD  -  SSD  -  NVME  [0m[90m------------------[0m[97m
echo      Verificando o tipo de armazenamento do seu sistema     
echo                            .....                            
echo:
set /a drvs=0 & set nvmes=0 & set ssds=0 & set hdds=0 & set sysdrvtype=[31mDesconhecido[0m
set "hiberon=powercfg /h on" & set "hiberoff=powercfg /h off" & set "hiberredu=powercfg /h /type reduced"
:: HDD
set "hiberhdd=echo [90m------------------ [42m[97m HDD [0m[90m -  SSD  -  NVME  ------------------"
::SSD
set "hiberssd=echo [90m------------------  HDD  - [42m[97m SSD [0m[90m -  NVME  ------------------"
::NVMe
set "hibernvme=echo [90m------------------  HDD  -  SSD  - [42m[97m NVME [0m[90m ------------------"
chcp 437 >nul
powershell "get-physicaldisk | Select FriendlyName,MediaType" >%temp%\w11storage.txt
::
:: O código abaixo está codificado em UTF-16LE (2000) + Base64
:: pois essa era a única forma de executar um script powershell
:: diretamente no cmd sem a necessidade de criar um arquivo .ps1
::
:: Você pode conferir o código original
:: colando todo o código no link abaixo
:: https://gchq.github.io/CyberChef/#recipe=From_Base64('A-Za-z0-9%2B/%3D' true false)Decode_text('UTF-16LE%20(1200)')
::
:: Basicamente ele cria o arquivo SysDriveInfo.txt na pasta temp exibindo o Drive em que o Windows está instalado e
:: o tipo de dispositivo que ele é (HDD  SSD  NVME).
::
powershell -NoLogo -NonInteractive -NoProfile -ExecutionPolicy Bypass -Enc SQBuAHYAbwBrAGUALQBDAG8AbQBtAGEAbgBkACAALQBTAGMAcgBpAHAAdABCAGwAbwBjAGsAIAB7ACAAJABkAEkAbgBmAG8AIAA9ACAARwBlAHQALQBXAG0AaQBPAGIAagBlAGMAdAAgAFcAaQBuADMAMgBfAGwAbwBnAGkAYwBhAGwAZABpAHMAawAgAC0ARgBpAGwAdABlAHIAIAAnAEQAZQB2AGkAYwBlAEkAZAAgAD0AIAAiAEMAOgAiACcAIAB8ACAAUwBlAGwAZQBjAHQAIABEAGUAdgBpAGMAZQBJAEQALAAgAEQAcgBpAHYAZQBUAHkAcABlADsAIAAkAHcAIAA9ACAARwBlAHQALQBXAG0AaQBPAGIAagBlAGMAdAAgAC0AQwBsAGEAcwBzACAATQBTAEYAVABfAFAAaAB5AHMAaQBjAGEAbABEAGkAcwBrACAALQBOAGEAbQBlAHMAcABhAGMAZQAgAHIAbwBvAHQAXABNAGkAYwByAG8AcwBvAGYAdABcAFcAaQBuAGQAbwB3AHMAXABTAHQAbwByAGEAZwBlACAAfAAgAFMAZQBsAGUAYwB0ACAARgByAGkAZQBuAGQAbAB5AE4AYQBtAGUALAAgAE0AZQBkAGkAYQBUAHkAcABlADsAIABpAGYAIAAoACQAdwAuAG0AZQBkAGkAYQB0AHkAcABlACAALQBlAHEAIAAzACkAIAB7ACAAJAB0AHkAcABlACAAPQAgACIASABEAEQAIgAgAH0AIABlAGwAcwBlAGkAZgAgACgAJAB3AC4AbQBlAGQAaQBhAHQAeQBwAGUAIAAtAGUAcQAgADQAIAAtAGEAbgBkACAAJAB3AC4AZgByAGkAZQBuAGQAbAB5AG4AYQBtAGUAIAAtAGwAaQBrAGUAIAAiACoATgBWAE0AZQAqACIAKQAgAHsAIAAkAHQAeQBwAGUAIAA9ACAAIgBOAFYATQBlACIAIAB9ACAAZQBsAHMAZQBpAGYAIAAoACQAdwAuAG0AZQBkAGkAYQB0AHkAcABlACAALQBlAHEAIAA0ACAALQBhAG4AZAAgACQAdwAuAGYAcgBpAGUAbgBkAGwAeQBuAGEAbQBlACAALQBuAG8AdABsAGkAawBlACAAIgAqAE4AVgBNAGUAKgAiACkAIAB7ACAAJAB0AHkAcABlACAAPQAgACIAUwBTAEQAIgAgAH0AOwAgAFsAUABTAEMAdQBzAHQAbwBtAE8AYgBqAGUAYwB0AF0AQAB7ACAAVAB5AHAAZQAgAD0AIAAkAHQAeQBwAGUAOwAgAEQAcgBpAHYAZQBMAGUAdAB0AGUAcgAgAD0AIAAkAGQAaQBuAGYAbwAuAEQAZQB2AGkAYwBlAEkARAAgAH0AIAB9AA== >nul >%temp%\SysDriveInfo.txt
chcp 65001 >nul
for /f "tokens=3" %%J in ('find /c /i "nvme" "%temp%\w11storage.txt"') do set nvmes=%%J & set /a drvs+=%%J
for /f "tokens=3" %%G in ('find /c /i "ssd" "%temp%\w11storage.txt"') do set ssds=%%G & set /a drvs+=%%G
for /f "tokens=3" %%H in ('find /c /i "hdd" "%temp%\w11storage.txt"') do set hdds=%%H & set /a drvs+=%%H
sysdrv=%SystemDrive%

find /i "hdd" %temp%\SysDriveInfo.txt >nul
	if %errorlevel%==0 set sysdrvtype=HDD
find /i "ssd" %temp%\SysDriveInfo.txt >nul
	if %errorlevel%==0 set sysdrvtype=SSD
find /i "nvme" %temp%\SysDriveInfo.txt >nul
	if %errorlevel%==0 set sysdrvtype=NVME

echo:
if %hiberauto%==1 (goto hiberauto) else (goto hibermenu)

:hibermenu
cls
%hiberfil%
if %sysdrvtype%==NVME (%hibernvme%)
if %sysdrvtype%==SSD (%hiberssd%)
if %sysdrvtype%==HDD (%hiberhdd%)
echo                      %hdds%      %ssds%      %nvmes%
%underline%
echo:
echo    O W11 está instalado em um [107m[30m %sysdrvtype% [0m[97m na unidade [107m[30m %SystemDrive% [0m[97m
if %sysdrvtype%==NVME (echo    Para sistemas em um [107m[30m NVME [0m[97m é recomendado desativar & echo    a hibernação para economizar espaço.)
if %sysdrvtype%==SSD (echo    Para sistemas em um [107m[30m SSD [0m[97m é recomendado desativar & echo    a hibernação para economizar espaço.)
if %sysdrvtype%==HDD (echo    Para sistemas em um [107m[30m HDD [0m[97m é recomendado reduzir & echo    o tamanho do arquivo hiberfil.sys.)
%underline%
echo:
if %sysdrvtype%==NVME (echo    [ 1] ██ Reduzir arquivo hiberfil.sys [0m[90m^| Irrelevante & echo    [0m[97m[ 2] [92m██[0m[97m Desativar a Hibernação       [0m[97m^| Recomendado)
if %sysdrvtype%==SSD (echo    [ 1] ██ Reduzir arquivo hiberfil.sys [0m[90m^| Irrelevante & echo    [0m[97m[ 2] [92m██[0m[97m Desativar a Hibernação       [0m[97m^| Recomendado)
if %sysdrvtype%==HDD (echo    [ 1] [92m██[0m[97m Reduzir arquivo hiberfil.sys [0m[97m^| Recomendado & echo    [0m[97m[ 2] [31m██[0m[97m Desativar a Hibernação       [0m[90m^| Não Recomendado)
echo    [0m[97m[ 3] [31m██[0m[97m Ativar a Hibernação          [0m[90m^| Não Recomendado
echo:
echo    [0m[97m[ 4] Voltar ao menu principal
set %errorlevel%=0
choice /c 1234 /n >nul

if %errorlevel% equ 4 (goto w11menu)

if %errorlevel% equ 3 (%hiberon% >nul 2>&1 & %underline%
echo [31m   Hibernação ativada![0m[97m
echo    Pressione qualquer tecla para voltar ao menu.
pause >nul & goto w11menu)

if %errorlevel% equ 2 (%hiberoff% >nul 2>&1 & %underline%
echo [92m   Hibernação desativada![0m[97m
echo    Pressione qualquer tecla para voltar ao menu.
pause >nul & goto w11menu)

if %errorlevel% equ 1 (%hiberredu% >nul 2>&1 & %underline%
echo [92m   Arquivo de hibernação reduzido![0m[97m
echo    Pressione qualquer tecla para voltar ao menu.
pause >nul & goto w11menu)
goto:eof

:hiberauto
cls
%hiberfil%
if %sysdrvtype%==NVME (%hibernvme%)
if %sysdrvtype%==SSD (%hiberssd%)
if %sysdrvtype%==HDD (%hiberhdd%)
echo                      %hdds%      %ssds%      %nvmes%
%underline%
echo    O W11 está instalado em um [107m[30m %sysdrvtype% [0m[97m na unidade [107m[30m %SystemDrive% [0m[97m
echo:
if %sysdrvtype%==HDD (%hiberredu% >nul 2>&1
echo    Otimização recomendada aplicada:
echo    [92mhiberfil.sys reduzido.[0m[97m)

if %sysdrvtype%==SSD (%hiberoff% >nul 2>&1
echo    Otimização recomendada aplicada:
echo    [92mHibernação desativada.[0m[97m)

if %sysdrvtype%==NVME (%hiberoff% >nul 2>&1
echo    Otimização recomendada aplicada:
echo    [92mHibernação desativada.[0m[97m)
echo:
goto:eof

::
::
::

:clwinsxs
echo    Esse pode ser um processo lento mas que na maioria dos
echo        casos ajuda a liberar espaço em armazenamento
echo:
echo [92m┏━━━━━━━[0m[97m Enquanto a barra abaixo estiver piscando a
echo [92m┃[0m[97m      limpeza está acontecendo e o script não travou
echo [92m┃[0m[97m                           ....
echo [92m┃[0m[97m
echo [2A
Dism /online /Cleanup-Image /StartComponentCleanup /ResetBase >nul 2>&1
echo [6A                                                            
echo ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
echo ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
echo ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
echo ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
echo ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
echo ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
echo ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
echo [9A                                                            
goto:eof

::
::
::

:ativaw11
set "ison=0" & ping www.google.com -n 1 -w 1000 >nul 2>&1 && (set "ison=1") || (set "ison=0")
if %ison%==0 msg * Não é possível utilizar essa função sem conexão com a internet. & goto w11menu
echo    Ativando o W11...
curl -o %temp%\MAS_AIO.cmd https://raw.githubusercontent.com/rubem-psd/EonWare/main/Programas/W11/MAS_AIO.cmd >nul 2>&1
start /min /wait %temp%\MAS_AIO.cmd /HWID >nul 2>&1
echo    [1A%bverd% O Windows está ativado^! %reset%
%underline%
echo:
goto:eof

::
::
::

:extras
::Copilot
set "reg_copilot=HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot /v TurnOffWindowsCopilot"
reg query %reg_copilot% >nul 2>&1 & if %errorlevel%==1 reg add %reg_copilot% /t REG_DWORD /d 1
for /f %%G in ('reg query %reg_copilot% ^| find /c "0x1"') do (set copilotoff=%%G)

::Modo Escuro
set "reg_light=HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize /v"
for /f %%G in ('reg query %reg_light% AppsUseLightTheme ^| find /c "0x1"') do (set lightmode=%%G)

cls
call :w11balf_WHT
echo [107m[30m▓▒░                    Opções extras.                    ░▒▓
echo [107m[30m▓▒░                                                      ░▒▓%reset%
echo:
echo    %branc% UTILIDADES %reset%
echo:
if %lightmode%==1 (echo    [1] Ativar modo escuro [90m^| Atualmente desativado [m) else (echo    [1] Desativar modo escuro [90m^| Atualmente ativado %reset%)
if %copilotoff%==0 (echo    [2] Desativar o Windows Copilot [90m^| Atualmente ativado [m ) else (echo    [2] Ativar o Windows Copilot [90m^| Atualmente desativado %reset%)
echo:
echo    [R] Reiniciar o Explorer e aplicar alterações visuais
echo:
%middleline%
echo:
echo    [0] Voltar ao menu principal
echo:
set /p "extra=⠀⠀⠀["

if /i %extra%==R (
	taskkill /im explorer.exe /f >nul 2>&1
	start explorer.exe >nul 2>&1
	timeout /t 1 >nul 2>&1
	tasklist /fi "imagename eq explorer.exe" 2>nul | find /i "explorer.exe" >nul
		if %errorlevel% NEQ 0 (timeout /t 1 >nul & start explorer.exe >nul 2>&1)
	tasklist /fi "imagename eq explorer.exe" 2>nul | find /i "explorer.exe" >nul
		if %errorlevel% NEQ 0 (timeout /t 1 >nul & start explorer.exe >nul 2>&1)
	goto extras)

if %extra%==2 (if %copilotoff%==0 (reg add %reg_copilot% /t REG_DWORD /d 1 /f & goto extras) else (reg add %reg_copilot% /t REG_DWORD /d 0 /f & goto extras))

if %extra%==1 (if %lightmode%==1 (reg add %reg_light% AppsUseLightTheme /t REG_DWORD /d 0 /f >nul 2>&1 & reg add %reg_light% SystemUsesLightTheme /t REG_DWORD /d 0 /f >nul 2>&1 & goto extras) else (reg add %reg_light% AppsUseLightTheme /t REG_DWORD /d 1 /f >nul 2>&1 & reg add %reg_light% SystemUsesLightTheme /t REG_DWORD /d 1 /f >nul 2>&1 & goto extras))

if %extra%==0 (goto w11menu)
goto extras


:configs
cls
call :w11balf_WHT
echo [107m[30m▓▒░               Configurações do W11bALF               ░▒▓
echo ▓▒░                                                      ░▒▓
echo ▓▒░                                                      ░▒▓%reset%
echo:
set stt1=[31m██[90m
set brutcfg=Modo de limpeza profunda

if %deepclean%==1 set stt1=[92m██[97m

set %errorlevel%=0

echo    [1] %stt1% %brutcfg% %reset%
echo    [2] Voltar ao menu
echo:
echo:
echo:
echo:
echo:
echo:
echo:
echo:
echo        [90mMais opções em breve!

choice /c 12 /n 
if %errorlevel% EQU 2 (goto w11menu)
if %errorlevel% EQU 1 (if %deepclean% EQU 1 (set deepclean=0) else (set deepclean=1) & goto configs)
goto configs

::
::
::

:w11balf_WHT
echo [107m[30m▓▒░                                                      ░▒▓
echo [107m[30m▓▒░                                                      ░▒▓
echo [107m[30m▓▒░             █ █ █ ▄█ ▄█  █▄▄ ▄▀█ █   █▀▀             ░▒▓
echo [107m[30m▓▒░             ▀▄▀▄▀  █  █  █▄█ █▀█ █▄▄ █▀              ░▒▓
echo [107m[30m▓▒░                                                      ░▒▓[0m[97m
goto:eof

:w11balf_RED
echo [41m[97m▓▒░                                                      ░▒▓
echo [41m[97m▓▒░                                                      ░▒▓
echo [41m[97m▓▒░             █ █ █ ▄█ ▄█  █▄▄ ▄▀█ █   █▀▀             ░▒▓
echo [41m[97m▓▒░             ▀▄▀▄▀  █  █  █▄█ █▀█ █▄▄ █▀              ░▒▓
echo [41m[97m▓▒░                                                      ░▒▓[0m[97m
goto:eof

:w11balf_GRN
echo [42m[97m▓▒░                                                      ░▒▓
echo [42m[97m▓▒░                                                      ░▒▓
echo [42m[97m▓▒░             █ █ █ ▄█ ▄█  █▄▄ ▄▀█ █   █▀▀             ░▒▓
echo [42m[97m▓▒░             ▀▄▀▄▀  █  █  █▄█ █▀█ █▄▄ █▀              ░▒▓
echo [42m[97m▓▒░                                                      ░▒▓[0m[97m
goto:eof

:msg
echo x=msgbox("%~1"  0  "%~2") > %tmp%\tmp.vbs && cscript //nologo //T:%~3 %tmp%\tmp.vbs & del %tmp%\tmp.vbs
goto:eof