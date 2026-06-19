<h3 align="center"><a href="https://github.com/ru-bem/W11bALF"><img src="https://raw.githubusercontent.com/ru-bem/W11bALF/refs/heads/main/Recursos/w11balf.png" width="340px"></a></h3>
<p align="center">
  <a href="https://github.com/ru-bem/W11bALF/releases/latest"><img src="https://img.shields.io/github/v/release/ru-bem/W11bALF?style=flat-square&colorB=008000&label=Vers%C3%A3o%20mais%20recente"></a>
  <a href="https://github.com/ru-bem/W11bALF/releases"><img src="https://img.shields.io/github/downloads/ru-bem/W11bALF/total?style=flat-square&colorB=008000&label=Downloads"></a>
  <a href="https://github.com/ru-bem/W11bALF"><img src="https://img.shields.io/github/stars/ru-bem/W11bALF?style=flat-square&color=008000"></a>
</p>

---

O **Windows 11 but A Little Faster** é um pequeno programa escrito em batch criado com o objetivo de facilitar o processo de configuração pós-instalação do Windows 11 e várias outras funções auxiliares de maneira automatizada.

<p align="center">
  <a href="https://github.com/ru-bem/W11bALF/releases/latest/download/W11bALF.cmd"><img src="https://img.shields.io/badge/Clique%20aqui%20para%20baixar%20a%20vers%C3%A3o%20mais%20recente-008000?style=for-the-badge"></a>
</p>
  
---

<p align="center">
  <img height="500" alt="menu_1 6 2" src="https://github.com/user-attachments/assets/c94b4682-8f25-4ea4-8cdc-60a478aecff1" /> <img height="500" alt="extras_1 6 2" src="https://github.com/user-attachments/assets/701b318c-e602-4a3d-a5e2-ab48b8a7503a" />
</p>

---

# ❔ O que o W11bALF pode fazer?
**Atualmente, o W11bALF é capaz de automatizar os seguintes processos:**  
<br>

