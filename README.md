# ⚙️ W11bALF
O **Windows 11 but A Little Faster** é um pequeno programa escrito em [**Batch**](https://en.wikipedia.org/wiki/Batch_file) que foi criado com o objetivo de facilitar o processo de configuração pós-instalação do Windows 11, mas também pode ser usado para fazer limpezas periódicas no sistema e realizar alguns ajustes afim de fazer com que o sistema permaneça o mais otimizado possível.

![W11bALF_v1 0 0_main](https://github.com/rubem-psd/W11bALF/assets/60861729/7fa114f2-9f72-4392-a82a-8294a525e9fd)

---

# ❔ O que o W11bALF pode fazer?
**Atualmente, o programa se encontra na versão [v1.0.0](https://github.com/rubem-psd/W11bALF/releases/latest) e é capaz de automatizar os seguintes processos:**

- **[Serviços]** Alterar o modo de inicialização de alguns serviços do windows.
- **[Telemetria]** Reduzir a coleta de dados de uso pela Microsoft.
- **[Bloatwares]** Desinstalar dezenas de aplicativos instalados pela Microsoft sem o seu pedido.
- **[Limpeza]** Fazer uma limpeza completa em toda partição onde o sistema está instalado.
- **[WinSxS]** Limpar a pasta WinSxS, o que pode ajudar a liberar bastante espaço em disco.
- **[Menu e Taskbar]** Desfixar todos os ícones do menu iniciar e da barra de tarefas.
- **[Microsoft Edge]** Configurar o Edge para maior privacidade.
- **[Hibernação]** Ajustar a hibernação para HDDs, SSDs e NVMEs.
- **[Ativação]** Ativar o Windows 11.

---

**[🟩 Clique aqui para fazer o download da versão mais recente do script 🟩](https://github.com/rubem-psd/W11bALF/releases/latest)**

---

# 🔎 Switches internos
### - bALFmode (Modo automático)

O **Modo bALF** é o modo automático de do script. Ele pode ser ativado editando a **linha 10** do código, alterando o valor de `balfmode` para 1 ou 2.
- `balfmode=0` - Valor padrão. O programa iniciará normalmente.
- `balfmode=1` - O programa executará automaticamente as **atividades recomendadas**:
Serviços e telemetria | Desinstalação de bloatware | Configuração do Windows | Limpeza do sistema | Configuração de hibernação
- `balfmode=2` - O programa executará **TODAS as atividades** automaticamente.

### - bALFtime
Antes de iniciar a execução o programa aguardará, por padrão, 5 segundos. Para alterar o tempo de espera altere o valor de `balftime` na linha 13 do código.
Funcionará **apenas** em conjunto com o modo bALF.

### - Silent (Modo silencioso)
Pode ser ativado ou desativado alterando o valor de `silent` na linha 18 do código.
- `silent=0` - Valor padrão. Executará as tarefas normalmente.
- `silent=1` - Executará todos os processos automáticos exibindo apenas o nome da tarefa que está sendo realizada no momento, sem nenhum detalhe adicional.
Funcionará apenas em conjunto com o modo bALF.

### - DeepClean
A limpeza profunda pode ser ativada alterando o valor de “deepclean” na linha 19 do código.

- `deepclean=0` - Valor padrão. A função de limpeza do sistema procurará por arquivos de determinadas extensões apenas na pasta C:\Windows.
- `deepclean=1` - A função de limpeza do sistema procurará por arquivos de determinadas extensões em **toda a unidade** onde o Windows está instalado.
---

# ℹ️ Mais informações
- [Lista de serviços alterados](https://github.com/rubem-psd/W11bALF/blob/main/Recursos/Mais_Informa%C3%A7%C3%B5es/Lista_de_servi%C3%A7os_alterados.md)
- [Lista de tarefas de telemetria alteradas](https://github.com/rubem-psd/W11bALF/blob/main/Recursos/Mais_Informa%C3%A7%C3%B5es/Lista_de_tarefas_de_telemetria_alteradas.md)
- [Lista de programas desinstalados](https://github.com/rubem-psd/W11bALF/blob/main/Recursos/Mais_Informa%C3%A7%C3%B5es/Lista_de_programas_desinstalados.md)
- [Sobre a alteração de configurações](https://github.com/rubem-psd/W11bALF/blob/main/Recursos/Mais_Informa%C3%A7%C3%B5es/Sobre_a_altera%C3%A7%C3%A3o_de_configura%C3%A7%C3%B5es.md)
- [Lista de limpeza](https://github.com/rubem-psd/W11bALF/blob/main/Recursos/Mais_Informa%C3%A7%C3%B5es/Lista_de_limpeza.md)
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
- Motivo 2 - Se o Windows já estiver instalado há algum tempo, você provavelmente já personalizou o menu iniciar e a barra de tarefas. Usar essa função vai desfixar todos os ícones tanto do menu iniciar quanto da barra de tarefas, o que apenas atrapalhará você nesse caso.

---

**[🟩 Clique aqui para fazer o download da versão mais recente do script 🟩](https://github.com/rubem-psd/W11bALF/releases/latest)**

---

Para relatar bugs, enviar sugestões ou fazer perguntas use a aba [issues](https://github.com/rubem-psd/W11bALF/issues) na página principal. Por favor, use a label correspondente ao tipo de mensagem.

---
##### W11bALF - Windows 11 but A Little Faster - v1.0.0⠀⠀⠀|||⠀⠀⠀Criado com ❤️ por Rubem Júnior⠀⠀⠀|||⠀⠀⠀2024
