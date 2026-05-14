@echo off
setlocal EnableDelayedExpansion
chcp 65001 >nul
set "beep=echo "
mode con:cols=60 lines=40

:::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                                        ▀▀▀        ::
:: █▀▀ █▀█ █▄ █ █▀▀ █ █▀▀ █ █ █▀█ ▄▀█ █▀▀ █▀█ █▀▀ █▀ ::
:: █▄▄ █▄█ █ ▀█ █▀  █ █▄█ █▄█ █▀▄ █▀█ █▄▄ █▄█ ██▄ ▄█ ::
::                                     ▄             ::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:::: Iniciar o programa no modo automático?
:: 0 = Não (padrão)
:: 1 - Automatiza as atividades recomendadas
:: 2 - Automatiza TODOS as atividades (saiba o que está fazendo)
::            ↓
set "balfmode=0"


:::: Quantos segundos você deseja esperar até o início do modo automático?
:: Padrão = 5
::            ↓
set "balftime=5"


:::: Deseja ativar o modo silencioso? (Exibe muito menos informações na tela, mas APENAS durante a execução do modo automático).
:: 0 = Desativado
:: 1 = Ativado
::          ↓
set "silent=0"


:::: Deseja ativar a limpeza+? Adiciona algumas pastas e arquivos extras a tarefa de limpeza. Dê uma olhada em :limpeza_plus para ver o que será limpo. Essa lista será atualizada a medida que for necessário.
:: Padrão = 0
::             ↓
set "limpeza_plus=0"


:::: Qual preset de configuração deseja aplicar no Microsoft Edge?
:: 1 = Basico (padrão)
:: 2 = Seguro
:: 3 = Hardened
::             ↓
:: set "medgetipo=1"
:: ~~~~~~~~~~ Esse recurso será atualizado ~~~~~~~~~~


:::: Detalhar o funcionamento de cada atividade antes de iniciá-la? (Essa opção é ignorada quando o modo automático está ativado)
:: 0 = Não, iniciar atividade diretamente.
:: 1 = Sim, mostrar detalhes antes de iniciar. (Padrão)
::        ↓
set "info=1"


:::: Desinstalações opcionais ::::
:: 0 = Não desinstalar
:: 1 = Desinstalar
::
:: Desinstalar OneDrive?
::           ↓
set "delapp1=1"
::
:: Desinstalar Xbox?
::           ↓
set "delapp2=1"


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::                                                                                              ::::
::::  Precisa de ajuda? Acesse a página do projeto no github:  https://github.com/ru-bem/W11bALF  ::::
::::                                                                                              ::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::                                                                                              ::::
:::: W11bALF - Windows 11 but A Little Faster ----------- Criado com amor por Rubem Júnior - 2025 ::::
::::                                                                                              ::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


:load
title Iniciando o W11bALF
echo:
echo:
echo    Iniciando o programa, aguarde...

:::: Versão do programa
set _ver=1.5.0

