# 🤝 Contribuindo para o Win-Setup-Toolkit

Obrigado pelo interesse em contribuir! Este projeto existe para **democratizar a configuração de sistemas Windows** e cada contribuição faz a diferença.

## 🚀 Como Contribuir

### 🐛 Reportando Bugs

1. Verifique se o bug já não foi [reportado](https://github.com/r0b14/Win-Setup-Toolkit/issues)
2. Use o template de issue para bugs
3. Inclua:
   - Versão do Windows
   - Script que apresentou problema
   - Log de erro completo
   - Passos para reproduzir

### 💡 Sugerindo Melhorias

- Abra uma [issue](https://github.com/r0b14/Win-Setup-Toolkit/issues) com label "enhancement"
- Descreva o problema que sua sugestão resolve
- Explique como sua ideia beneficiaria outros usuários

### 🔧 Enviando Código

1. **Fork** o repositório
2. **Clone** seu fork: `git clone https://github.com/SEU-USUARIO/Win-Setup-Toolkit.git`
3. **Branch**: `git checkout -b feature/minha-feature`
4. **Implemente** suas mudanças
5. **Teste** em ambiente controlado
6. **Commit**: `git commit -m "feat: adiciona nova funcionalidade X"`
7. **Push**: `git push origin feature/minha-feature`
8. **Pull Request**: Abra um PR explicando suas mudanças

## 📋 Padrões de Código

### Para Scripts Batch (.cmd)

```batch
@echo off
:: nome_do_script.cmd
:: Breve descrição do que o script faz
:: LEGADO/ATIVO: Status do script
:: Execute COMO ADMINISTRADOR (se necessário)

REM Sempre verificar privilégios quando necessário
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Este script precisa de privilégios de ADMINISTRADOR
    pause
    exit /b 1
)

REM Código bem comentado
echo Fazendo algo importante...
```

### Para Scripts PowerShell (.ps1)

```powershell
<#
.SYNOPSIS
    Descrição breve e clara

.DESCRIPTION
    Descrição detalhada do que o script faz

.NOTES
    Versão do Windows suportada
    Requisitos especiais
#>

# Verificação de privilégios
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning 'Execute como Administrador'
    exit 1
}
```

## 🧪 Testando

- **Sempre teste** em máquina virtual antes de enviar PR
- **Documente** os cenários testados
- **Inclua** logs de teste quando relevante

## 📝 Documentação

- **README.md**: Mantenha atualizado com novas funcionalidades
- **Comentários**: Explique o "porquê", não apenas o "como"
- **Logs**: Scripts devem gerar logs informativos

## 🎯 Áreas que Precisam de Ajuda

- 🔧 **Novos scripts de automação**
- 📚 **Documentação e tutoriais**
- 🐛 **Correção de bugs**
- 🌍 **Localização** (suporte a outros idiomas)
- ⚡ **Otimização de performance**
- 🔒 **Melhorias de segurança**

## 💡 Ideias para Contribuições

- Suporte para softwares específicos (desenvolvimento, design, etc.)
- Scripts para diferentes ambientes (escolas, escritórios, gaming)
- Integração com Active Directory
- Interface gráfica simples
- Monitoramento e relatórios

## 📞 Comunicação

- **Issues**: Para discussões específicas
- **Discussions**: Para ideias e dúvidas gerais
- **Email**: Para questões sensíveis

## 🏆 Reconhecimento

Todos os contribuidores são reconhecidos:
- **README.md**: Lista de contribuidores
- **Releases**: Créditos em cada versão
- **Comunidade**: Destaque em redes sociais

---

## 📜 Código de Conduta

Este projeto segue um ambiente **respeitoso e inclusivo**:

- ✅ Seja respeitoso com diferentes opiniões
- ✅ Foque no que é melhor para a comunidade
- ✅ Use linguagem acessível e clara
- ❌ Não toleramos discriminação ou assédio

---

**Juntos, democratizamos a tecnologia! 🚀**