• **[Serviços]** - Alterar o modo de inicialização de alguns serviços do windows.  
• **[Telemetria]** - Reduzir a coleta de dados de uso pela Microsoft.  
• **[Bloatwares]** - Desinstalar dezenas de aplicativos pré-instalados.  
• **[Limpeza]** - Fazer uma limpeza completa em toda partição onde o sistema está instalado.  
• **[WinSxS]** - Limpar a pasta WinSxS, o que pode ajudar a liberar bastante espaço em disco.  
• **[Menu e Taskbar]** - Desfixar todos os ícones do menu iniciar e da barra de tarefas.  
• **[Hibernação]** - Ajustar a hibernação para HDDs, SSDs e NVMEs.  
• **[Ativação]** - Ativar o Windows 11.  
• **[Office]** - Instalar automaticamente o [Office365](https://www.office.com/) e/ou o [OnlyOffice](https://www.onlyoffice.com/) sem interação do usuário.  
• **[LTSC]** - Instalar a Microsoft Store nas versões LTSC do W11.  
• **[LTSC]** - Instalar o Winget nas versões LTSC do W11.  
• **[LTSC]** - Instalar os Widgets versões LTSC do W11.  
<br>

E mais! (Extras):  

• Instalar codecs oficiais da Microsoft.  
• Desativar ou ativar o Microsoft Copilot.  
• Alternar facilmente entre o Menu de Contexto Clássico e o Moderno.  
• Ocultar ou exibir o "Início" e a "Galeria" do explorador de arquivos.  
• Remover o Xbox App (Incluindo o popup persistente toda vez que um jogo é aberto)  

---

# 🔎 Configurações
As configurações do programa estão armazenadas entre as linhas 7 e 67 do código, e podem ser personalizadas de acordo com o seu uso.

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

### - Limpeza+
A limpeza plus pode ser ativada alterando o valor de `limpeza_plus` na linha 38 do código.
- `limpeza_plus=0` - Valor padrão.
- `limpeza_plus=1` - Serão adicionados alguns arquivos e pastas extras para a limpeza.

### - Telas de informação
A exibição ou não das telas de informação pode ser definida alterando o valor de `info` na linha 54 do código.
- `info=1` - Valor padrão. Exibe informações sobre cada uma das atividades antes de executá-las.
- `info=2` - Inicia diretamente as atividades ao serem escolhidas.

### - Desinstalação de Bloatware
Ao fim do processo de desinstalação padrão de bloatware duas desinstalações opcionais serão iniciadas. Você pode escolher se deseja remover esses aplicativos ou não. (A partir da linha 63).
- 0 = Não desinstalar
- 1 = Desinstalar
- `delapp1=1` - Desinstalar o OneDrive
- `delapp2=1` - Desinstalar o Xbox

---

# ℹ️ Mais informações
- [Lista de serviços alterados](https://github.com/ru-bem/W11bALF/blob/main/Recursos/Mais_Informa%C3%A7%C3%B5es/Lista_de_servi%C3%A7os_alterados.md)
- [Lista de tarefas de telemetria alteradas](https://github.com/ru-bem/W11bALF/blob/main/Recursos/Mais_Informa%C3%A7%C3%B5es/Lista_de_tarefas_de_telemetria_alteradas.md)
- [Lista de programas desinstalados](https://github.com/ru-bem/W11bALF/blob/main/Recursos/Mais_Informa%C3%A7%C3%B5es/Lista_de_programas_desinstalados.md)
- [Sobre a alteração de configurações](https://github.com/ru-bem/W11bALF/blob/main/Recursos/Mais_Informa%C3%A7%C3%B5es/Sobre_a_altera%C3%A7%C3%A3o_de_configura%C3%A7%C3%B5es.md)
- [Lista de limpeza](https://github.com/ru-bem/W11bALF/blob/main/Recursos/Mais_Informa%C3%A7%C3%B5es/Lista_de_limpeza.md)
- [Configurações de hibernação](https://github.com/ru-bem/W11bALF/blob/main/Recursos/Mais_Informa%C3%A7%C3%B5es/Configura%C3%A7%C3%A3o_de_hiberna%C3%A7%C3%A3o.md)
- [Limpeza da pasta WinSxS](https://github.com/ru-bem/W11bALF/blob/main/Recursos/Mais_Informa%C3%A7%C3%B5es/Limpeza_da_pasta_WinSxS.md)
- [Ativação do Windows 11](https://github.com/ru-bem/W11bALF/blob/main/Recursos/Mais_Informa%C3%A7%C3%B5es/Ativa%C3%A7%C3%A3o_do_W11.md)

---

# ⭕ Observações

• Tudo é feito de maneira não-destrutiva, ou seja, nenhuma das funções faz nada de maneira que possa causar danos ao sistema como alguns outros scripts.

• Cada uma das funções foi exaustivamente testada em todas as suas combinações possíveis para garantir que tudo funcione perfeitamente.

• Todas as alterações feitas foram pensadas para o público geral e não para um nicho específico de usuários, por tanto, NENHUM recurso do windows deixará de funcionar após o uso do programa, além disso, não espere por modificações agressivas no sistema.

• Alguns recursos são recomendados apenas para novas instalações do Windows ou para ocasiões específicas, são eles a configuração do Microsoft Edge e a desfixação dos ícones do menu iniciar e da barra de tarefas.
- Motivo 1 - Se você já usa o Edge há algum tempo e já tiver personalizado e alterado várias configurações, é possível que essa função configure o navegador de forma diferente da que você já costuma usar.
- Motivo 2 - Se o Windows 11 já estiver instalado há algum tempo, você provavelmente já personalizou o menu iniciar e a barra de tarefas. Usar essa função vai desfixar todos os ícones tanto do menu iniciar quanto da barra de tarefas, o que apenas atrapalhará você nesse caso.

---

# ⏳ Futuro

- O W11bALF está sendo reescrito para a versão v2.0 nesse momento.
  - Parte das atividades acontecem até 2x mais rápido por enquanto.
  - A interface foi totalmente reestruturada
- Cada função do W11bALF poderá ser usada separadamente com os arquivos de execução isolada.
- A configuração automática do Microsoft Edge será melhorada.

---

<p align="center">
  <a href="https://github.com/ru-bem/W11bALF/releases/latest/download/W11bALF.cmd"><img src="https://img.shields.io/badge/Clique%20aqui%20para%20baixar%20a%20vers%C3%A3o%20mais%20recente-008000?style=for-the-badge"></a>
</p>

---
Se puder, contribua com o projeto: [livepix.gg/rubem](https://livepix.gg/rubem)

Para relatar bugs, enviar sugestões ou fazer perguntas use a aba [issues](https://github.com/ru-bem/W11bALF/issues) na página principal. Por favor, use a label correspondente ao tipo de mensagem.

Você também pode falar diretamente comigo atráves do [Discord](https://discord.com/users/196300526139342848) - eon.inf

---
###### W11bALF - Windows 11 but A Little Faster - Criado por Rubem - Obrigado pelo apoio!
