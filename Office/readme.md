# W11bALF: Office365
Este é um sub-recurso/programa criado para o W11bALF que automatiza todo o processo de instalação do Office365
</br></br>

## Passo a passo da automação:
• Faz o download do Office Deployment Tool [diretamente da Microsoft](https://download.microsoft.com/download/6c1eeb25-cf8b-41d9-8d0d-cc1dbc032140/officedeploymenttool_19929-20090.exe).  
• Extrai esse arquivo e deleta o configuration.xml padrão.  
• Faz o download do desinstalador do Office (OfficeScrubber).  
• Te permite escolher o idioma desejado.  
• Te permite escolher quais programas serão instalados.  
• Exibe um resumo antes de iniciar o processo.  
• Cria um novo arquivo .xml chamado `o365list.xml` com todas as escolhas feitas.  
• Inicia a instalação silenciosa do Office365: `setup.exe /configure o365list.xml`  
• Finaliza o processo, notifica o usuário sobre a conclusão e aguarda 7 segundos.  
• `PowerShell -ExecutionPolicy Unrestricted -Command "& ([ScriptBlock]::Create((irm https://get.activated.win))) /ohook"`  
• Finaliza o processo, notifica o usuário sobre a conclusão e aguarda 7 segundos.  
• Retorna ao menu.
</br></br>

## Referências:
• XML customizado: https://config.office.com/deploymentsettings  
• Office Deployment Tool: https://www.microsoft.com/en-us/download/details.aspx?id=49117  
• Office Scrubber: https://github.com/abbodi1406/BatUtil/tree/master/OfficeScrubber  
• https://massgrave.dev/command_line_switches  

</br>

---

###### W11bALF - Windows 11 but A Little Faster - Criado por Rubem - Obrigado pelo apoio!
