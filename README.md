
# 🚀 Win-Setup-Toolkit

<div align="center">

[![GitHub stars](https://img.shields.io/github/stars/r0b14/Win-Setup-Toolkit?style=social)](https://github.com/r0b14/Win-Setup-Toolkit/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/r0b14/Win-Setup-Toolkit?style=social)](https://github.com/r0b14/Win-Setup-Toolkit/network/members)
[![GitHub issues](https://img.shields.io/github/issues/r0b14/Win-Setup-Toolkit)](https://github.com/r0b14/Win-Setup-Toolkit/issues)
[![GitHub license](https://img.shields.io/github/license/r0b14/Win-Setup-Toolkit)](https://github.com/r0b14/Win-Setup-Toolkit/blob/main/LICENSE)

**🌟 Automatização completa para provisionamento Windows • 100% Código Aberto • Comunidade Ativa**

*Transforme a configuração manual de PCs em um processo de 3 cliques*

</div>

---

## 💡 Por que este projeto existe?

Em um mundo onde a **inclusão digital** é fundamental, configurar dezenas ou centenas de computadores manualmente é um pesadelo. Este toolkit nasceu da necessidade real de **ONGs, escolas e pequenas empresas** que precisam padronizar ambientes Windows rapidamente, sem orçamento para ferramentas corporativas complexas.

### 🎯 **Problema resolvido**
- ❌ Configuração manual demorada (3-4 horas por máquina)
- ❌ Inconsistências entre instalações  
- ❌ Dependência de técnicos especializados
- ❌ Custos elevados com licenças corporativas

### ✅ **Nossa solução**
- ✅ **15 minutos** para configuração completa
- ✅ **100% padronizado** e reprodutível
- ✅ **Sem dependências** externas complexas
- ✅ **Totalmente gratuito** e open source

---

## ✨ O que faz cada script

| Script | Função | Status |
|--------|--------|--------|
| **🚀 setup_all_v3.cmd** | **Script principal** - Instala apps essenciais (7-Zip, Git, Java, Chrome, VS Code), habilita RSAT AD, atualiza todos os pacotes, executa Windows Update e instala Microsoft 365 | ✅ Recomendado |
| **👥 manage_users_v2.cmd** | Garante que o usuário atual seja administrador e cria usuário padrão "Curso Fenix" | ✅ Ativo |
| **🌐 network_share_config.cmd** | Ativa descoberta de rede, compartilhamento seguro de arquivos/impressoras | ✅ Ativo |
| **⚙️ settings_v1.cmd** | Otimiza configurações de energia para alto desempenho | ✅ Ativo |
| **📦 install_winget.ps1** | Instala/atualiza Windows Package Manager (winget) e PowerShell 7 | ✅ Novo |
| **🏢 install_apps_winget_allusers_office.ps1** | Versão PowerShell para instalação empresarial | ✅ Alternativa |

### 📊 Scripts Legacy (Mantidos para compatibilidade)

- `setup_all_v2_*.cmd` - Versões anteriores do script principal
- `manage_users.cmd` / `manage_users.ps1` - Versões anteriores de gerenciamento de usuários
- `install_winget.cmd` - Versão batch do instalador winget

---

## 🚀 Requisitos Mínimos

- Windows 10 21H2 ou superior / Windows 11  
- Conta com privilégios de **Administrador**
- Conexão à internet (para Winget, Office e Windows Update)
- **2 GB de espaço livre** (para downloads temporários)

---

## 📂 Como usar - 3 passos simples

### 📥 **Passo 1: Download**
```bash
# Via Git (recomendado para desenvolvedores)
git clone https://github.com/r0b14/Win-Setup-Toolkit.git
cd Win-Setup-Toolkit

# Ou baixe o ZIP diretamente do GitHub
```

### ⚡ **Passo 2: Execução Principal**

1. **Abra como Administrador**: Clique com botão direito em `setup_all_v3.cmd` → **Executar como administrador**
2. **Aguarde**: O script fará tudo automaticamente (10-15 minutos)
3. **Reinicie** se solicitado

### 🔧 **Passo 3: Configuração Final**

```bash
# Execute os scripts complementares como Administrador:
manage_users_v2.cmd      # Configura usuários padrão
network_share_config.cmd # Ativa compartilhamento de rede
```

---

## 📚 Documentação Adicional

- 📖 **[CONTRIBUTING.md](CONTRIBUTING.md)** - Como contribuir para o projeto
- 📋 **[CHANGELOG.md](CHANGELOG.md)** - Histórico de versões e mudanças  
- 🌟 **[IMPACT.md](IMPACT.md)** - Casos de uso reais e impacto social
- 📄 **[LICENSE](LICENSE)** - Licença MIT completa

---

## � Monitoramento e Logs

- **📝 setup_all_v3.log** - Log detalhado de toda a instalação
- **⚠️ Erros**: O script mantém a janela aberta em caso de problemas
- **🔍 Debug**: Todos os comandos são registrados com timestamp

---

## �️ Personalização Avançada

### 🎯 **Adicionando novos softwares**

```batch
# Edite setup_all_v3.cmd, seção de pacotes:
for %%P in (
    7zip.7zip 
    Git.Git 
    SEU.NOVO.PACOTE    # <- Adicione aqui
) do (
    winget install --id %%P %COMMON%
)
```

### 👤 **Modificando usuários padrão**

```batch
# Em manage_users_v2.cmd, altere:
set "NEW=Curso Fenix"      # Nome do usuário
set "PASS="                # Senha (vazio = sem senha)
```

### 🌐 **Office personalizado**

```batch
# Para Office em português com canal específico:
winget install Microsoft.Office -c MonthlyEnterprise -l pt-BR
```

---

## 🔒 Segurança e Boas Práticas

| ⚠️ Atenção | Recomendação |
|------------|--------------|
| **Usuário sem senha** | Defina senha após instalação em ambientes corporativos |
| **Scripts modificam sistema** | Teste sempre em ambiente controlado primeiro |
| **Execução como Admin** | Scripts requerem privilégios elevados para funcionar |
| **Downloads da Internet** | Verifique conectividade antes de executar |

---

## 🤝 Como Contribuir para o Projeto

Este projeto **vive da comunidade**! Sua contribuição faz a diferença:

### 🌟 **Formas de contribuir:**

- **⭐ Dê uma estrela** - Simples e ajuda muito na visibilidade
- **🐛 Reporte bugs** - Abra uma [issue](https://github.com/r0b14/Win-Setup-Toolkit/issues)
- **💡 Sugira melhorias** - Compartilhe suas ideias
- **🔧 Envie Pull Requests** - Suas implementações são bem-vindas
- **📢 Divulgue** - Compartilhe com sua rede

### 👨‍💻 **Para desenvolvedores:**

1. Fork este repositório
2. Crie sua branch: `git checkout -b feature/MinhaNovaFeature`  
3. Commit suas mudanças: `git commit -m 'Adiciona nova feature'`
4. Push para branch: `git push origin feature/MinhaNovaFeature`
5. Abra um Pull Request

---

## 📈 Estatísticas do Projeto

- **🏢 Usado por**: ONGs, escolas, pequenas empresas, laboratórios
- **⏱️ Tempo poupado**: ~3 horas por máquina → 15 minutos
- **💰 Economia**: R$ 200+ em licenças por sistema
- **🌍 Impacto**: Facilitando inclusão digital no Brasil

---

## ❤️ Reconhecimentos

Este projeto é possível graças a:

- **Comunidade Open Source** - Por ferramentas como winget, PowerShell
- **Microsoft** - Por disponibilizar ferramentas robustas e gratuitas  
- **Contribuidores** - Cada sugestão e melhoria importa
- **Usuários finais** - Por confiarem em nossa solução

---

## 📄 Licença

Distribuído sob a **Licença MIT**. Veja [LICENSE](LICENSE) para detalhes.

**TL;DR**: Você pode usar, modificar e distribuir livremente, mantendo os créditos.

---

<div align="center">

### 🚀 **Feito com ❤️ por [r0b14](https://github.com/r0b14)**

**Para democratizar a configuração de sistemas Windows**

[![GitHub](https://img.shields.io/badge/GitHub-r0b14-181717?style=for-the-badge&logo=github)](https://github.com/r0b14)

*"Tecnologia deve ser acessível a todos"*

</div>
