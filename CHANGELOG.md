# 📋 Changelog

Todas as mudanças importantes neste projeto serão documentadas neste arquivo.

O formato é baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.0.0/),
e este projeto segue [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Em Desenvolvimento] - 2025-01-XX

### 🚀 Adicionado
- Suporte completo ao PowerShell 7 no `install_winget.ps1`
- Documentação aprimorada com foco em projeto opensource
- Arquivo `CONTRIBUTING.md` para facilitar contribuições
- Badges do GitHub no README para mostrar atividade do projeto

### 🔧 Melhorado  
- README.md totalmente reformulado com design atrativo
- Melhor organização dos scripts por categoria (Ativo/Legado)
- Instruções mais claras para novos usuários
- Ênfase na economia de tempo e custos

### 📚 Documentação
- Seção de contribuição expandida
- Exemplos práticos de personalização
- Guia de segurança e boas práticas

## [v3.0] - 2024-XX-XX

### 🚀 Adicionado
- **setup_all_v3.cmd** - Versão mais robusta com logging completo
- Sistema de logs detalhado (`setup_all_v3.log`)
- Melhor tratamento de erros
- Ordem otimizada de instalação

### 🔧 Melhorado
- Instalação mais confiável do winget
- Melhor verificação de privilégios administrativos
- Tratamento de falhas no Windows Update

## [v2.4] - 2024-XX-XX

### 🚀 Adicionado
- **setup_all_v2_4.cmd** - Inclui instalação do PowerShell 7
- Suporte para atualização automática do PowerShell Core

### 🔧 Melhorado
- Sistema de logging aprimorado
- Melhor detecção de falhas

## [v2.3] - 2024-XX-XX

### 🐛 Corrigido
- **setup_all_v2_3.cmd** - Correção do erro "CALL :label outside script"
- Melhoria na função de logging
- Office instalado antes do Windows Update

## [v2.0] - 2024-XX-XX

### 🚀 Adicionado
- **manage_users_v2.cmd** - Gerenciamento avançado de usuários
- **network_share_config.cmd** - Configuração automática de rede
- **settings_v1.cmd** - Otimizações de sistema

### 🔧 Melhorado
- Scripts modulares para diferentes funções
- Melhor organização do código
- Suporte para ambientes corporativos

## [v1.0] - 2024-XX-XX

### 🚀 Adicionado
- **setup_all.cmd** - Script inicial para instalação básica
- **manage_users.cmd** - Gerenciamento simples de usuários
- **install_winget.cmd** - Instalação do Windows Package Manager
- Suporte básico para aplicações essenciais

### 📚 Documentação
- README.md inicial
- Licença MIT
- Instruções básicas de uso

---

## 📝 Notas sobre Versionamento

- **Major (X.0.0)**: Mudanças que quebram compatibilidade
- **Minor (0.X.0)**: Novas funcionalidades mantendo compatibilidade  
- **Patch (0.0.X)**: Correções de bugs e melhorias menores

## 🎯 Próximas Versões

### v4.0 (Planejado)
- [ ] Interface gráfica opcional
- [ ] Suporte para perfis customizados
- [ ] Integração com Active Directory
- [ ] Monitoramento pós-instalação
- [ ] Suporte multi-idioma

### Backlog
- [ ] Scripts para ambientes específicos (desenvolvimento, design, gaming)
- [ ] Integração com ferramentas de monitoramento
- [ ] API REST para integração corporativa
- [ ] Dashboard web para gestão de múltiplas máquinas

---

## 🤝 Como Contribuir com o Changelog

Ao fazer um Pull Request, adicione suas mudanças na seção "Em Desenvolvimento" seguindo o formato:

```markdown
### 🚀 Adicionado / 🔧 Melhorado / 🐛 Corrigido / ❌ Removido
- Descrição clara da mudança (#número-da-issue)
```

**Obrigado por ajudar a manter este projeto organizado!** 🙏
