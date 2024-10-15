# W11bALF
O **Windows 11 but A Little Faster** é um pequeno programa escrito em [**Batch**](https://en.wikipedia.org/wiki/Batch_file) que foi criado com o objetivo de facilitar o processo de configuração pós-instalação do Windows 11, mas também pode ser usado para fazer limpezas periódicas no sistema e realizar alguns ajustes afim de fazer com que o sistema permaneça o mais otimizado possível.

---
###### < Imagem do MENU PRINCIPAL <⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀||||⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀> Imagem das OPÇÕES EXTRAS >
![w11balf_menu+extras](https://github.com/user-attachments/assets/768366ef-ac58-4c66-b26e-d80aaa19afa0)



---

# ❔ O que o W11bALF pode fazer?
**Atualmente, o programa se encontra na versão [v1.2.0](https://github.com/rubem-psd/W11bALF/releases/latest) e é capaz de automatizar os seguintes processos:**

- **[Serviços]** Alterar o modo de inicialização de alguns serviços do windows.
- **[Telemetria]** Reduzir a coleta de dados de uso pela Microsoft.
- **[Bloatwares]** Desinstalar dezenas de aplicativos instalados pela Microsoft sem o seu pedido.
- **[Limpeza]** Fazer uma limpeza completa em toda partição onde o sistema está instalado.
- **[WinSxS]** Limpar a pasta WinSxS, o que pode ajudar a liberar bastante espaço em disco.
- **[Menu e Taskbar]** Desfixar todos os ícones do menu iniciar e da barra de tarefas.
- **[Microsoft Edge]** Configurar o Edge com presets diversos (Experimental).
- **[Hibernação]** Ajustar a hibernação para HDDs, SSDs e NVMEs.
- **[Ativação]** Ativar o Windows 11.
- **[LTSC]** Instalar a Microsoft Store nas versões LTSC do W11.
- **[LTSC]** Instalar o Winget nas versões LTSC do W11.

---

**[⬇️ Clique aqui para fazer o download da versão mais recente do script ⬇️](https://github.com/rubem-psd/W11bALF/releases/latest)**

---

# ▶️ Roadmap

Futuro: v2.0
- 🔳 Revisar e reescrever todo o código afim de deixá-lo o menor e mais otimizado possível.
- 🔳 Grandes mudanças na interface.
- 🔳 Atualização e adição de várias funções.
- 🔳 Instalação silenciosa do Office365.
- 🔳 Criar uma versão totalmente em inglês.
- 🔳 Facilitar ao máximo a adição de novos recursos.
- 🔳 Mais... (?)

---

# 🔎 Configurações
As configurações do programa estão armazenadas entre as linhas 7 e 69 do código, e podem ser personalizadas de acordo com o seu uso.

### - bALFmode (Modo automático)
O **Modo bALF** é o modo automático do script. Ele pode ser ativado editando a **linha 19** do código, alterando o valor de `balfmode` entre 0, 1 e 2.
- `balfmode=0` - Valor padrão. O programa iniciará normalmente.
- `balfmode=1` - O programa executará automaticamente as **atividades recomendadas**:
Serviços e telemetria | Desinstalação de bloatware | Configuração do Windows | Limpeza do sistema | Configuração de hibernação
- `balfmode=2` - O programa executará **TODAS as atividades** automaticamente.

### - bALFtime
Antes de iniciar a execução o programa aguardará, por padrão, 5 segundos onde exibirá para você um resumo das atividades que serão realizadas. Para alterar o tempo de espera altere o valor de `balftime` na linha 25 do código.
Funcionará **apenas** em conjunto com o modo bALF.

### - Silent (Modo silencioso)
Pode ser ativado ou desativado alterando o valor de `silent` na linha 32 do código.
- `silent=0` - Valor padrão. Executará as tarefas normalmente.
- `silent=1` - Executará todos os processos automáticos exibindo apenas o nome da tarefa que está sendo realizada no momento, sem nenhum detalhe adicional.
Funcionará apenas em conjunto com o modo bALF.

### - DeepClean
A limpeza profunda pode ser ativada alterando o valor de `deepclean` na linha 38 do código.
- `deepclean=0` - Valor padrão. A função de limpeza do sistema procurará por arquivos de determinadas extensões apenas na pasta C:\Windows.
- `deepclean=1` - A função de limpeza do sistema procurará por arquivos de determinadas extensões em **toda a unidade** onde o Windows está instalado. (Pode levar vários minutos dependendo do seu computador)

### - Configuração do Microsoft Edge (EXPERIMENTAL)
A escolha dos presets de configuração do Microsft Edge pode ser feita alterando o valor de `medgetipo` na linha 46 do código.
- `medgetipo=1` - Valor padrão. Aplicará o preset básico no Microsoft Edge.
- `medgetipo=2` - Aplicará o preset seguro no Microsoft Edge.
- `medgetipo=3` - Aplicará o preset hardened no Microsoft Edge.

_Por enquanto, é recomendado usar essa atividade apenas em novas instalações do Windows ou em máquinas virtuais para teste._

### - Telas de informação
A exibição ou não das telas de informação pode ser definida alterando o valor de `info` na linha 53 do código.
- `info=1` - Valor padrão. Exibe informações sobre cada uma das atividades antes de executá-las.
- `info=2` - Inicia diretamente as atividades ao serem escolhidas.

### - Desinstalação de Bloatware
Ao fim do processo de desinstalação padrão de bloatware duas desinstalações opcionais serão iniciadas. Você pode escolher se deseja remover esses aplicativos ou não. (A partir da linha 62).
- 0 = Não desinstalar
- 1 = Desinstalar
- `delapp1=1` - Desinstalar o OneDrive
- `delapp2=1` - Desinstalar o Xbox

---

# ℹ️ Mais informações
- [Lista de serviços alterados](https://github.com/rubem-psd/W11bALF/blob/main/Recursos/Mais_Informa%C3%A7%C3%B5es/Lista_de_servi%C3%A7os_alterados.md)
- [Lista de tarefas de telemetria alteradas](https://github.com/rubem-psd/W11bALF/blob/main/Recursos/Mais_Informa%C3%A7%C3%B5es/Lista_de_tarefas_de_telemetria_alteradas.md)
- [Lista de programas desinstalados](https://github.com/rubem-psd/W11bALF/blob/main/Recursos/Mais_Informa%C3%A7%C3%B5es/Lista_de_programas_desinstalados.md)
- [Sobre a alteração de configurações](https://github.com/rubem-psd/W11bALF/blob/main/Recursos/Mais_Informa%C3%A7%C3%B5es/Sobre_a_altera%C3%A7%C3%A3o_de_configura%C3%A7%C3%B5es.md)
- [Lista de limpeza](https://github.com/rubem-psd/W11bALF/blob/main/Recursos/Mais_Informa%C3%A7%C3%B5es/Lista_de_limpeza.md)
- [Presets do Microsoft Edge](https://github.com/rubem-psd/W11bALF/blob/main/Recursos/Mais_Informa%C3%A7%C3%B5es/Presets_de_configura%C3%A7%C3%A3o_do_Edge.md)
- [Configurações de hibernação](https://github.com/rubem-psd/W11bALF/blob/main/Recursos/Mais_Informa%C3%A7%C3%B5es/Configura%C3%A7%C3%A3o_de_hiberna%C3%A7%C3%A3o.md)
- [Limpeza da pasta WinSxS](https://github.com/rubem-psd/W11bALF/blob/main/Recursos/Mais_Informa%C3%A7%C3%B5es/Limpeza_da_pasta_WinSxS.md)
- [Ativação do Windows 11](https://github.com/rubem-psd/W11bALF/blob/main/Recursos/Mais_Informa%C3%A7%C3%B5es/Ativa%C3%A7%C3%A3o_do_W11.md)

---

# ⭕ Observações

• Tudo é feito de maneira não-destrutiva, ou seja, nenhuma das funções faz nada de maneira que possa causar danos ao sistema como alguns outros scripts.

• Cada uma das funções foi exaustivamente testada em todas as suas combinações possíveis para garantir que tudo funcione perfeitamente.

• Todas as alterações feitas foram pensadas para o público geral e não para um nicho específico de usuários, por tanto, NENHUM recurso do windows deixará de funcionar após o uso do programa, além disso, não espere por modificações agressivas no sistema.

• Alguns recursos são recomendados apenas para novas instalações do Windows ou para ocasiões específicas, são eles a configuração do Microsoft Edge e a desfixação dos ícones do menu iniciar e da barra de tarefas.
- Motivo 1 - Se você já usa o Edge há algum tempo e já tiver personalizado e alterado várias configurações, é possível que essa função configure o navegador de forma diferente da que você já costuma usar.
- Motivo 2 - Se o Windows 11 já estiver instalado há algum tempo, você provavelmente já personalizou o menu iniciar e a barra de tarefas. Usar essa função vai desfixar todos os ícones tanto do menu iniciar quanto da barra de tarefas, o que apenas atrapalhará você nesse caso.

---

**[⬇️ Clique aqui para fazer o download da versão mais recente do script ⬇️](https://github.com/rubem-psd/W11bALF/releases/latest)**

---
Se puder, contribua com o projeto: [livepix.gg/rubem](https://livepix.gg/rubem)

Para relatar bugs, enviar sugestões ou fazer perguntas use a aba [issues](https://github.com/rubem-psd/W11bALF/issues) na página principal. Por favor, use a label correspondente ao tipo de mensagem.

Você também pode falar diretamente comigo atráves do [Discord](https://discord.com/users/196300526139342848).

---
##### W11bALF - Windows 11 but A Little Faster - v1.2.0⠀⠀⠀|||⠀⠀⠀Criado com ❤️ por Rubem⠀⠀⠀|||⠀⠀⠀Obrigado pelo apoio!
