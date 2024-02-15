# Configurações de hibernação
O programa irá detectar automaticamente o tipo de armazenamento onde o Windows está instalado e tomará a decisão mais adequada de acordo com o resultado da detecção.
- Se o Windows estiver instalado em um HDD o programa irá sugerir que você reduza o tamanho do hiberfil.sys - `powercfg /h /type reduced`
- Se o Windows estiver instalado em um SSD ou em um NVME o programa irá sugerir que você desative a hibernação, já que a diferença em relação ao tempo de inicialização do Windows usando o início rápido é irrelevante. - `powercfg /h off`

No modo automático o programa irá automaticamente aplicar a configuração adequada para o seu tipo de drive de armazenamento.

---

[Voltar para a página principal](https://github.com/rubem-psd/W11bALF)