:::: Cores
set reset=[m[38;2;255;255;255m

set cin01=[m[38;2;064;064;064m
set cin02=[m[38;2;128;128;128m
set cin03=[m[38;2;255;255;255m
set cin11=[m[48;2;064;064;064m
set cin12=[m[48;2;128;128;128m
set cin13=[m[48;2;255;255;255m[38;2;000;000;000m

set grn01=[m[38;2;000;192;000m
set grn02=[m[38;2;000;128;000m
set grn11=[m[48;2;000;192;000m[38;2;000;000;000m
set grn12=[m[48;2;000;128;000m[38;2;255;255;255m
set grn13=[m[48;2;255;255;255m[38;2;000;128;000m

set red01=[m[38;2;255;000;000m
set red02=[m[38;2;192;000;000m
set red11=[m[48;2;128;000;000m[38;2;255;255;255m

:: Enfeites
set "wline=echo %cin13%▓▒░                                                      ░▒▓%reset%"
set "underline=echo %cin01%____________________________________________________________%reset%"
set "middleline=echo %cin01%────────────────────────────────────────────────────────────%reset%"

:: Progresso
(set "endmenu=echo %grn01%   Processo concluído com sucesso!                          %reset%& echo    Pressione qualquer tecla para voltar ao menu            & pause >nul & goto w11menu")

:: Processos separados
set "svc_tele=cls & title W11bAlf v%_ver% - Serviços e Telemetria        & call :w11balf_wht & echo %cin13%▓▒░     Desativando Serviços e Reduzindo Telemetria.     ░▒▓& %wline% & echo [1A%cin03%"
set "bloatwre=cls & title W11bAlf v%_ver% - Remoção de Bloatware         & call :w11balf_wht & echo %cin13%▓▒░       Removendo Aplicativos Inúteis do Sistema       ░▒▓& %wline% & echo [1A%cin03%"
set "winconfg=cls & title W11bAlf v%_ver% - Configurações do Windows     & call :w11balf_wht & echo %cin13%▓▒░          Fazendo alguns ajustes no Sistema.          ░▒▓& %wline% & echo [1A%cin03%"
set "limpezao=cls & title W11bAlf v%_ver% - Limpeza do sistema           & call :w11balf_wht & echo %cin13%▓▒░                  Limpeza do Sistema                  ░▒▓& %wline% & echo [1A%cin03%"
:: set "medgecfg=cls & title W11bAlf v%_ver% - Configuração do MS Edge      & call :w11balf_wht & echo %cin13%▓▒░        Configuração do MS Edge -EXPERIMENTAL-        ░▒▓& %wline% & echo [1A%cin03%"
set "startmnu=cls & title W11bAlf v%_ver% - Limpeza do Menu Iniciar      & call :w11balf_wht & echo %cin13%▓▒░               Limpeza do Menu Iniciar.               ░▒▓& %wline% & echo [1A%cin03%"
set "hiberfil=cls & title W11bAlf v%_ver% - Configurações de Hibernação  & call :w11balf_wht & echo %cin13%▓▒░             Configurações de Hibernação.             ░▒▓& %wline% & echo [1A%cin03%"
set "clwinsxs=cls & title W11bAlf v%_ver% - Limpeza da pasta WinSxS      & call :w11balf_wht & echo %cin13%▓▒░               Limpeza da pasta WinSxS.               ░▒▓& %wline% & echo [1A%cin03%"
set "ativaw11=cls & title W11bAlf v%_ver% - Ativação do Windows          & call :w11balf_wht & echo %cin13%▓▒░                 Ativação do Windows.                 ░▒▓& %wline% & echo [1A%cin03%"


set new_upd=0
set /a winget_chk=0
set progstep1=░[90m
set progstep2=[97m█
set progstep3=%grn01%█

set "powershell=PowerShell -ExecutionPolicy Unrestricted -Command"

set secret_office=0


:: Requisitar permissões de administrador
if not "%1"=="am_admin" (echo    Quando solicitado %cin13% clique em %grn12% "SIM" %reset%& chcp 437 >nul & %powershell% "Start-Process -Verb RunAs -FilePath '%0' -ArgumentList 'am_admin'" & chcp 65001 >nul & exit /b)

:chk_update
call :update

:: Verifica a versão do Windows
:w11_chk
echo [5A%cin13%▓▒░                                                      ░▒▓
echo %cin13%▓▒░           Verificando versão do Windows...           ░▒▓
echo %cin13%▓▒░                                                      ░▒▓%reset%
ver | find "10.0.2" > nul && (goto w11menu) || (goto nw11)

:: Por segurança, caso você não esteja usando o W11.
:nw11
%som%
cls
title Versão do sistema não compatível
call :w11balf_red
echo %red11%▓▒░          VOCÊ NÃO ESTÁ USANDO O WINDOWS 11.          ░▒▓
echo %red11%▓▒░                                                      ░▒▓
echo %reset%
echo    Tenha em mente que o programa não foi testado em outros
echo    sistemas, portanto, podem ocorrer erros inesperados.
%underline%
echo %cin03%
echo    Deseja continuar mesmo assim?
echo:
echo    [1] %red11% SIM %reset%^| %cin03%Continuarei por minha conta e risco.
echo    [2] %grn12% NÃO %reset%^| %cin03%Atualizarei o sistema antes.
echo:
choice /C 12  /N
if %errorlevel%==2 exit
if %errorlevel%==1 goto w11menu


:: Menu principal
:w11menu
mode con:cols=60 lines=40
if %balfmode% NEQ 0 goto oneclick
echo %reset%
cls
title W11bAlf v%_ver%
echo ░▒▓%cin13%                                                      %reset%▓▒░
echo ░▒▓%cin13%                                                      %reset%▓▒░
echo ░▒▓%cin13%             %grn13%█ █ █ ▄█ ▄█  █▄▄ ▄▀█ █   █▀▀%cin13%             %reset%▓▒░
echo ░▒▓%cin13%             %grn13%▀▄▀▄▀  █  █  █▄█ █▀█ █▄▄ █▀ %cin13%             %reset%▓▒░
echo ░▒▓%cin13%                                                      %reset%▓▒░
echo ░▒▓%cin13%            W11 but A Little Faster v%_ver%            %reset%▓▒░
echo ░▒▓%cin13%            %grn12%  github.com/ ru-bem/W11bALF  %cin13%            %reset%▓▒░
echo ░▒▓%cin13%                                                      %reset%▓▒░
echo ░▒▓%cin13%                                                      %reset%▓▒░
echo ░▒▓%cin13%        %reset%                                             █▓▒░
echo ░▒▓%cin13%        %reset%                                             █▓▒░
echo ░▒▓%cin13%  [ 1]  %reset%  ONE-CLICK ^| Modo automático                █▓▒░
echo ░▒▓%cin13%        %reset%                                             █▓▒░
echo ░▒▓████████%cin01%─────────────────────────────────────────────%reset%█▓▒░
echo ░▒▓%cin13%        %reset%                                             █▓▒░
echo ░▒▓%cin13%  [ 2]  %reset%  Serviços e Telemetria %cin01%─────────────────────%reset%█▓▒░
echo ░▒▓%cin13%  [ 3]  %reset%  Desinstalar Bloatware %cin01%─────────────────────%reset%█▓▒░
echo ░▒▓%cin13%  [ 4]  %reset%  Configurar o Windows %cin01%──────────────────────%reset%█▓▒░
echo ░▒▓%cin13%  [ 5]  %reset%  Limpeza do Sistema %cin01%────────────────────────%reset%█▓▒░
echo ░▒▓%cin13%  [ 6]  %reset%  Limpar Menu Iniciar e Taskbar %cin01%─────────────%reset%█▓▒░
echo ░▒▓%cin13%  [ 7]  %reset%  Configurar Hibernação %cin01%─────────────────────%reset%█▓▒░
echo ░▒▓%cin13%  [ 8]  %reset%  Limpar a pasta WinSxS %cin01%─────────────────────%reset%█▓▒░
echo ░▒▓%cin13%  [ 9]  %reset%  Ativar o Windows %cin01%──────────────────────────%reset%█▓▒░
echo ░▒▓%cin13%  [ 0]  %reset%  Microsoft Office 365 %cin01%──────────────────────%reset%█▓▒░
:: É importante ressaltar que o script de ativação NÃO FOI CRIADO POR MIM. ::
:: Todos os créditos por isso ao "Massgravel":                             ::
:: https://github.com/massgravel/Microsoft-Activation-Scripts              ::


echo ░▒▓%cin13%        %reset%                                             █▓▒░
echo ░▒▓████████%cin01%─────────────────────────────────────────────%reset%█▓▒░
echo ░▒▓%cin13%        %reset%                                             █▓▒░
echo ░▒▓%cin13%  [ A]  %grn01%  Contribua com o projeto %cin01%───────────────────%reset%█▓▒░
echo ░▒▓%cin13%  [ B]  %reset%  Visitar a página do projeto %cin01%───────────────%reset%█▓▒░
echo ░▒▓%cin13%  [ C]  %reset%  Configurações %cin01%─────────────────────────────%reset%█▓▒░
echo ░▒▓%cin13%  [ D]  %reset%  Extras %cin01%────────────────────────────────────%reset%█▓▒░
echo ░▒▓%cin13%  [ E]  %reset%  Buscar por atualizações %cin01%───────────────────%reset%█▓▒░
if %new_upd%==1 (echo [1A░▒▓%grn12%  [ E]    Atualização Disponível: %cin13% %ver_new_ajustada% %grn12%            %reset%█▓▒░)
if %new_upd%==2 (echo [1A░▒▓%cin13%  [ E]  %red01%  Sem conexão com a internet %cin01%────────────────%reset%█▓▒░)
if %new_upd%==3 (echo [1A░▒▓%cin13%  [ E]  %reset%  Você está atualizado^^! v%ver_major%.%ver_minor%.%ver_patch% %cin01%──────────────%reset%█▓▒░)
echo ░▒▓%cin13%  [ X]  %reset%  Sair %cin01%──────────────────────────────────────%reset%█▓▒░
echo ░▒▓%cin13%        %reset%                                             █▓▒░
echo ░▒▓%cin13%        %reset%                                             █▓▒░
echo ░▒▓%cin13%                                                      %reset%▓▒░
echo ░▒▓%cin13%  [ Digite um número ou uma letra e pressione [ENTER] %reset%▓▒░
echo ░▒▓%cin13%                                                      %reset%▓▒░
set /p "w11c=-----["

if /i %w11c%==x (exit)
if /i %w11c%==e (if %new_upd%==1 (start https://github.com/ru-bem/W11bALF/releases/latest & goto w11menu) else (call :update))
if /i %w11c%==d (goto extras)
if /i %w11c%==c (goto cfg)
if /i %w11c%==b (start https://github.com/ru-bem/W11bALF & goto w11menu)
if /i %w11c%==a (start https://livepix.gg/rubem & msg * "Muito obrigado pelo apoio^!" & goto w11menu)
if %w11c%==9 (%ativaw11% & call :ativaw11_info & %endmenu%)
if %w11c%==8 (%clwinsxs% & call :clwinsxs_info & %endmenu%)
if %w11c%==7 (set hiberauto=0 & %hiberfil% & call :hiberfil & %endmenu%)
if %w11c%==6 (call :startmnu_info & %endmenu%)
if %w11c%==5 (%limpezao% & call :limpezao_info & %endmenu%)
if %w11c%==4 (%winconfg% & call :winconfg_info & %endmenu%) 
if %w11c%==3 (%bloatwre% & call :bloatwre_info & %endmenu%)
if %w11c%==2 (%svc_tele% & call :svc_tele_info & %endmenu%)
if %w11c%==1 (call :oneclick)
if %w11c%==0 (goto msoffice)
msg * /time:2 Esta não é uma opção válida. & goto w11menu

::
:cfg
cls
call :w11balf_wht
echo:
echo:
echo    Para alterar a forma como o programa se comporta
echo    abra-o no bloco de notas e siga as instruções das
echo    primeiras linhas.
echo:
echo:
echo    [1] Voltar ao menu principal
echo:
set /p cfg=---[
if %cfg%==1 goto w11menu
goto w11menu

::
:oneclick
set "oc_octitulo=echo %cin13%▓▒░             %cin03%    Otimização ONE CLICK    %cin13%             ░▒▓"
set "oc_svc_tele=echo %cin13%▓▒░     Desativando Serviços e Reduzindo Telemetria.     ░▒▓"
set "oc_bloatwre=echo %cin13%▓▒░       Removendo Aplicativos Inúteis do Sistema       ░▒▓"
set "oc_winconfg=echo %cin13%▓▒░          Fazendo alguns ajustes no Sistema.          ░▒▓"
set "oc_limpezao=echo %cin13%▓▒░                  Limpeza do Sistema                  ░▒▓"
set "oc_medgecfg=echo %cin13%▓▒░               Configuração do MS Edge.               ░▒▓"
set "oc_startmnu=echo %cin13%▓▒░               Limpeza do Menu Iniciar.               ░▒▓"
set "oc_hiberfil=echo %cin13%▓▒░             Configurações de Hibernação.             ░▒▓"
set "oc_clwinsxs=echo %cin13%▓▒░               Limpeza da pasta WinSxS.               ░▒▓"
set "oc_silenton=echo [1A%grn12%▓▒░               Modo Silencioso Ativado.               ░▒▓%reset%"

set "oneclick=cls & title W11bAlf v%_ver% - Otimização OneClick & call :w11balf_wht"
set "oneclick0=%oneclick% & %oc_octitulo%& %wline% %cin03%"
set "oneclick1=%oneclick% & %oc_svc_tele%& %wline% %cin03%"
set "oneclick2=%oneclick% & %oc_bloatwre%& %wline% %cin03%"
set "oneclick3=%oneclick% & %oc_winconfg%& %wline% %cin03%"
set "oneclick4=%oneclick% & %oc_limpezao%& %wline% %cin03%"
set "oneclick5=%oneclick% & %oc_medgecfg%& %wline% %cin03%"
set "oneclick6=%oneclick% & %oc_startmnu%& %wline% %cin03%"
set "oneclick7=%oneclick% & %oc_hiberfil%& %wline% %cin03%"
set "oneclick8=%oneclick% & %oc_clwinsxs%& %wline% %cin03%"

set occ_10=1
set occ_20=1
set occ_30=1
set occ_40=1
set occ_50=0
set occ_60=0
set occ_70=1
set occ_80=0

:oneclick0
call :net_chk
if %ison%==0 set occ_50=0
%oneclick0%
echo:
echo    As opções recomendadas JÁ ESTÃO ATIVADAS %grn01%(em verde)%reset%.
echo    Personalize a automação com os números do teclado:
echo:
%middleline%

:oc_escolha
set ocs_10=%reset%   [1]%red01% ██%reset%
set ocs_20=%reset%   [2]%red01% ██%reset%
set ocs_30=%reset%   [3]%red01% ██%reset%
set ocs_40=%reset%   [4]%red01% ██%reset%
set ocs_50=%reset%   [5]%red01% ██%reset% Ajustar o Edge para maior privacidade %cin12% Cuidado %reset%
set ocs_60=%reset%   [6]%red01% ██%reset% Limpar Menu Iniciar e Taskbar         %cin12% Cuidado %reset%
set ocs_70=%reset%   [7]%red01% ██%reset%
set ocs_80=%reset%   [8]%red01% ██%reset%

set "ocs_11=Otimizar serviços e Telemetria"
set "ocs_21=Remover Bloatware do Sistema"
set "ocs_31=Ajustes nas configurações do Windows"
set "ocs_41=Limpar profundamente o sistema"
set "ocs_51=Ajustar o Edge para maior privacidade"
set "ocs_61=Limpar Menu Iniciar e Taskbar        "
set "ocs_71=Configuração de Hibernação"
set "ocs_81=Limpeza da pasta WinSxS"

if %occ_10%==1 set ocs_10=%reset%   [1]%grn01% ██%reset%
if %occ_20%==1 set ocs_20=%reset%   [2]%grn01% ██%reset%
if %occ_30%==1 set ocs_30=%reset%   [3]%grn01% ██%reset%
if %occ_40%==1 set ocs_40=%reset%   [4]%grn01% ██%reset%

if not %ison%==0 (
	if %occ_50%==1 set ocs_50=%reset%   [5]%grn01% ██%reset% Ajustar o Edge para maior privacidade %red11% Cuidado %reset%
	) else (
				   set ocs_50=   %cin01%[5] ██ Ajustar o Edge para maior privacidade %red11% Offline %reset%)

if %occ_60%==1 set ocs_60=%reset%   [6]%grn01% ██%reset% Limpar Menu Iniciar e Taskbar         %red11% Cuidado %reset%
if %occ_70%==1 set ocs_70=%reset%   [7]%grn01% ██%reset%
if %occ_80%==1 set ocs_80=%reset%   [8]%grn01% ██%reset%

set %errorlevel%=

echo:
echo %ocs_10% %ocs_11%
echo %ocs_20% %ocs_21%
echo %ocs_30% %ocs_31%
echo %ocs_40% %ocs_41%
echo:
%middleline%
echo %ocs_50%
echo %ocs_60%
%middleline%
echo:
echo %ocs_70% %ocs_71%
echo %ocs_80% %ocs_81%
echo:
echo:
echo    %reset%[9] %cin01%██%reset% Iniciar o processo
echo    %reset%[X] %cin01%██%reset% Voltar ao menu principal
echo:
if %balfmode% NEQ 0 (goto oc_resultado)
echo:
set /p balfsel=---[
if /i %balfsel%==x goto w11menu
if %balfsel%==9 goto oc_resultado
if %balfsel%==8 (if %occ_80%==1 (set occ_80=0) else (set occ_80=1) & goto :oneclick0)
if %balfsel%==7 (if %occ_70%==1 (set occ_70=0) else (set occ_70=1) & goto :oneclick0)
if %balfsel%==6 (if %occ_60%==1 (set occ_60=0) else (set occ_60=1) & goto :oneclick0)

if not %ison%==0 (if %balfsel%==5 (if %occ_50%==1 (set occ_50=0) else (set occ_50=1) & goto :oneclick0))

if %balfsel%==4 (if %occ_40%==1 (set occ_40=0) else (set occ_40=1) & goto :oneclick0)
if %balfsel%==3 (if %occ_30%==1 (set occ_30=0) else (set occ_30=1) & goto :oneclick0)
if %balfsel%==2 (if %occ_20%==1 (set occ_20=0) else (set occ_20=1) & goto :oneclick0)
if %balfsel%==1 (if %occ_10%==1 (set occ_10=0) else (set occ_10=1) & goto :oneclick0)
cls & goto oneclick0

:oc_resultado
chcp 65001 >nul
cls
%oneclick0%
echo:
echo    Você escolheu automatizar os seguintes processos:
if %balfmode%==1 (echo [1A   Automatizando os processos recomendados:            )
if %balfmode%==2 (echo [1A   Automatizando todos os processos:                   )
if %balfmode%==2 (set occ_10=1 & set occ_20=1 & set occ_30=1 & set occ_40=1 & set occ_50=1 & set occ_60=1 & set occ_70=1 & set occ_80=1)
echo:
%middleline%
if %occ_10%==1  (echo    %grn01%██%reset% %ocs_11%)
if %occ_20%==1  (echo    %grn01%██%reset% %ocs_21%)
if %occ_30%==1  (echo    %grn01%██%reset% %ocs_31%)
if %occ_40%==1  (echo    %grn01%██%reset% %ocs_41%)
if %occ_50%==1  (echo    %grn01%██%reset% %ocs_51% %red11% Cuidado %reset%)
if %occ_60%==1  (echo    %grn01%██%reset% %ocs_61% %red11% Cuidado %reset%)
if %occ_70%==1  (echo    %grn01%██%reset% %ocs_71%)
if %occ_80%==1  (echo    %grn01%██%reset% %ocs_81%)
%middleline%
echo:
echo    Deseja continuar com essas escolhas?
if %balfmode% NEQ 0 (echo [1A   Iniciando os processos em %balftime% segundos. & timeout /t %balftime% /nobreak >nul & if %silent%==1 (set "silent=>nul 2>&1" & goto oc_acao_silent) else (goto oc_acao))
if %occ_10%==0 if %occ_20%==0 if %occ_30%==0 if %occ_40%==0 if %occ_50%==0 if %occ_60%==0 if %occ_70%==0 if %occ_80%==0 (echo [4A%red11%   Nenhuma opção foi escolhida. Volte e faça sua escolha.   %reset%)
echo:
echo    [1] Sim, inicie as atividades.
echo    [2] Não, eu quero alterar as opções.
echo    [3] Não, eu quero voltar ao menu principal.
echo:
set /p balfsel2=---[
if %balfsel2%==3 goto w11menu
if %balfsel2%==2 goto oneclick0
if %balfsel2%==1 goto oc_acao

:oc_acao
cls & %oneclick0%
if %occ_10%==1 (call :oneclick1)
if %occ_20%==1 (call :oneclick2)
if %occ_30%==1 (call :oneclick3)
if %occ_40%==1 (call :oneclick4)
if %occ_50%==1 (call :oneclick5)
if %occ_60%==1 (call :oneclick6)
if %occ_70%==1 (call :oneclick7)
if %occ_80%==1 (call :oneclick8)
goto oc_end

:oc_acao_silent
cls
echo %cin13%▓▒░                                                      ░▒▓
echo ▓▒░     W11bALF v%_ver% - Modo automático silencioso.     ░▒▓
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
echo %grn01%   Obrigado por usar o W11bALF^!
echo    Fechando o programa em 10 segundos... & timeout /t 10 /nobreak >nul & exit

:oc_end
cls
echo %grn12%▓▒░                                                      ░▒▓
echo ▓▒░             █ █ █ ▄█ ▄█  █▄▄ ▄▀█ █   █▀▀             ░▒▓
echo ▓▒░             ▀▄▀▄▀  █  █  █▄█ █▀█ █▄▄ █▀              ░▒▓
echo ▓▒░                                                      ░▒▓
echo ▓▒░                 Otimização ONE CLICK                 ░▒▓
echo ▓▒░                                                      ░▒▓%reset%
echo:
echo    O modo OneClick do W11bALF foi concluído com sucesso.
echo    Pressione qualquer tecla para voltar ao menu principal.
if %balfmode% NEQ 0 (echo [1A   Fechando o programa em 10 segundos...                    & timeout /t 10 /nobreak >nul & exit)
pause >nul
goto w11menu

:oneclick1
%oneclick1%
call :svc_tele
echo    %grn01%Processo concluído!                                      %reset%& echo    Avançando para próxima etapa                             & echo    ... & timeout /t 2 >nul
goto:eof

:oneclick2
%oneclick2%
call :bloatwre
echo    %grn01%Processo concluído!                                      %reset%& echo    Avançando para próxima etapa                             & echo    ... & timeout /t 2 >nul
goto:eof

:oneclick3
%oneclick3%
call :winconfg
echo    %grn01%Processo concluído!                                      %reset%& echo    Avançando para próxima etapa                             & echo    ... & timeout /t 2 >nul
goto:eof

:oneclick4
%oneclick4%
call :limpezao
echo    %grn01%Processo concluído!                                      %reset%& echo    Avançando para próxima etapa                             & echo    ... & timeout /t 2 >nul
goto:eof

:oneclick5
%oneclick5%
call :medgecfg
echo    %grn01%Processo concluído!                                      %reset%& echo    Avançando para próxima etapa                             & echo    ... & timeout /t 2 >nul
goto:eof

:oneclick6
%oneclick6%
call :startmnu
echo    %grn01%Processo concluído!                                      %reset%& echo    Avançando para próxima etapa                             & echo    ... & timeout /t 2 >nul
goto:eof


:oneclick7
%oneclick7%
set hiberauto=1 & call :hiberfil
echo    %grn01%Processo concluído!                                      %reset%& echo    Avançando para próxima etapa                             & echo    ... & timeout /t 2 >nul
goto:eof

:oneclick8
%oneclick8%
call :clwinsxs
echo    %grn01%Processo concluído!                                      %reset%& echo    Avançando para próxima etapa                             & echo    ... & timeout /t 2 >nul
goto:eof

::
::
::

:svc_tele_info
if %info%==0 goto svc_tele
%svc_tele%
echo:
echo    %grn01%Esta é a atividade de alteração de serviços e redução
echo    de telemetria. Reduz consideravelmente a quantidade de
echo    processos em execução no sistema.
echo:
echo    Essa atividade tem maior relevância em computadores
echo    antigos, já que neles, cada "ciclo" conta.
echo:
echo    A diferença de performance em computadores modernos
echo    pode não ser percebida.
echo:
echo:
%middleline%%cin02%
echo    Digite [9] para saber como desativar telas
echo    informativas antes do início das atividades.
%middleline%
echo:
echo:
echo    [1] Iniciar alteração de serviços e telemetria
echo    [2] Mais detalhes %cin02%(abre a página do projeto)%reset%
echo    [3] Voltar ao menu
echo:
echo:
%middleline%
echo:
set /p svc_tele_info=---[
if %svc_tele_info%==1 cls & %svc_tele% & goto svc_tele
if %svc_tele_info%==2 start https://github.com/ru-bem/W11bALF?tab=readme-ov-file#%%E2%%84%%B9%%EF%%B8%%8F-mais-informa%%C3%%A7%%C3%%B5es & goto svc_tele_info
if %svc_tele_info%==3 goto w11menu
if %svc_tele_info%==9 start https://github.com/ru-bem/W11bALF?tab=readme-ov-file#--telas-de-informa%%C3%%A7%%C3%%A3o & goto svc_tele_info
msg * Esta não é uma opção válida. & goto svc_tele_info

:svc_tele
echo:
set "endtask=schtasks /end /tn "
set "dsbltsk=schtasks /change /tn "

:: Tela principal - Serviços e telemetria
echo    %progstep1% Desativando serviços... %reset%
echo    %progstep1% Definindo inicio manual... %reset%
echo    %progstep1% Definindo início automático com delay... %reset%
echo    %progstep1% Definindo início automático... %reset%
echo    %progstep1% Reduzindo a Telemetria... %reset%

timeout /t 1 >nul

echo [5A   %progstep2% Desativando serviços... %reset%
for %%G in (
AppVClient
AssignedAccessManagerSvc
DiagTrack
DialogBlockingService
NetTcpPortSharing
RemoteAccess
RemoteRegistry
UevAgentService
shpamsvc
ssh-agent
) do (sc config %%G start=disabled >nul 2>&1)
echo [1A   %progstep3% Desativando serviços... %reset%



echo    %progstep2% Definindo inicio manual... %reset%
for %%G in (
ALG
AppMgmt
AppReadiness
Appinfo
AxInstSV
BDESVC
BTAGService
CDPSvc
COMSysApp
CertPropSvc
CscService
DevQueryBroker
DeviceAssociationService
DeviceInstall
EFS
EapHost
FDResPub
FrameServer
FrameServerMonitor
GraphicsPerfSvc
HvHost
IKEEXT
InstallService
InventorySvc
IpxlatCfgSvc
KtmRm
LicenseManager
LxpSvc
MSDTC
MSiSCSI
McpManagementService
MicrosoftEdgeElevationService
NaturalAuthentication
NcaSvc
NcbService
NcdAutoSetup
NetSetupSvc
Netman
NlaSvc
PcaSvc
PeerDistSvc
PerfHost
PhoneSvc
PlugPlay
PolicyAgent
PrintNotify
PushToInstall
QWAVE
RasAuto
RasMan
RetailDemo
RmSvc
RpcLocator
SCPolicySvc
SCardSvr
SDRSVC
SEMgrSvc
SNMPTRAP
SNMPTrap
SSDPSRV
ScDeviceEnum
SensorDataService
SensorService
SensrSvc
SessionEnv
SharedAccess
SmsRouter
SstpSvc
StiSvc
StorSvc
SunshineService
TapiSrv
TermService
TieringEngineService
TokenBroker
TroubleshootingSvc
TrustedInstaller
UmRdpService
UsoSvc
VSS
VaultSvc
W32Time
WEPHOSTSVC
WFDSConMgrSvc
WMPNetworkSvc
WManSvc
WPDBusEnum
WSAIFabricSvc
WalletService
WarpJITSvc
WbioSrvc
WdiServiceHost
WdiSystemHost
WebClient
Wecsvc
WerSvc
WiaRpc
WinRM
WpcMonSvc
WpnService
XblAuthManager
XblGameSave
XboxGipSvc
XboxNetApiSvc
autotimesvc
bthserv
camsvc
cloudidsvc
dcsvc
defragsvc
diagsvc
dmwappushservice
dot3svc
edgeupdate
edgeupdatem
fdPHost
fhsvc
hidserv
icssvc
lfsvc
lltdsvc
lmhosts
netprofm
perceptionsimulation
pla
seclogon
smphost
svsvc
swprv
upnphost
vds
vmicguestinterface
vmicheartbeat
vmickvpexchange
vmicrdv
vmicshutdown
vmictimesync
vmicvmsession
vmicvss
wbengine
wcncsvc
webthreatdefsvc
wercplsupport
wisvc
wlidsvc
wlpasvc
wmiApSrv
workfolderssvc
wuauserv
) do (sc config %%G start=demand >nul 2>&1)
echo [1A   %progstep3% Definindo inicio manual... %reset%



echo    %progstep2% Definindo início automático com delay... %reset%
for %%G in (
BITS
MapsBroker
WSearch
) do (sc config %%G start=delayed-auto >nul 2>&1)
echo [1A   %progstep3% Definindo início automático com delay... %reset%



echo    %progstep2% Definindo início automático... %reset%

for %%G in (
AudioEndpointBuilder
AudioSrv
Audiosrv
BthAvctpSvc
CryptSvc
DPS
Dhcp
DispBrokerDesktopSvc
EventLog
EventSystem
FontCache
KeyIso
LanmanServer
LanmanWorkstation
Power
ProfSvc
SENS
SamSs
ShellHWDetection
Spooler
SysMain
Themes
TrkWks
UserManager
Wcmsvc
Winmgmt
iphlpsvc
nsi
) do (sc config %%G start=auto >nul 2>&1)
echo [1A   %progstep3% Definindo início automático... %reset%




echo    %progstep2% Reduzindo a Telemetria... %reset%

for %%G in (
"Office 15 Subscription Heartbeat"
OfficeTelemetryAgentFallBack
OfficeTelemetryAgentFallBack2016
OfficeTelemetryAgentLogOn
OfficeTelemetryAgentLogOn2016
) do (
	schtasks /end /tn "\Microsoft\Office\%%~G" >nul 2>&1
	schtasks /change /tn "\Microsoft\Office\%%~G" /disable >nul 2>&1
)


for %%G in (
"AppID\SmartScreenSpecific"
"Application Experience\AitAgent"
"Application Experience\Microsoft Compatibility Appraiser"
"Application Experience\ProgramDataUpdater"
"Application Experience\StartupAppTask"
"Autochk\Proxy"
"CloudExperienceHost\CreateObjectTask"
"Customer Experience Improvement Program\BthSQM"
"Customer Experience Improvement Program\Consolidator"
"Customer Experience Improvement Program\KernelCeipTask"
"Customer Experience Improvement Program\Uploader"
"Customer Experience Improvement Program\UsbCeip"
"DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"
"DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver"
"DiskFootprint\Diagnostics"
"FileHistory\File History (maintenance mode)"
"Maintenance\WinSAT"
"NetTrace\GatherNetworkInfo"
"PI\Sqm-Tasks"
"Power Efficiency Diagnostics\AnalyzeSystem"
"Shell\FamilySafetyMonitor"
"Shell\FamilySafetyRefresh"
"Shell\FamilySafetyUpload"
"Windows Error Reporting\QueueReporting"
"WindowsUpdate\Automatic App Update"
) do (
	schtasks /end /tn "\Microsoft\Windows\%%~G" >nul 2>&1
	schtasks /change /tn "\Microsoft\Windows\%%~G" /disable >nul 2>&1
)

echo [1A   %progstep3% Reduzindo a Telemetria... %reset%
echo:
echo:
goto:eof

::
::

:bloatwre_info
if %info%==0 goto bloatwre
%bloatwre%
echo:
echo    %grn01%Esta é a atividade de desinstalação de bloatware.
echo    Não afeta o desempenho do computador, mas será útil já
echo    que remove todos os programas "inúteis" do sistema.
echo:
echo:
%middleline%%cin02%
echo    Digite [9] para saber como desativar telas
echo    informativas antes do início das atividades.
%middleline%
echo:
echo:
echo    [1] Iniciar desinstalação de bloatware.
echo    [2] Mais detalhes %cin02%(abre a página do projeto)%reset%
echo    [3] Voltar ao menu
echo:
echo:
set /p bloatwre_info=---[
if %bloatwre_info%==1 cls & %bloatwre% & echo: & goto bloatwre
if %bloatwre_info%==2 start https://github.com/ru-bem/W11bALF & goto bloatwre_info
if %bloatwre_info%==3 goto w11menu
if %bloatwre_info%==9 start https://github.com/ru-bem/W11bALF?tab=readme-ov-file#--telas-de-informa%%C3%%A7%%C3%%A3o & goto bloatwre_info
msg * Esta não é uma opção válida. & goto bloatwre_info

:bloatwre
set /a "prog_total=57"
set /a "prog_etapa=0"
set /a bloatun=0
set "barsize=47"

%bloatwre%
echo:
echo:
echo:
echo:
dir /b /a:d %LocalAppData%\Packages > %temp%\bloatlist.txt
dir /b /a:d %SystemRoot%\SystemApps >> %temp%\bloatlist.txt

for %%N in (
46928bounde.EclipseManager
7EE7776C.LinkedInforWindows
9E2F88E3.Twitter
ActiproSoftwareLLC.562882FEEB491
AdobeSystemIncorporated.AdobePhotoshop
ClearChannelRadioDigital.iHeartRadio
Clipchamp.Clipchamp
D5EA27B7.Duolingo-LearnLanguagesforFree
Flipboard.Flipboard
king.com.CandyCrushSaga
king.com.CandyCrushSodaSaga
Microsoft.3DBuilder
Microsoft.549981C3F5F10
Microsoft.Advertising.Xaml
Microsoft.Appconnector
Microsoft.BingFinance
Microsoft.BingFoodAndDrink
Microsoft.BingNews
Microsoft.BingSports
Microsoft.BingTranslator
Microsoft.BingTravel
Microsoft.BingWeather
Microsoft.CommsPhone
Microsoft.ConnectivityStore
Microsoft.FreshPaint
Microsoft.GetHelp
Microsoft.Getstarted
Microsoft.GroupMe10
Microsoft.Messaging
Microsoft.Microsoft3DViewer
Microsoft.MicrosoftOfficeHub
Microsoft.MicrosoftPowerBIForWindows
Microsoft.MicrosoftSolitaireCollection
Microsoft.MinecraftUWP
Microsoft.MixedReality.Portal
Microsoft.NetworkSpeedTest
Microsoft.Office.OneNote
Microsoft.Office.Sway
Microsoft.OfficeLens
Microsoft.OneConnect
Microsoft.People
Microsoft.PowerAutomateDesktop
Microsoft.Print3D
Microsoft.SkypeApp
Microsoft.Todos
Microsoft.Wallet
Microsoft.Windows.Cortana
Microsoft.Windows.Phone
Microsoft.WindowsFeedbackHub
Microsoft.WindowsMaps
Microsoft.WindowsPhone
Microsoft.YourPhone
Microsoft.ZuneVideo
PandoraMediaInc.29680B314EFC2
ReincubateLtd.CamoStudio
ShazamEntertainmentLtd.Shazam
SpotifyAB.SpotifyMusic
) do (
	chcp 437 > nul
	findstr /i "%%~N" %temp%\bloatlist.txt >nul
	if !errorlevel!==0 (set /a bloatun+=1 & %powershell% "Get-AppxPackage '%%N' | Remove-AppxPackage" >nul)
	chcp 65001 > nul
	echo [3A%cin03%   Procurando por %%N...                                    
	set /a prog_etapa+=1
	set /a "porcentagem=(!prog_etapa!*100)/%prog_total%"	
	set /a "barras=(!porcentagem!*%barsize%)/100"
	set "barrap="
	for /L %%i in (1 1 !barras!) do set "barrap=!barrap!▄"
	echo [1A   !bloatun! programas desinstalados.
	echo:
	echo [1A   %cin03%█!barrap![m%cin13% !porcentagem!%% [m)
echo [3A%cin03%   Pesquisa por bloatwares concluída.                       
echo [1B%grn01%   █!barrap![m%grn12% !porcentagem!%% [m
echo:
echo:
%middleline%
echo %cin02%----------------- Desinstalações opcionais -----------------%reset%
echo:
if %delapp1%==1 (goto delapp1) else (goto delapp2)

:delapp1
echo   ^> Desinstalando OneDrive
if exist "%localappdata%\Microsoft\OneDrive\OneDrive.exe" (
	ping www.google.com -n 1 -w 1000 >nul 2>&1 | find /i "TTL=" >nul && (
		echo [1A   OneDrive detectado ^| Desinstalando...
		winget uninstall Microsoft.OneDrive --accept-source-agreements >nul 2>&1
	) || (
		echo [1A   OneDrive detectado ^| Desinstalando...
		%SystemRoot%\System32\OneDriveSetup.exe /silent /uninstall >nul 2>&1))
echo [1A   %grn01%OneDrive%reset%                                                
if %delapp2%==1 (goto delapp2) else (goto delapp3)
goto:eof

:delapp2
echo   ^>Desinstalando Xbox e apps relacionados
for %%G in (9mv0b5hzvk9z 9nzkpstsnw4p 9wzdncrd1hkw 9nknc0ld5nn6 9nblggh4r32n) do (winget uninstall %%G --accept-source-agreements >nul 2>&1)
reg add HKCR\ms-gamebar /f /ve /d URL:ms-gamebar >nul 2>&1
reg add HKCR\ms-gamebar /f /v "URL Protocol" /d " " >nul 2>&1
reg add HKCR\ms-gamebar /f /v "NoOpenWith" /d " " >nul 2>&1
reg add HKCR\ms-gamebar\shell\open\command /f /ve /d "`"$env:SystemRoot\System32\systray.exe`"" >nul 2>&1
reg add HKCR\ms-gamebarservices /f /ve /d URL:ms-gamebarservices >nul 2>&1
reg add HKCR\ms-gamebarservices /f /v "URL Protocol" /d " " >nul 2>&1
reg add HKCR\ms-gamebarservices /f /v "NoOpenWith" /d " " >nul 2>&1
reg add HKCR\ms-gamebarservices\shell\open\command /f /ve /d "`"$env:SystemRoot\System32\systray.exe`"" >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR /f /t REG_DWORD /v "AppCaptureEnabled" /d 0 >nul 2>&1
reg add HKCU\System\GameConfigStore /f /t REG_DWORD /v "GameDVR_Enabled" /d 0 >nul 2>&1
echo [1A   %grn01%Xbox e apps relacionados%reset%
goto:eof

:delapp3
echo:
%middleline%
echo:
echo:
goto:eof

::
::

:winconfg_info
if %info%==0 goto winconfg
%winconfg%
echo:
echo    %grn01%Esta é a atividade de configuração do Windows 11.
echo    Automatiza o processo de configuração de vários ajustes
echo    que costumam ser feitos após uma nova instalação.
echo:
echo:
%middleline%%cin02%
echo    Digite [9] para saber como desativar telas
echo    informativas antes do início das atividades.
%middleline%
echo:
echo:
echo    [1] Iniciar a configuração do Windows.
echo    [2] Mais detalhes %cin02%(abre a página do projeto)%reset%
echo    [3] Voltar ao menu
echo:
echo:
set /p winconfg_info=---[
if %winconfg_info%==1 cls & %winconfg% & echo: & goto winconfg
if %winconfg_info%==2 start https://github.com/ru-bem/W11bALF & goto winconfg_info
if %winconfg_info%==3 goto w11menu
if %winconfg_info%==9 start https://github.com/ru-bem/W11bALF?tab=readme-ov-file#--telas-de-informa%%C3%%A7%%C3%%A3o & goto winconfg_info
msg * Esta não é uma opção válida. & goto winconfg_info





::::
:: Isso aqui precisa ser reescrito. Funciona, mas olha a bagunça!
::
:winconfg
echo    Fazendo alguns ajustes no Windows...


reg add HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32 /f /ve >nul 2>&1 :: Menu de contexto

reg add HKCU\Software\Microsoft\GameBar /v AllowAutoGameMode /t REG_DWORD /d 1 /f >nul 2>&1
reg add HKCU\Software\Microsoft\GameBar /v AutoGameModeEnabled /t REG_DWORD /d 1 /f >nul 2>&1
reg add HKCU\Software\Microsoft\GameBar /v UseNexusForGameBarEnabled /t REG_DWORD /d 0 /f >nul 2>&1

reg add HKCU\Software\Microsoft\Input\Settings /v EnableHwkbTextPrediction /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Input\Settings /v MultilingualEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Input\Settings\proc_1\loc_0409\im_1 /v Prediction /t REG_DWORD /d 0 /f >nul 2>&1

reg add HKCU\Software\Microsoft\InputPersonalization /v RestrictImplicitInkCollection /t REG_DWORD /d 1 /f >nul 2>&1
reg add HKCU\Software\Microsoft\InputPersonalization /v RestrictImplicitTextCollection /t REG_DWORD /d 1 /f >nul 2>&1
reg add HKCU\Software\Microsoft\InputPersonalization\TrainedDataStore /v HarvestContacts /t REG_DWORD /d 0 /f >nul 2>&1

reg add HKCU\Software\Microsoft\MediaPlayer\Preferences /v UsageTracking /t REG_DWORD /d 0 /f >nul 2>&1

reg add HKCU\Software\Microsoft\Personalization\Settings /v AcceptedPrivacyPolicy /t REG_DWORD /d 0 /f >nul 2>&1

reg add HKCU\Software\Microsoft\Siuf\Rules /v NumberOfSIUFInPeriod /t REG_DWORD /d 0 /f >nul 2>&1

reg add HKCU\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy /v HasAccepted /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps /v AgentActivationEnabled /t REG_DWORD /d 0 /f >nul 2>&1

reg add HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1

reg add HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v OemPreInstalledAppsEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v PreInstalledAppsEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v PreInstalledAppsEverEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v SilentInstalledAppsEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v SoftLandingEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v SubscribedContent-310093Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v SubscribedContent-314563Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v SubscribedContent-338389Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v SubscribedContent-338393Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v SubscribedContent-338393Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v SubscribedContent-353694Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v SubscribedContent-353694Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v SubscribedContent-353696Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v SubscribedContent-353696Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v SubscribedContent-353698Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v SystemPaneSuggestionsEnabled /t REG_DWORD /d 0 /f >nul 2>&1

reg add HKCU\Software\Microsoft\Windows\CurrentVersion\CPSS\Store\InkingAndTypingPersonalization /v Value /t REG_DWORD /d 0 /f >nul 2>&1

reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack /v ShowedToastAtLevel /t REG_DWORD /d 1 /f >nul 2>&1

reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v HideFileExt /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v IconsOnly /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v LaunchTo /t REG_DWORD /d 1 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v ListviewAlphaSelect /t REG_DWORD /d 1 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v ListviewShadow /t REG_DWORD /d 1 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v NavPaneExpandToCurrentFolder /t REG_DWORD /d 1 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v NavPaneShowAllFolders /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v ShowSyncProviderNotifications /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v ShowTaskViewButton /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v Start_TrackProgs /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v TaskbarAnimations /t REG_DWORD /d 0 /f >nul 2>&1

reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers /v DisableAutoPlay /t REG_DWORD /d 1 /f >nul 2>&1

reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects /v VisualFXSetting /t REG_DWORD /d 3 /f >nul 2>&1

reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds\DSB /v ShowDynamicContent /t REG_DWORD /d 0 /f >nul 2>&1

reg add HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR /v AppCaptureEnabled /t REG_DWORD /d 0 /f >nul 2>&1

reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Privacy /v TailoredExperiencesWithDiagnosticDataEnabled /t REG_DWORD /d 0 /f >nul 2>&1

reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Search /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f >nul 2>&1

reg add HKCU\Software\Microsoft\Windows\CurrentVersion\SearchSettings /v IsAADCloudSearchEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\SearchSettings /v IsDeviceSearchHistoryEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\SearchSettings /v IsDynamicSearchBoxEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\SearchSettings /v IsMSACloudSearchEnabled /t REG_DWORD /d 0 /f >nul 2>&1

reg add HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync /v SyncPolicy /t REG_DWORD /d 5 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Accessibility /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\AppSync /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\BrowserSettings /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Credentials /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\DesktopTheme /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Language /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\PackageState /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Personalization /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\StartLayout /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Windows /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1

reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize /v AppsUseLightTheme /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize /v SystemUsesLightTheme /t REG_DWORD /d 0 /f >nul 2>&1

reg add HKCU\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement /v ScoobeSystemSettingEnabled /t REG_DWORD /d 0 /f >nul 2>&1

reg add HKCU\Software\Microsoft\Windows\DWM /v AlwaysHibernateThumbnails /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\Software\Microsoft\Windows\DWM /v EnableAeroPeek /t REG_DWORD /d 0 /f >nul 2>&1

reg add HKCU\Software\Policies\Microsoft\Windows\Explorer /v DisableSearchBoxSuggestions /t REG_DWORD /d 1 /f >nul 2>&1

reg add HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots /v Value /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting /v Value /t REG_DWORD /d 0 /f >nul 2>&1

reg add HKLM\Software\Microsoft\Speech_OneCore\Preferences /v ModelDownloadAllowed /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKLM\Software\Microsoft\Speech_OneCore\Preferences /v VoiceActivationOn /t REG_DWORD /d 0 /f >nul 2>&1

reg add HKLM\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location /v Value /t REG_SZ /d Deny /f >nul 2>&1
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack\EventTranscriptKey /v EnableEventTranscript /t REG_DWORD /d 0 /f >nul 2>&1

reg add HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\DataCollection /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\DataCollection /v MaxTelemetryAllowed /t REG_DWORD /d 1 /f >nul 2>&1

reg add HKLM\Software\Policies\Microsoft\AppCompat /v AITEnable /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKLM\Software\Policies\Microsoft\AppCompat /v DisableUAR /t REG_DWORD /d 1 /f >nul 2>&1

reg add HKLM\Software\Policies\Microsoft\MRT /v DontOfferThroughWUAU /t REG_DWORD /d 1 /f >nul 2>&1

reg add HKLM\Software\Policies\Microsoft\SQMClient\Windows /v CEIPEnable /t REG_DWORD /d 0 /f >nul 2>&1

reg add HKLM\Software\Policies\Microsoft\Windows\DataCollection /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1

reg add HKLM\Software\Policies\Microsoft\Windows\SettingSync /v DisableApplicationSettingSync /t REG_DWORD /d 2 /f >nul 2>&1
reg add HKLM\Software\Policies\Microsoft\Windows\SettingSync /v DisableApplicationSettingSyncUserOverride /t REG_DWORD /d 1 /f >nul 2>&1
reg add HKLM\Software\Policies\Microsoft\Windows\SettingSync /v DisableAppSyncSettingSync /t REG_DWORD /d 2 /f >nul 2>&1
reg add HKLM\Software\Policies\Microsoft\Windows\SettingSync /v DisableAppSyncSettingSyncUserOverride /t REG_DWORD /d 1 /f >nul 2>&1
reg add HKLM\Software\Policies\Microsoft\Windows\SettingSync /v DisableCredentialsSettingSync /t REG_DWORD /d 2 /f >nul 2>&1
reg add HKLM\Software\Policies\Microsoft\Windows\SettingSync /v DisableCredentialsSettingSyncUserOverride /t REG_DWORD /d 2 /f >nul 2>&1
reg add HKLM\Software\Policies\Microsoft\Windows\SettingSync /v DisableDesktopThemeSettingSync /t REG_DWORD /d 2 /f >nul 2>&1
reg add HKLM\Software\Policies\Microsoft\Windows\SettingSync /v DisableDesktopThemeSettingSyncUserOverride /t REG_DWORD /d 2 /f >nul 2>&1
reg add HKLM\Software\Policies\Microsoft\Windows\SettingSync /v DisablePersonalizationSettingSync /t REG_DWORD /d 2 /f >nul 2>&1
reg add HKLM\Software\Policies\Microsoft\Windows\SettingSync /v DisablePersonalizationSettingSyncUserOverride /t REG_DWORD /d 2 /f >nul 2>&1
reg add HKLM\Software\Policies\Microsoft\Windows\SettingSync /v DisableSettingSync /t REG_DWORD /d 2 /f >nul 2>&1
reg add HKLM\Software\Policies\Microsoft\Windows\SettingSync /v DisableSettingSyncUserOverride /t REG_DWORD /d 1 /f >nul 2>&1
reg add HKLM\Software\Policies\Microsoft\Windows\SettingSync /v DisableStartLayoutSettingSync /t REG_DWORD /d 2 /f >nul 2>&1
reg add HKLM\Software\Policies\Microsoft\Windows\SettingSync /v DisableStartLayoutSettingSyncUserOverride /t REG_DWORD /d 2 /f >nul 2>&1
reg add HKLM\Software\Policies\Microsoft\Windows\SettingSync /v DisableSyncOnPaidNetwork /t REG_DWORD /d 2 /f >nul 2>&1
reg add HKLM\Software\Policies\Microsoft\Windows\SettingSync /v DisableWebBrowserSettingSync /t REG_DWORD /d 2 /f >nul 2>&1
reg add HKLM\Software\Policies\Microsoft\Windows\SettingSync /v DisableWebBrowserSettingSyncUserOverride /t REG_DWORD /d 2 /f >nul 2>&1
reg add HKLM\Software\Policies\Microsoft\Windows\SettingSync /v DisableWindowsSettingSync /t REG_DWORD /d 2 /f >nul 2>&1
reg add HKLM\Software\Policies\Microsoft\Windows\SettingSync /v DisableWindowsSettingSyncUserOverride /t REG_DWORD /d 2 /f >nul 2>&1

reg add HKLM\Software\Policies\Microsoft\Windows\System /v PublishUserActivities /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKLM\Software\Policies\Microsoft\Windows\System /v UploadUserActivities /t REG_DWORD /d 0 /f >nul 2>&1

reg add HKLM\SYSTEM\CurrentControlSet\Control\FileSystem /v LongPathsEnabled /t REG_DWORD /d 1 /f >nul 2>&1
reg add HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener /v Start /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger /v Start /t REG_DWORD /d 0 /f >nul 2>&1

reg add HKLM\System\Maps /v AutoUpdateEnabled /t REG_DWORD /d 0 /f >nul 2>&1

reg add "HKCU\Control Panel\Desktop" /v DragFullWindows /t REG_SZ /d 1 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v FontSmoothing /t REG_SZ /d 2 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v JPEGImportQuality /t REG_DWORD /d 100 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9012038010000000 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\International\User Profile" /v HttpAcceptLanguageOptOut /t REG_DWORD /d 1 /f >nul 2>&1

reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1 /f >nul 2>&1

reg delete HKCU\Software\Microsoft\Siuf\Rules /v PeriodInNanoSeconds /f >nul 2>&1

taskkill /f /im explorer.exe >nul 2>&1
for /l %%G in (1,1,4) do (timeout /t 1 >nul & tasklist | find /i "explorer.exe" >nul || (start explorer.exe))
echo [2A                                                            
goto:eof

::
::
::

:limpezao_info
if %info%==0 goto limpezao
%limpezao%
echo:
echo    %grn01%Esta é a atividade de limpeza do sistema.
echo    Remove arquivos temporários e cache de programas e jogos.
echo    Será útil para recuperar espaço de armazenamento.
echo:
echo    %reset%Nos navegadores, deleta apenas o CACHE, por tanto,
echo    não te deslogará de nenhum site.
echo:
%middleline%%cin02%
echo    Digite [9] para saber como desativar telas
echo    informativas antes do início das atividades.
%middleline%
echo:
echo:
echo    [1] Iniciar a limpeza do sistema
echo    [2] Mais detalhes %cin02%(abre a página do projeto)%reset%
echo    [3] Voltar ao menu
echo:
echo:
set /p limpezao_info=---[
if %limpezao_info%==1 cls & %limpezao% & goto limpezao
if %limpezao_info%==2 start https://github.com/ru-bem/W11bALF & goto limpezao_info
if %limpezao_info%==3 goto w11menu
if %limpezao_info%==9 start https://github.com/ru-bem/W11bALF?tab=readme-ov-file#--telas-de-informa%%C3%%A7%%C3%%A3o & goto limpezao_info
msg * Esta não é uma opção válida. & goto limpezao_info


:limpezao

echo    %grn01%A limpeza começou^^! %reset%
echo    Tempo estimado: %grn01%NVME = 16s~ %cin01%^|%grn01% SSD = 48s~ %cin01%^|%red01% HDD = 2m~ %reset%

echo:
echo ────────────────────────────────────────────────────────────
echo:

echo:
echo    %progstep1% Logs do Windows
echo    %progstep1% Esvaziando a lixeira
echo    %progstep1% Cache dos navegadores
echo    %progstep1% Cache e logs da NVIDIA
echo    %progstep1% Crash dumps de programas
echo    %progstep1% Limpando pastas temporarias
echo    %progstep1% Cache do MSOutlook (WebApp) e OneDrive
echo:
echo ────────────────────────────────────────────────────────────
echo:
echo    %progstep1% Cache da Adobe
echo    %progstep1% Cache da Steam
echo    %progstep1% Cache do CapCut
echo    %progstep1% Cache do Spotify
echo    %progstep1% Cache do WhatsApp
echo    %progstep1% Cache da Epic Games
echo    %progstep1% Cache do pip (Python)
echo:
echo ────────────────────────────────────────────────────────────
echo:
echo    %progstep1% Logs do Fortnite
echo    %progstep1% Cache e Logs do Roblox

::────────────────────────────────────────────────────────────
::────────────────────────────────────────────────────────────

echo [20A   %progstep2% Logs do Windows

del /f /s /q "%WinDir%\setupact.log" >nul 2>&1
del /f /s /q "%WinDir%\Logs\cbs\*.log" >nul 2>&1

attrib -s "%WinDir%\logs\measuredboot\*.*" >nul 2>&1
del /f /s /q "%WinDir%\logs\measuredboot\*.log" >nul 2>&1

attrib -h -s "%WinDir%\ServiceProfiles\LocalService\" >nul 2>&1
attrib -h -s "%WinDir%\ServiceProfiles\NetworkService\" >nul 2>&1
del /f /s /q "%WinDir%\ServiceProfiles\LocalService\AppData\Local\Temp\MpCmdRun.log" >nul 2>&1
del /f /s /q "%WinDir%\ServiceProfiles\NetworkService\AppData\Local\Temp\MpCmdRun.log" >nul 2>&1
attrib +h +s "%WinDir%\ServiceProfiles\LocalService\" >nul 2>&1
attrib +h +s "%WinDir%\ServiceProfiles\NetworkService\" >nul 2>&1

del /f /s /q "%LocalAppData%\Microsoft\*.log" >nul 2>&1

del /f /s /q "%WinDir%\inf\*.log" >nul 2>&1
del /f /s /q "%WinDir%\logs\*.log" >nul 2>&1
del /f /s /q "%WinDir%\Panther\*.log" >nul 2>&1
del /f /s /q "%WinDir%\Logs\MoSetup\*.log" >nul 2>&1
del /f /s /q "%WinDir%\Microsoft.NET\*.log" >nul 2>&1
del /f /s /q "%WinDir%\Logs\MeasuredBoot\*.log" >nul 2>&1
del /f /s /q "%WinDir%\SoftwareDistribution\*.log" >nul 2>&1
del /f /s /q "%WinDir%\Performance\WinSAT\winsat.log" >nul 2>&1

del /f /s /q "%ProgramData%\Microsoft\Windows Defender\Support\*.log" >nul 2>&1

echo [1A   %progstep3% Logs do Windows%reset%

::────────────────────────────────────────────────────────────
::────────────────────────────────────────────────────────────

echo    %progstep2% Esvaziando a lixeira

del /f /s /q "C:\$recycle.bin\*.*" >nul 2>&1

echo [1A   %progstep3% Esvaziando a lixeira%reset%

::────────────────────────────────────────────────────────────
::────────────────────────────────────────────────────────────

echo    %progstep2% Cache dos navegadores

taskkill /f /im "brave.exe" >nul 2>&1
taskkill /f /im "opera.exe" >nul 2>&1
taskkill /f /im "msedge.exe" >nul 2>&1
taskkill /f /im "vivaldi.exe" >nul 2>&1

del /f /s /q "%LocalAppData%\Vivaldi\User Data\Default\Cache\Cache_Data\*.*" >nul 2>&1
del /f /s /q "%LocalAppData%\Vivaldi\User Data\Default\Cache\Service Worker\CacheStorage\*.*" >nul 2>&1
for /l %%G in (1,1,10) do (del /f /s /q "%LocalAppData%\Vivaldi\User Data\Profile %%G\Cache\Cache_Data\*.*" >nul 2>&1)

del /f /s /q "%LocalAppData%\Google\Chrome\User Data\Default\Cache\Cache_Data\*.*" >nul 2>&1
del /f /s /q "%LocalAppData%\Google\Chrome\User Data\Default\Service Worker\CacheStorage\*.*" >nul 2>&1
for /l %%G in (1,1,10) do (del /f /s /q "%LocalAppData%\Google\Chrome\User Data\Profile %%G\Cache\Cache_Data\*.*" >nul 2>&1)

del /f /s /q "%LocalAppData%\BraveSoftware\Brave-Browser\User Data\Default\Cache\Cache_Data\*.*" >nul 2>&1
del /f /s /q "%LocalAppData%\BraveSoftware\Brave-Browser\User Data\Default\Service Worker\CacheStorage\*.*" >nul 2>&1
for /l %%G in (1,1,10) do (del /f /s /q "%LocalAppData%\BraveSoftware\Brave-Browser\User Data\Profile %%G\Cache\Cache_Data\*.*" >nul 2>&1)

del /f /s /q "%LocalAppData%\Microsoft\Edge\User Data\Default\Cache\Cache_Data\*.*" >nul 2>&1
del /f /s /q "%LocalAppData%\Microsoft\Edge\User Data\Default\Service Worker\CacheStorage\*.*" >nul 2>&1
for /l %%G in (1,1,10) do (del /f /s /q "%LocalAppData%\Microsoft\Edge\User Data\Profile %%G\Cache\Cache_Data\*.*" >nul 2>&1)

:: Não use o Opera ;)
del /f /s /q "%LocalAppData%\Opera Software\Opera Stable\User Data\Default\Cache\Cache_Data\*.*" >nul 2>&1
del /f /s /q "%LocalAppData%\Opera Software\Opera Stable\User Data\Default\Service Worker\CacheStorage\*.*" >nul 2>&1
for /l %%G in (1,1,10) do (del /f /s /q "%LocalAppData%\Opera Software\Opera Stable\User Data\Profile %%G\Cache\Cache_Data\*.*" >nul 2>&1)

del /f /s /q "%LocalAppData%\Opera Software\Opera GX Stable\User Data\Default\Cache\Cache_Data\*.*" >nul 2>&1
del /f /s /q "%LocalAppData%\Opera Software\Opera GX Stable\User Data\Default\Service Worker\CacheStorage\*.*" >nul 2>&1
for /l %%G in (1,1,10) do (del /f /s /q "%LocalAppData%\Opera GX Software\Opera Stable\User Data\Profile %%G\Cache\Cache_Data\*.*" >nul 2>&1)

echo [1A   %progstep3% Cache dos navegadores%reset%

::────────────────────────────────────────────────────────────
::────────────────────────────────────────────────────────────

echo    %progstep2% Cache e logs da NVIDIA

del /f /s /q "%ProgramData%\NVIDIA Corporation\NVIDIA App\Logs\*.*" >nul 2>&1
del /f /s /q "%ProgramData%\NVIDIA Corporation\NVIDIA App\Installer\Logs\*.*" >nul 2>&1
del /f /s /q "%LocalAppData%\NVIDIA\DXCache\*.*" >nul 2>&1

echo [1A   %progstep3% Cache e logs da NVIDIA%reset%

::────────────────────────────────────────────────────────────
::────────────────────────────────────────────────────────────

echo    %progstep2% Crash dumps de programas

del /f /s /q "%LocalAppData%\CrashDumps\*.dmp" >nul 2>&1
del /f /s /q "%WinDir%\System32\config\systemprofile\AppData\Local\CrashDumps\*.dmp" >nul 2>&1

echo [1A   %progstep3% Crash dumps de programas%reset%


::────────────────────────────────────────────────────────────
::────────────────────────────────────────────────────────────



echo    %progstep2% Limpando pastas temporarias

del /f /s /q "%temp%\*.*" >nul 2>&1
del /f /s /q "%windir%\temp\*.*" >nul 2>&1

echo [1A   %progstep3% Limpando pastas temporarias%reset%

::────────────────────────────────────────────────────────────
::────────────────────────────────────────────────────────────

echo    %progstep2% Cache do MSOutlook (WebApp) e OneDrive

del /f /s /q "%LocalAppData%\OneDrive\*.qmlc" >nul 2>&1
del /f /s /q "%LocalAppData%\Microsoft\OneDrive\*.otc" >nul 2>&1
del /f /s /q "%LocalAppData%\Microsoft\OneDrive\*.odl" >nul 2>&1
del /f /s /q "%LocalAppData%\Microsoft\OneDrive\*.aodl" >nul 2>&1
del /f /s /q "%LocalAppData%\Microsoft\OneDrive\setup\logs\*.log" >nul 2>&1
del /f /s /q "%LocalAppData%\Microsoft\Olk\EBWebView\Default\Cache\Cache_Data\*.*" >nul 2>&1
del /f /s /q "%LocalAppData%\Microsoft\Olk\EBWebView\Default\Service Worker\CacheStorage\*.*" >nul 2>&1

echo [1A   %progstep3% Cache do MSOutlook (WebApp) e OneDrive%reset%


echo:
echo ────────────────────────────────────────────────────────────
echo:

::────────────────────────────────────────────────────────────
::────────────────────────────────────────────────────────────

echo   %progstep2% Cache da Adobe

del /f /s /q "%AppData%\Adobe\Common\Media Cache files\*.*" >nul 2>&1

echo [1A   %progstep3% Cache da Adobe %reset%

::────────────────────────────────────────────────────────────
::────────────────────────────────────────────────────────────

echo    %progstep2% Cache da Steam

del /f /s /q "%LocalAppData%\Steam\htmlcache\Default\Cache\Cache_Data\*.*" >nul 2>&1

echo [1A   %progstep3% Cache da Steam%reset%

::────────────────────────────────────────────────────────────
::────────────────────────────────────────────────────────────

echo    %progstep2% Cache do CapCut

del /f /s /q "%LocalAppData%\CapCut\User Data\CEF\Cache\Cache\Cache_Data\*.*" >nul 2>&1
:: del /f /s /q "%localappdata%\CapCut\User Data\Cache\*.*" >nul 2>&1 (É melhor fazer isso pelo próprio CapCut)

echo [1A   %progstep3% Cache do CapCut%reset%

::────────────────────────────────────────────────────────────
::────────────────────────────────────────────────────────────

echo    %progstep2% Cache do Spotify

taskkill /f /im "spotify.exe" >nul 2>&1
rd /s /q "%localappdata%\Spotify\Data" >nul 2>&1
del /f /s /q "%LocalAppData%\Spotify\*.log" >nul 2>&1
del /f /s /q "%LocalAppData%\Spotify\Default\Cache\Cache_Data\*.*" >nul 2>&1
del /f /s /q "%LocalAppData%\Spotify\Browser\Cache\Cache_Data\*.*" >nul 2>&1

echo [1A   %progstep3% Cache do Spotify%reset%

::────────────────────────────────────────────────────────────
::────────────────────────────────────────────────────────────

echo    %progstep2% Cache do WhatsApp

del /f /s /q "%LocalAppData%\Packages\5319275A.WhatsAppDesktop_cv1g1gvanyjgm\LocalCache\EBWebView\Default\Cache\Cache_Data\*.*" >nul 2>&1
del /f /s /q "%LocalAppData%\Packages\5319275A.WhatsAppDesktop_cv1g1gvanyjgm\LocalCache\EBWebView\Default\Service Worker\CacheStorage\*.*" >nul 2>&1
del /f /s /q "%LocalAppData%\Packages\5319275A.51895FA4EA97F_cv1g1gvanyjgm\LocalCache\EBWebView\Default\Cache\Cache_Data\*.*" >nul 2>&1

echo [1A   %progstep3% Cache do WhatsApp%reset%

::────────────────────────────────────────────────────────────
::────────────────────────────────────────────────────────────

echo    %progstep2% Cache da Epic Games

del /f /s /q "%LocalAppData%\EpicGamesLauncher\Saved\webcache_4430\Service Worker\CacheStorage\*.*" >nul 2>&1
del /f /s /q "%LocalAppData%\EpicGamesLauncher\Saved\webcache_4430\Cache\*.*" >nul 2>&1
del /f /s /q "%LocalAppData%\Epic Games\EOSOverlay\BrowserCache\0\Default\Cache\Cache_Data\*.*" >nul 2>&1

echo [1A   %progstep3% Cache da Epic Games%reset%

::────────────────────────────────────────────────────────────
::────────────────────────────────────────────────────────────

echo    %progstep2% Cache do pip (Python)

del /f /s /q "%LocalAppData%\pip\cache\*.*" >nul 2>&1

echo [1A   %progstep3% Cache do pip (Python)%reset%


echo:
echo ────────────────────────────────────────────────────────────
echo:


echo    %progstep2% Logs do Fortnite

del /f /s /q "%LocalAppData%\FortniteGame\Saved\Logs\*.*" >nul 2>&1

echo [1A   %progstep3% Logs do Fortnite%reset%

::────────────────────────────────────────────────────────────
::────────────────────────────────────────────────────────────

echo    %progstep2% Cache e Logs do Roblox

del /f /s /q "%LocalAppData%\Roblox\Downloads\roblox-player\*.*" >nul 2>&1
del /f /s /q "%LocalAppData%\Roblox\rbx-storage\*.*" >nul 2>&1
del /f /s /q "%LocalAppData%\Roblox\logs\crashes\reports\*.*" >nul 2>&1
del /f /s /q "%LocalAppData%\Roblox\rbx-storage.db" >nul 2>&1

echo [1A   %progstep3% Cache e Logs do Roblox%reset%


echo:
echo ────────────────────────────────────────────────────────────
echo:

if %limpeza_plus%==1 goto limpeza_plus
goto:eof

::────────────────────────────────────────────────────────────
::────────────────────────────────────────────────────────────

:limpeza_plus


echo   %progstep2% Instaladores de drivers já instalados...

rd /s /q %SYSTEMDRIVE%\AMD >nul 2>&1
rd /s /q %SYSTEMDRIVE%\NVIDIA >nul 2>&1
rd /s /q %SYSTEMDRIVE%\INTEL >nul 2>&1

echo [1A   %progstep3% Instaladores de drivers já instalados... %reset%

echo:
echo ────────────────────────────────────────────────────────────
echo:

goto:eof

::
::

:medgecfg_info
call :net_chk
%medgecfg%
echo:
echo    %grn01%Esta é a atividade de configuração do Microsoft Edge.
echo    Você pode escolher entre um dos três presets criados.%reset%
echo:
echo    Digite [4] para saber o que é alterado em cada preset.
echo:
echo:
echo %red11%                                                            %reset%
echo %red11%                  ATIVIDADE %red01% EXPERIMENTAL %red11%                  %reset%
echo %red11%                                                            %reset%
echo %red11%      No momento ela pode te deslogar de vários sites.      %reset%
echo %red11%       use ou teste em novas instalações, VMs ou caso       %reset%
echo %red11%             realmente saiba o que está fazendo             %reset%
echo %red11%                                                            %reset%
echo:
%middleline%%cin02%
echo    Digite [9] para saber como desativar telas
echo    informativas antes do início das atividades.
%middleline%
echo:
echo    [1] Aplicar o preset %cin11% Basico %reset%
echo    [2] Aplicar o preset %cin11% Seguro %reset%
echo    [3] Aplicar o preset %cin11% Hardened %reset%
echo:
echo    [4] Mais detalhes %cin02%(abre a página do projeto)%reset%
echo    [5] Voltar ao menu principal
echo:
set /p medgecfg_info=---[
if %medgecfg_info%==1 set medgetipo=1 & cls & %medgecfg% & echo: & goto medgecfg
if %medgecfg_info%==2 set medgetipo=2 & cls & %medgecfg% & echo: & goto medgecfg
if %medgecfg_info%==3 set medgetipo=3 & cls & %medgecfg% & echo: & goto medgecfg
if %medgecfg_info%==4 start https://github.com/ru-bem/W11bALF?tab=readme-ov-file#--configura%C3%A7%C3%A3o-do-microsoft-edge-experimental & goto medgecfg_info
if %medgecfg_info%==5 goto w11menu
if %medgecfg_info%==9 start https://github.com/ru-bem/W11bALF?tab=readme-ov-file#--telas-de-informa%%C3%%A7%%C3%%A3o & goto medgecfg_info
msg * Esta não é uma opção válida. & goto medgecfg_info

:medgecfg
set "medgecfgurl="
if %medgetipo%==1 set "medgecfgurl=/" & set _medgetipo=basico
if %medgetipo%==2 set "medgecfgurl=/seguro/" & set _medgetipo=seguro
if %medgetipo%==3 set "medgecfgurl=/hardened/" & set _medgetipo=hardened
%medgecfg%
echo    Configurando o Microsoft Edge no modo %_medgetipo%...
taskkill /F /IM "msedge.exe" >nul 2>&1
curl -o "%localappdata%\Microsoft\Edge\User Data\Default\Preferences." "https://raw.githubusercontent.com/ru-bem/W11bALF/main/Recursos/Navegadores/Microsoft%%20Edge!medgecfgurl!Preferences" >nul 2>&1
curl -o "%localappdata%\Microsoft\Edge\User Data\Default\Secure Preferences." "https://raw.githubusercontent.com/ru-bem/W11bALF/main/Recursos/Navegadores/Microsoft%%20Edge!medgecfgurl!Secure%%20Preferences" >nul 2>&1
%middleline%
echo:
goto:eof

::
::

:startmnu_info
if %info%==0 goto startmnu
%startmnu%
echo:
echo    %grn01%Esta é a atividade de limpeza do menu iniciar.
echo    Desfixa todos os ícones do menu iniciar, muito útil
echo    para novas instalações do sistema.
echo:
echo:
%middleline%%cin02%
echo    Digite [9] para saber como desativar telas
echo    informativas antes do início das atividades.
%middleline%
echo:
echo:
echo    [1] Iniciar a atividade.
echo    [2] Mais detalhes %cin02%(abre a página do projeto)%reset%
echo    [3] Voltar ao menu
echo:
echo:
set /p startmnu_info=---[
if %startmnu_info%==1 cls & %startmnu% & echo: & goto startmnu
if %startmnu_info%==2 start https://github.com/ru-bem/W11bALF & goto startmnu_info
if %startmnu_info%==3 goto w11menu
if %startmnu_info%==9 start https://github.com/ru-bem/W11bALF?tab=readme-ov-file#--telas-de-informa%%C3%%A7%%C3%%A3o & goto startmnu_info
msg * Esta não é uma opção válida. & goto startmnu_info

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
for /l %%G in (1,1,4) do (timeout /t 1 >nul & tasklist | find /i "explorer.exe" >nul || (start explorer.exe))
echo:
%middleline%
echo:
goto:eof

::
::
::

:hiberfil
echo [2A
echo %grn12%                                                            %reset%
echo %grn12%      Esta é a atividade de configuração de hibernação      %reset%
echo %grn12%     Será útil principalmente para economizar espaço em     %reset%
echo %grn12%         disco sem afetar nenhuma função importante         %reset%
echo %grn12%                                                            %reset%
echo:
echo %cin02%------------------%reset%  HDD  -  SSD  -  NVME  %cin02%------------------%reset%
echo      Verificando o tipo de armazenamento do seu sistema     
echo                            .....                            
echo:
set sysdrvtype=%red01%Desconhecido[m
set "hiberon=powercfg /h on"
set "hiberoff=powercfg /h off"
set "hibermin=powercfg /h /type reduced"

:: HDD
set "hiberhdd=echo %cin02%------------------ %grn12% HDD %cin02% -  SSD  -  NVME  ------------------"
:: SSD
set "hiberssd=echo %cin02%------------------  HDD  - %grn12% SSD %cin02% -  NVME  ------------------"
:: NVMe
set "hibernvme=echo %cin02%------------------  HDD  -  SSD  - %grn12% NVME %cin02% ------------------"

call :drive_type silent
set sysdrv=%SystemDrive%

echo:
if %hiberauto%==1 (goto hiberauto) else (goto hibermenu)

:hibermenu
cls
%hiberfil%
echo [2A
echo %grn12%                                                            %reset%
echo %grn12%      Esta é a atividade de configuração de hibernação      %reset%
echo %grn12%     Será útil principalmente para economizar espaço em     %reset%
echo %grn12%         disco sem afetar nenhuma função importante         %reset%
echo %grn12%                                                            %reset%
echo:
if %sysdrvtype%==NVME (%hibernvme%)
if %sysdrvtype%==SSD (%hiberssd%)
if %sysdrvtype%==HDD (%hiberhdd%)
%underline%
echo:
echo    O W11 está instalado em um %cin13% %sysdrvtype% %reset% na unidade %cin13% %SystemDrive% %reset%
if %sysdrvtype%==NVME (echo %grn01%   Recomendação: Desativar hibernação para ganhar espaço.%reset%)
if %sysdrvtype%==SSD (echo %grn01%   Recomendação: Desativar hibernação para ganhar espaço.%reset%)
if %sysdrvtype%==HDD (echo %grn01%   Recomendação: Reduzir o tamanho do arquivo hiberfil.sys.%reset%)
%underline%
echo:
if %sysdrvtype%==NVME (echo    [ 1] ██ Reduzir arquivo hiberfil.sys %cin02%^| Irrelevante & echo    %reset%[ 2] %grn01%██%reset% Desativar a Hibernação       %grn01%^| Recomendado)
if %sysdrvtype%==SSD (echo    [ 1] ██ Reduzir arquivo hiberfil.sys %cin02%^| Irrelevante & echo    %reset%[ 2] %grn01%██%reset% Desativar a Hibernação       %grn01%^| Recomendado)
if %sysdrvtype%==HDD (echo    [ 1] %grn01%██%reset% Reduzir arquivo hiberfil.sys %grn02%^| Recomendado & echo    %reset%[ 2] %red01%██%reset% Desativar a Hibernação       %red01%^| Não Recomendado%reset%)
echo    %reset%[ 3] %red01%██%reset% Ativar a Hibernação          %red01%^| Não Recomendado
echo:
echo    %reset%[ 4] Voltar ao menu principal
echo:
set /p hiber_op=---[
if %hiber_op%==4 (goto w11menu)
if %hiber_op%==3 (%hiberon% >nul 2>&1 & %hiberfil% & echo %red01%   Hibernação ativada! %reset% & echo    Pressione qualquer tecla para voltar ao menu. & pause >nul & goto w11menu)
if %hiber_op%==2 (%hiberoff% >nul 2>&1 & %hiberfil% & echo %grn01%   Hibernação desativada! %reset% & echo    Pressione qualquer tecla para voltar ao menu. & pause >nul & goto w11menu)
if %hiber_op%==1 (%hibermin% >nul 2>&1 & %hiberfil% & echo %grn01%   Arquivo de hibernação reduzido! %reset% & echo    Pressione qualquer tecla para voltar ao menu. & pause >nul & goto w11menu)
msg * Esta não é uma opção válida. & goto hibermenu
goto:eof

:hiberauto
cls
%hiberfil%
if %sysdrvtype%==NVME (%hibernvme%)
if %sysdrvtype%==SSD (%hiberssd%)
if %sysdrvtype%==HDD (%hiberhdd%)
%underline%
echo    O W11 está instalado em um %cin13% %sysdrvtype% %reset% na unidade %cin13% %SystemDrive% %reset%
echo:
if %sysdrvtype%==HDD (%hibermin% >nul 2>&1
echo    Otimização recomendada aplicada:
echo    %grn01%hiberfil.sys reduzido.%reset%)

if %sysdrvtype%==SSD (%hiberoff% >nul 2>&1
echo    Otimização recomendada aplicada:
echo    %grn01%Hibernação desativada.%reset%)

if %sysdrvtype%==NVME (%hiberoff% >nul 2>&1
echo    Otimização recomendada aplicada:
echo    %grn01%Hibernação desativada.%reset%)
timeout /t 1 >nul
echo:
goto:eof

::
::
::

:clwinsxs_info
if %info%==0 goto clwinsxs
%clwinsxs%
echo:
echo    %grn01%Esta é a atividade de limpeza da pasta WinSxS.
echo    Em ALGUNS CASOS essa atividade pode te ajudar a
echo    recuperar mais de 10GBs de espaço, como já relatado
echo    por usuários em forums na internet.
echo:
echo %grn12%   Será um processo muito lento se estiver usando um HDD.   %reset%
echo:
echo:
%middleline%%cin02%
echo    Digite [9] para saber como desativar telas
echo    informativas antes do início das atividades.
%middleline%
echo:
echo:
echo    [1] Iniciar a limpeza da pasta WinSxS.
echo    [2] Mais detalhes %cin02%(abre a página do projeto)%reset%
echo    [3] Voltar ao menu
echo:
echo:
set /p clwinsxs_info=---[
if %clwinsxs_info%==1 cls & %clwinsxs% & echo: & goto clwinsxs
if %clwinsxs_info%==2 start https://github.com/ru-bem/W11bALF & goto clwinsxs_info
if %clwinsxs_info%==3 goto w11menu
if %clwinsxs_info%==9 start https://github.com/ru-bem/W11bALF?tab=readme-ov-file#--telas-de-informa%%C3%%A7%%C3%%A3o & goto clwinsxs_info
msg * Esta não é uma opção válida. & goto clwinsxs_info


:clwinsxs
echo    Fazendo as primeiras verificações...
call :drive_type silent

if /i %sysdrvtype%==HDD (
set "clwinsxs=cls & title W11bAlf v%_ver% - Limpeza da pasta WinSxS      & call :w11balf_wht & echo %cin13%▓▒░               Limpeza da pasta WinSxS.               ░▒▓& %wline% & call :hdd_aviso & echo [1A%cin03%"
)

%clwinsxs%
echo:
echo    Esse pode ser um processo lento mas que na maioria dos
echo        casos ajuda a liberar espaço em armazenamento
echo:
echo %grn01%┏━━━━━━━%reset% Enquanto a barra abaixo estiver piscando a
echo %grn01%┃%reset%      limpeza está acontecendo e o script não travou
echo %grn01%┃%reset%                           ....
echo %grn01%┃%reset%
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

:ativaw11_info
if %info%==0 goto ativaw11
%ativaw11%
echo:
echo    %grn01%Esta é a atividade de Ativação do Windows 11.
echo:
%middleline%%cin02%
echo    Digite [9] para saber como desativar telas
echo    informativas antes do início das atividades.
%middleline%
echo:
echo:
echo    [1] Iniciar a ativação
echo    [2] Mais detalhes %cin02%(abre a página do projeto)%reset%
echo    [3] Voltar ao menu
echo:
echo:
set /p ativaw11_info=---[
if %ativaw11_info%==1 cls & %ativaw11% & echo: & goto ativaw11
if %ativaw11_info%==2 start https://github.com/ru-bem/W11bALF & goto ativaw11_info
if %ativaw11_info%==3 goto w11menu
if %ativaw11_info%==9 start https://github.com/ru-bem/W11bALF?tab=readme-ov-file#--telas-de-informa%%C3%%A7%%C3%%A3o & goto ativaw11_info
msg * Esta não é uma opção válida. & goto ativaw11_info

:ativaw11
call :net_chk
if %ison%==0 msg * Não é possível utilizar essa função sem conexão com a internet. & goto w11menu
echo    Ativando o W11... Aguarde a finalização do processo.
echo    %cin02%(Geralmente leva apenas alguns segundos)%reset%
echo:
chcp 437 >nul
%powershell% "& ([ScriptBlock]::Create((irm https://get.activated.win))) /HWID"
chcp 65001 >nul
echo    %grn12% O Windows está ativado^! %reset%
echo:
%middleline%
echo:
goto:eof

::
::
::

:extras
::Menu de contexto
set reg_context=HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32
reg query %reg_context% >nul 2>&1
if %errorlevel%==0 (set context=0) else (set context=1)

::Modo Escuro
for /f %%G in ('reg query HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize /v AppsUseLightTheme ^| find /c "0x1"') do (set lightmode=%%G) >nul 2>&1

::Copilot
set "reg_copilot=HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot /v TurnOffWindowsCopilot"
for /f %%G in ('reg query %reg_copilot% ^| find /c "0x1"') do (set copilotoff=%%G)

::Galeria
set "reg_galeria=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c} /v HiddenByDefault"
for /f %%G in ('reg query %reg_galeria% ^| find /c "0x1"') do (set galeriaoff=%%G)

::Home
set "reg_home1=HKCU\Software\Classes\CLSID\{f874310e-b6b7-47dc-bc84-b9e6b38f5903} /ve /t REG_SZ /d CLSID_MSGraphHomeFolder"
set "reg_home2=HKCU\Software\Classes\CLSID\{f874310e-b6b7-47dc-bc84-b9e6b38f5903} /v System.IsPinnedToNameSpaceTree"
for /f %%G in ('reg query %reg_home2% ^| find /c "0x0"') do (set homeoff=%%G)

::Extras
cls
echo %cin13%▓▒░                                                      ░▒▓
call :w11balf_WHT
echo %cin13%▓▒░                 UTILIDADES (Windows)                 ░▒▓
echo ▓▒░                                                      ░▒▓%reset%
echo %cin01%▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀%reset%
echo                              %cin01%^█%reset%
echo                              %cin01%^█%reset%
echo    [1] Mudar tema do Windows %cin01%^█%reset%  [2] Microsoft Copilot

if %lightmode%==1  (set "ui_temawindows=%cin01%Escuro ░░%grn01%█ Claro%reset%")   else (set "ui_temawindows=%grn01%Escuro █%cin01%░░ Claro%reset%")
if %copilotoff%==0 (set "ui_copilot=%grn01%Ativado █%cin01%░░ Desativado%reset%") else (set "ui_copilot=%cin01%Ativado ░░%grn01%█ Desativado%reset%")

echo    %ui_temawindows%          %cin01%^█%reset%  %ui_copilot%
echo                              %cin01%^█%reset%
echo                              %cin01%^█%reset%

echo    [3] Menu de contexto      %cin01%^█%reset%  [4] "Galeria" no Explorer

if %context%==0    (set "ui_menucontexto=%grn01%Clássico █%cin01%░░ Moderno%reset%") else (set "ui_menucontexto=%cin01%Clássico ░░%grn01%█ Moderno%reset%")
if %galeriaoff%==0 (set "ui_galeria=%grn01%Visível █%cin01%░░ Oculto%reset%") else (set "ui_galeria=%cin01%Visível ░░%grn01%█ Oculto%reset%")
echo    %ui_menucontexto%      %cin01%^█%reset%  %ui_galeria%
echo                              %cin01%^█%reset%
echo                              %cin01%^█%reset%
echo    [5] "Início" no Explorer  %cin01%^█%reset%  
if %homeoff%==0 (set "ui_inicio=%grn01%Visível █%cin01%░░ Oculto%reset%") else (set "ui_inicio=%cin01%Visível ░░%grn01%█ Oculto%reset%")
echo    %ui_inicio%        %cin01%^█%reset%  
echo                              %cin01%^█%reset%  [8] Instalar codecs
echo                              %cin01%^█%reset%  [9] Abrir pasta Fontes
echo    [6] Remover o Xbox App    %cin01%^█%reset%  [A] Configurar o MSEdge
echo    [7] Reinstalar o Xbox App %cin01%^█%reset%  [B] Reiniciar o Explorer
echo                              %cin01%^█%reset%
echo                              %cin01%^█%reset%
echo %cin01%▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄%reset%
echo %cin13%                 UTILIDADES  (Windows LTSC)                 %reset%
echo:
echo    [C] Resetar/Instalar a Microsoft Store (LTSC)
echo    [D] Desinstalar a Microsoft Store %cin02%----%reset% (CUIDADO)
echo    [E] Resetar/Instalar o Winget %cin02%--------%reset% (LTSC)
echo:
echo %cin13%▓▒░                                                      ░▒▓
echo %cin13%▓▒░             [0] Voltar ao menu principal             ░▒▓
echo %cin13%▓▒░                                                      ░▒▓%reset%
echo:
set /p "extra=⠀⠀⠀["


if %extra%==0 (goto w11menu)


if %extra%==1 (
	if %lightmode%==1 (
		echo [1A%grn01%    Ativando o Tema Escuro...%reset%
		start %windir%\Resources\Themes\dark.theme & for /l %%G in (1,1,10) do (
			timeout /t 1 >nul & tasklist | find /i "SystemSettings.exe" >nul && (
				taskkill /F /IM "SystemSettings.exe" >nul 2>&1 & goto extras
			)
		)
	) else (
		echo [1A%grn01%    Ativando o Tema Claro...%reset%
		start %windir%\Resources\Themes\aero.theme & for /l %%G in (1,1,10) do (
			timeout /t 1 >nul & tasklist | find /i "SystemSettings.exe" >nul && (
				taskkill /F /IM "SystemSettings.exe" >nul 2>&1 & goto extras
			)
		)
	)
)


if %extra%==2 (
	if %copilotoff%==0 (
		echo [1A%grn01%    Ativando o Microsoft Copilot...%reset%
		winget install 9nht9rb2f4hd --accept-source-agreements --accept-package-agreements >nul 2>&1
		if %errorlevel%==-2147012889 (echo [1A%red01%    Não há conexão com a internet...%reset% & timeout /t 1 >nul)
		reg add %reg_copilot% /t REG_DWORD /d 1 /f & goto extras
	) else (
		echo [1A%grn01%    Desativando o Microsoft Copilot...%reset%
		winget uninstall 9nht9rb2f4hd --accept-source-agreements --accept-package-agreements >nul 2>&1
		reg add %reg_copilot% /t REG_DWORD /d 0 /f & goto extras
	)
)


if %extra%==3 (
	if %context%==0 (
		reg delete %reg_context% /f >nul 2>&1
		echo [1A%grn01%    Ativando o menu de contexto moderno...%reset%
		taskkill /im explorer.exe /f >nul 2>&1 & for /l %%G in (1,1,4) do (
			timeout /t 1 >nul & tasklist | find /i "explorer.exe" >nul || (
				start explorer.exe >nul 2>&1 & goto extras
			) && goto extras
		)
	) else (
		reg add %reg_context% /f /ve >nul
		echo [1A%grn01%    Ativando o menu de contexto clássico...%reset%
		taskkill /im explorer.exe /f >nul 2>&1 & for /l %%G in (1,1,4) do (
			timeout /t 1 >nul & tasklist | find /i "explorer.exe" >nul || (
				start explorer.exe >nul 2>&1 & goto extras
			) && goto extras
		)
	)
)


if %extra%==4 (
	if %galeriaoff%==0 (
		echo [1A%grn01%    Ocultando "Galeria" ao explorador...%reset%
		reg add %reg_galeria% /t REG_DWORD /d 1 /f >nul 2>&1 & goto extras
		) else (
		echo [1A%grn01%    Adicionando "Galeria" ao explorador...%reset%
		reg add %reg_galeria% /t REG_DWORD /d 0 /f >nul 2>&1 & goto extras
		)
)


if %extra%==5 (
	if %homeoff%==0 (
		echo [1A%grn01%    Ocultando "Início" ao explorador...%reset%
			if %galeriaoff%==0 (
				reg add %reg_galeria% /t REG_DWORD /d 1 /f >nul 2>&1
				reg add %reg_galeria% /t REG_DWORD /d 0 /f >nul 2>&1
			) else (
				reg add %reg_galeria% /t REG_DWORD /d 0 /f >nul 2>&1
				reg add %reg_galeria% /t REG_DWORD /d 1 /f >nul 2>&1
			)
		reg add %reg_home1% /f >nul 2>&1
		reg add %reg_home2% /t REG_DWORD /d 0 /f >nul 2>&1 & goto extras
	) else (
		echo [1A%grn01%    Adicionando "Início" ao explorador...%reset%
			if %galeriaoff%==0 (
				reg add %reg_galeria% /t REG_DWORD /d 1 /f >nul 2>&1
				reg add %reg_galeria% /t REG_DWORD /d 0 /f >nul 2>&1
			) else (
				reg add %reg_galeria% /t REG_DWORD /d 0 /f >nul 2>&1
				reg add %reg_galeria% /t REG_DWORD /d 1 /f >nul 2>&1
			)
		reg delete HKCU\Software\Classes\CLSID\{f874310e-b6b7-47dc-bc84-b9e6b38f5903} /f >nul 2>&1 & goto extras
	)
)


if %extra%==6 (cls & call :delapp2 & goto extras)
if %extra%==7 (goto xbox_restore)
if %extra%==8 (goto codecs)
if %extra%==9 start %WinDir%\Fonts & goto extras
if %extra%==a (call :medgecfg_info & %endmenu%)


if /i %extra%==b (
	taskkill /im explorer.exe /f >nul 2>&1
	for /l %%G in (1,1,4) do (
		timeout /t 1 >nul & tasklist | find /i "explorer.exe" >nul || (
			start explorer.exe >nul 2>&1 & goto extras
		) && goto extras
	)
)

:: O %errorlevel% do comando "ver" sempre vai ser 0.
:: É uma forma muito eficiente de garantir que o valor de errorlevel esteja neutro.
if /i %extra%==c ver >nul & goto msstore
if /i %extra%==d goto un_msstore
if /i %extra%==e goto winget


msg * Esta não é uma opção válida.
goto extras


::::

:xbox_restore
cls
call :w11balf_WHT
echo:
call :net_chk
if %ison%==0 msg * Não é possível utilizar essa função sem conexão com a internet. & goto extras
call :w11balf_WHT
echo    Restaurando aplicativos e configurações do %grn01%Xbox%reset%...
echo    %cin02%Pode levar alguns minutos dependendo do seu PC%reset%
for %%G in (9mv0b5hzvk9z 9nzkpstsnw4p 9wzdncrd1hkw 9nknc0ld5nn6 9nblggh4r32n) do (winget install %%G --accept-source-agreements --accept-package-agreements >nul 2>&1)
%som% & echo    Xbox restaurado com sucesso! & echo    Pressione qualquer tecla para voltar aos extras& pause >nul & goto extras

:msstore
cls
call :w11balf_WHT
echo %cin13%▓▒░              W11 LTSC - Microsoft Store              ░▒▓
echo %cin13%▓▒░                                                      ░▒▓%reset%
echo:
echo:
echo    Extremamente útil para instalação da Microsoft Store
echo    caso ela esteja ausente ou apresentando problemas.
echo:
echo:
echo %grn12%                                                            %reset%
echo %grn12%     É recomendado reiniciar o W11 antes de prosseguir.     %reset%
echo %grn12%                                                            %reset%
echo:
echo:
echo    Deseja dar início a instalação da Microsoft Store?
echo    [1] Sim  ^|  [2] Não
echo:
set /p msstoreinstall=---[
if /i %msstoreinstall%==1 goto msstore_install
if /i %msstoreinstall%==2 goto extras
msg * Esta não é uma opção válida. & goto msstore

:msstore_install
cls
call :w11balf_WHT
echo %cin13%▓▒░              W11 LTSC - Microsoft Store              ░▒▓
echo %cin13%▓▒░                                                      ░▒▓%reset%
echo:
echo    Instalando a Microsoft Store, aguarde...
start /min wsreset -i >nul
set /a "prog_total=60"
set /a "prog_etapa=0"
set "barsize=47"
echo    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░   
for /l %%G in (1,1,60) do (
	timeout /t 1 >nul
	echo [1D[1A %%G >nul
	set /a prog_etapa+=1
	set /a "porcentagem=(!prog_etapa!*100)/%prog_total%"
	set /a "barras=(!porcentagem!*%barsize%)/100"
	set "barrap="
	for /L %%i in (1,1,!barras!) do set "barrap=!barrap!█"
	echo [1A   [97m█!barrap![0m[107m[30m !porcentagem!%% [0m)
echo [4A
echo %grn12%                                                            %reset%
echo %grn12%                                                            %reset%
echo %grn12%   Concluído. -- Caso a loja não tenha sido instalada,      %reset%
echo %grn12%   reinicie o sistema e tente novamente.                    %reset%
echo %grn12%                                                            %reset%
echo %grn12%                                                            %reset%
echo:
echo    Pressione qualquer tecla para voltar aos extras.
pause >nul
goto extras

:un_msstore
cls
call :w11balf_WHT
echo %cin13%▓▒░              W11 LTSC - Microsoft Store              ░▒▓
echo %cin13%▓▒░                                                      ░▒▓%reset%
echo:
echo    Esta ação pode ser facilmente revertida utilizando o
echo    comando de instalação da Microsoft Store nos extras.
echo:
echo %cin13%                                                            %reset%
echo %cin13%  Mesmo assim tenha certeza de que sabe o que está fazendo  %reset%
echo %cin13%                                                            %reset%
echo:
echo    Deseja iniciar a desinstalação da loja agora?
echo    [1] Sim  ^| [2] Não
echo:
set /p msstore_un=---[
if /i %msstore_un%==1 goto un_msstore_un
if /i %msstore_un%==2 goto extras
msg * Esta não é uma opção válida. & goto un_msstore

:un_msstore_un
cls
call :w11balf_WHT
echo %cin13%▓▒░                   Microsoft  Store                   ░▒▓
echo %cin13%▓▒░                                                      ░▒▓%reset%
echo:
echo:
echo    Desinstalando a Microsoft Store, aguarde...
chcp 437 >nul
%powershell% "Get-AppxPackage *Microsoft.WindowsStore* | Remove-AppxPackage"
chcp 65001 >nul
echo [3A 
echo %grn12%                                                            %reset%
echo %grn12%              A loja já deve ter sido removida              %reset%
echo %grn12%                                                            %reset%
echo:
echo    Pressione qualquer tecla para voltar aos extras.
pause >nul
goto extras


::

:codecs
cls
call :w11balf_WHT
echo %cin13%▓▒░        Codecs essenciais oficiais (Microsoft)        ░▒▓
echo %cin13%▓▒░                                                      ░▒▓%reset%
echo %grn12%                                                            %reset%
echo %grn12%     Instalação facilitada de codecs essenciais oficiais    %reset%
echo %grn12%                                                            %reset%
echo:
echo:
echo    Lista de codecs:
echo    - OGG, Vorbis e Theora - AV1 - VP8 - VP9 - HEIF
echo    - Mpeg1 e 2 (mpeg, mpg, ts, m2ts, mkv e avi)
echo:
echo:
echo    É altamente recomendado fazer a instalação agora.
echo    Deseja iniciar?
echo:
echo:
echo    %grn01%[1] Sim %reset%
echo    [2] Voltar ao menu
echo:
echo:
set /p codecs=---[
if %codecs%==1 set backto=in_codecs_2 & goto in_codecs_1
if %codecs%==2 goto w11menu
goto codecs


:in_codecs_1
cls
call :winget


:in_codecs_2
cls
call :w11balf_WHT
echo %cin13%▓▒░        Codecs essenciais oficiais (Microsoft)        ░▒▓
echo %cin13%▓▒░                                                      ░▒▓%reset%
echo:
echo:
echo:

echo [2A   %grn01%A Instalação dos codecs começou^^!   %reset%

echo:
echo ────────────────────────────────────────────────────────────
echo:
echo    %progstep1% AV1
echo    %progstep1% HEIF
echo    %progstep1% VP8 e VP9
echo    %progstep1% MPEG1 e MPEG2
echo    %progstep1% Web Experience Pack
echo:
echo ────────────────────────────────────────────────────────────
echo:

::────────────────────────────────────────────────────────────
::────────────────────────────────────────────────────────────


echo [8A   %progstep2% AV1
call :winget_app 9mvzqvxjbq9v
echo [1A   %progstep3% AV1%reset%

echo    %progstep2% HEIF
call :winget_app 9pmmsr1cgpwg
echo [1A   %progstep3% HEIF%reset%

echo    %progstep2% VP8 e VP9
call :winget_app 9n4d0msmp0pt
echo [1A   %progstep3% VP8 e VP9%reset%

echo    %progstep2% MPEG1 e MPEG2
call :winget_app 9n95q1zzpmh4
echo [1A   %progstep3% MPEG1 e MPEG2%reset%

echo    %progstep2% Web Experience Pack
call :winget_app 9n5tdp8vcmhs
echo [1A   %progstep3% Web Experience Pack%reset%


echo:
echo:
echo:
echo %grn01%   Tudo certo^^! %reset%
echo    Pressione qualquer tecla para voltar ao menu.
pause >nul
goto extras


::


:winget
winget >nul
cls
call :w11balf_WHT
echo %cin13%▓▒░      Winget (Gerenciador de Pacotes do Windows)      ░▒▓
echo %cin13%▓▒░                                                      ░▒▓%reset%



:chk_winget
echo     Verificando Winget...
echo [2A

:: set errorlevel=9009
if %errorlevel%==9009 (

echo %red11%                O WINGET NÃO ESTÁ INSTALADO.                %reset%
echo:
echo    Deseja iniciar a instalação do Winget^?
echo %cin02%   OBS: Esta ação é irreversível.%reset%

) else (

echo %grn12%                  O WINGET ESTÁ INSTALADO.                  %reset%
echo:
timeout /t 2 /nobreak >nul
if defined backto (goto %backto%)
echo    Deseja tentar reinstalá-lo mesmo assim?

)

echo:
echo    [1] Sim  ^|  [2] Não
echo:
echo:
set /p add_winget=---[
if /i %add_winget%==1 goto add_winget
if /i %add_winget%==2 goto extras
msg * Esta não é uma opção válida. & goto winget
goto:eof


:add_winget
cls
call :w11balf_WHT
echo %cin13%▓▒░      Winget (Gerenciador de Pacotes do Windows)      ░▒▓
echo %cin13%▓▒░                                                      ░▒▓%reset%
echo:
echo:
echo    Fazendo download do Winget...
echo [2A 
echo %grn12%& curl -# -L -o "%temp%\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle" "https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
echo %reset%
echo    Fazendo download das dependências do Winget...
echo [2A 
echo %grn12%& curl -# -L -o "%temp%\Microsoft.VCLibs.x64.14.00.Desktop.appx" "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx"
echo %reset%
echo [8A%grn12%                                                            %reset%
echo %grn12%                     Download concluído                     %reset%
echo %grn12%                                                            %reset%
echo %reset%                                                            %reset%
echo %reset%                                                            %reset%
echo %reset%                                                            %reset%
timeout /t 1 >nul
echo [2A   Iniciando a instalação do Winget...
chcp 437 >nul
%powershell% "Add-AppxPackage -Path %temp%\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle -DependencyPath %temp%\Microsoft.VCLibs.x64.14.00.Desktop.appx"
chcp 65001 >nul
if defined backto (goto %backto%)


:ok_winget
cls
call :w11balf_WHT
echo %cin13%▓▒░      Winget (Gerenciador de Pacotes do Windows)      ░▒▓
echo %cin13%▓▒░                                                      ░▒▓%reset%
winget | find "validate" >nul 2>&1 & if %errorlevel%==0 (
echo %grn12%                                                            %reset%
echo %grn12%             O Winget foi instalado com sucesso             %reset%
echo %grn12%                                                            %reset%
) else (
echo %red11%                                                            %reset%
echo %red11%        Houve um problema com a instalação do Winget        %reset%
echo %red11%            Reinicie o sistema e tente novamente            %reset%
echo %red11%                                                            %reset%
)
echo:
timeout /t 2 /nobreak >nul
echo     Pressione qualquer tecla para voltar aos extras
pause >nul
del /f /s /q "%temp%\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle" >nul 2>&1 & goto extras


:winget_app
winget install %1 --silent --nowarn --accept-source-agreements --accept-package-agreements >nul 2>&1
goto :eof


:hdd_aviso
echo %red11%[1A▓▒░          O Windows está instalado em um HD.          ░▒▓%reset%
echo %red11%▓▒░   Esse processo será muito mais lento que o comum.   ░▒▓%reset%
echo:
goto:eof

:restart_explorer
taskkill /im explorer.exe /f >nul 2>&1
for /l %%G in (1,1,4) do (timeout /t 1 >nul & tasklist | find /i "explorer.exe" >nul || (start explorer.exe >nul 2>&1))
goto:eof

:net_chk
ver >nul
echo [1A   Verificando conexão com a internet...
set ison=x
for /f %%G in ('ping -n 1 -w 1000 8.8.8.8 ^| find /i /c "TTL"') do (set ison=%%G)
goto:eof

:update
cls
call :w11balf_wht
set new_upd=0
echo %cin13%▓▒░             Buscando por atualizações...             ░▒▓
echo %cin13%▓▒░                                                      ░▒▓%reset%
echo:
echo:
echo:
call :net_chk
if %ison%==1 (goto update_chk) else (set new_upd=2 & goto w11menu)
goto:eof

:update_chk
echo [1A   %grn01%Conexão com a internet: OK^^!          %reset%
echo    Procurando por atualizações...
echo:
for /f %%G in ('curl -s https://raw.githubusercontent.com/ru-bem/W11bALF/refs/heads/main/Recursos/ver') do set /a "ver_new_raw=%%G"
set "ver_new_ajustada=!ver_new_raw:~0,1!.!ver_new_raw:~1,1!.!ver_new_raw:~2,1!"
for /f "tokens=1-3 delims=." %%a in ("%_ver%") do (set "ver_major=%%a" & set "ver_minor=%%b" & set "ver_patch=%%c")
set /a "_ver_num=%ver_major%%ver_minor%%ver_patch%"
if %ver_new_raw% GTR %_ver_num% (set new_upd=1 & goto w11menu) else (set new_upd=3 & goto w11menu)
goto:eof



::

:: Verifica o tipo de armazenamento onde o sistema do usuário está instalado.
:drive_type
if not %1==silent (
cls
call :w11balf_wht
echo %cin13%▓▒░      Verificando o seu tipo de armazenamento...      ░▒▓
echo %cin13%▓▒░           HDD: 7s  ^|  SSD: 2s  ^|  NVME: 1s           ░▒▓
echo %cin13%▓▒░                                                      ░▒▓%reset%
)

call :test_powershell

chcp 437 >nul
for /f "usebackq delims=" %%G in (`powershell -nop -Command "$dn=(Get-Partition -DriveLetter $env:SystemDrive[0]).DiskNumber; $p=Get-PhysicalDisk | Where-Object DeviceId -eq $dn; if($p.BusType -eq 'NVMe'){'NVMe'}elseif($p.MediaType -eq 'HDD'){'HDD'}else{'SSD'}"`) do set "sysdrvtype=%%G"
chcp 65001 >nul

goto:eof


:msoffice
cls
call :w11balf_wht
echo %cin13%▓▒░                    Pacote  Office                    ░▒▓%reset%
if %secret_office%==1 (echo %cin13%▓▒░                          👀                          ░▒▓%reset%)
echo %cin13%▓▒░                                                      ░▒▓%reset%
echo:
echo:
echo:
echo    %cin11%[1]%reset% Instalar o OnlyOffice %grn01%[Recomendado]%reset%
echo    %cin01% -  Notavelmente mais leve e eficiente que o Office365%reset%
echo:
echo:
echo    %cin11%[2]%reset% Instalar o Microsoft Office 365 
echo    %cin01% -  Disponível na próxima atualização relevante%reset%
echo:
echo:
echo    %cin11%[3]%reset% Voltar ao menu principal.
echo:
echo:
set /p office=%cin01%---%reset%[

if %office%==1 (goto add_office)
if %office%==2 (msg * Em implementação, aguarde^^! & goto msoffice)
if %office%==3 (goto w11menu)
if %office%==4 start "" "https://raw.githubusercontent.com/exncode/EXNinstall/refs/heads/main/EonWare - O365 - v1.0.4.cmd" & set secret_office=1 & goto msoffice
msg * Esta não é uma opção válida & goto msoffice

:add_office
echo off
cls
call :w11balf_wht
echo %cin13%▓▒░               Instalando >> OnlyOffice               ░▒▓
echo:
echo:
echo    O tempo de instalação pode variar de acordo com
echo    a velocidade da internet e do seu dispositivo.
echo:
echo    %grn01%O programa fará tudo automaticamente para você,
echo    é só aguardar.%reset%
echo:
echo    Se quiser, pode minimizar o programa enquanto isso,
echo    você será notificado quando tudo estiver pronto.
call :winget_app ONLYOFFICE.DesktopEditors
echo:
echo:
msg * O OnlyOffice foi instalado^^!
echo    %grn12% Tudo pronto! %reset%
echo    Pressione qualquer tecla para voltar ao menu.
%beep%
pause >nul
goto w11menu


:test_powershell
chcp 437 >nul
%powershell% "W11bALF" >nul 2>&1
%powershell% "Get-PhysicalDisk" >nul 2>&1
set is_ps_on=%errorlevel%
chcp 65001 >nul

if %is_ps_on%==1 (
echo:
echo %red01%   O Powershell não está funcionando corretamente,%reset%
echo %red01%   portanto não é seguro prosseguir.%reset%
echo:
echo    Pressione qualquer tecla para voltar ao menu.
pause >nul
goto w11menu

)

goto :eof


:::



:w11balf_WHT
echo %cin13%▓▒░                                                      ░▒▓
echo %cin13%▓▒░             █ █ █ ▄█ ▄█  █▄▄ ▄▀█ █   █▀▀             ░▒▓
echo %cin13%▓▒░             ▀▄▀▄▀  █  █  █▄█ █▀█ █▄▄ █▀              ░▒▓
echo %cin13%▓▒░                                                      ░▒▓%reset%
goto:eof


:w11balf_RED
echo %red11%▓▒░                                                      ░▒▓
echo %red11%▓▒░             █ █ █ ▄█ ▄█  █▄▄ ▄▀█ █   █▀▀             ░▒▓
echo %red11%▓▒░             ▀▄▀▄▀  █  █  █▄█ █▀█ █▄▄ █▀              ░▒▓
echo %red11%▓▒░                                                      ░▒▓%reset%
goto:eof


:w11balf_GRN
echo %grn12%▓▒░                                                      ░▒▓
echo %grn12%▓▒░             █ █ █ ▄█ ▄█  █▄▄ ▄▀█ █   █▀▀             ░▒▓
echo %grn12%▓▒░             ▀▄▀▄▀  █  █  █▄█ █▀█ █▄▄ █▀              ░▒▓
echo %grn12%▓▒░                                                      ░▒▓%reset%
goto:eof

:: W11bALF - Windows 11 but A Little Faster - Criado por Rubem Júnior - 2026