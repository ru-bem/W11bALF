# Lista de limpeza

### Cache do Microsoft Edge
Pasta alvo: %localappdata%\Microsoft\Edge\User Data\
- Todos os arquivos .log .pma e .dmp
- Todos os arquivos iniciados com “data_” “f_”
- Todos os arquivos que que terminam com “index”

### Cache da Ferramenta de Captura
- Todos os arquivos da pasta %localappdata%\Packages\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\TempState\ScreenClip\ (se existir)

### Cache de alguns outros programas
- Capcut, OneDrive, Spotify e Adobe.
(Somente cache, nenhum arquivo baixado importante.)

### Pastas de Drivers não usados
C:\AMD
C:\NVIDIA
C:\INTEL

### Limpeza padrão
- Cache de thumbnails
- Lixeira
- Temp Local *%temp%*
- Temp Windows *%windir%\temp*
- Log de atividade do Windows Defender (apenas os relatórios, não o histórico)

### Arquivos .tmp .log .chk .old .bak .dmp
Busca por arquivos com essas extensões na pasta C:\Windows e os deleta.

Obs 1: Se o modo *deepclean* estiver ativado essa busca será feita em **toda a unidade** onde o sistema está instalado, então peço para que tenha cuidado caso tenha apenas uma partição.
Se não souber o que está fazendo, apenas use o programa normalmente e não altere nada no código.

Obs 2: Alguns scripts sugerem deletar arquivos .ETL do sistema, mas em meus testes fazer isso mais atrapalha do que ajuda. Optei por seguir o caminho mais seguro nesse processo.

---

[Voltar para a página principal](https://github.com/rubem-psd/W11bALF)
