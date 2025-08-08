**1. Project name**
**Win-Fenix Setup Toolkit**

---

**2. Short description**
Automated Windows provisioning toolkit that installs core apps with Winget, adds RSAT AD, updates drivers, enforces password-protected file sharing, and standardizes local users—everything through easy-to-run batch files.

---

## 3. `README.mkd` (pt-BR)

```markdown
# Win-Fenix Setup Toolkit

Conjunto de scripts **.cmd** que automatizam a configuração inicial de notebooks/PCs
Windows. Ideal para lotes de máquinas em laboratórios, ONGs ou pequenas empresas que
precisam de um ambiente padronizado sem ferramentas complexas de gerenciamento.

---

## ✨ O que ele faz

| Script | Função principal |
|--------|------------------|
| **setup_all_v3.cmd** | Instala 7-Zip, Git, Java Runtime, Google Chrome, VS Code, habilita RSAT AD, atualiza todos os pacotes via Winget, executa Windows Update (drivers) e, por último, Microsoft 365 (Office) — gerando log em `setup_all_v3.log`. |
| **manage_users_v2.cmd** | Garante que o usuário logado seja administrador e cria o usuário **Curso Fenix** (sem senha, perfil padrão). |
| **network_share_config.cmd** | Ativa descoberta de rede, compartilhamento de arquivos/impressoras e mantém o acesso protegido por senha. |

---

## 🚀 Requisitos

* Windows 10 21H2 ou superior / Windows 11  
* Conta com privilégios de **Administrador**
* Conexão à internet (para Winget, Office e Windows Update)

---

## 📂 Estrutura do repositório

```

│ README.mkd
│
├─ setup\_all\_v3.cmd
├─ manage\_users\_v2.cmd
└─ network\_share\_config.cmd

```

> Versões anteriores dos scripts (`setup_all_v2`, `manage_users.cmd`, etc.) estão
> preservadas na pasta **legacy/** (opcional).

---

## 🛠️ Passo a passo

1. **Clone** ou baixe o repositório.  
2. Clique com o botão direito em **setup_all_v3.cmd** →  
   _Executar como administrador_.  
   *Esse passo pode reiniciar o PC.*  
3. Após concluir a instalação de software, rode **manage_users_v2.cmd** (também como
   administrador) para padronizar as contas locais.  
4. Por fim, execute **network_share_config.cmd** para ativar o compartilhamento em rede.

---

## 📝 Logs

* `setup_all_v3.log` grava toda a saída do script principal.
* Em caso de erro no passo 4 (Windows Update) o script **não fecha**: leia a mensagem e consulte o log.

---

## 🔧 Personalização

* **Senha do usuário _Curso Fenix_** – edite a variável `PASS` em `manage_users_v2.cmd`.
* **Pacotes adicionais** – adicione seus IDs Winget no bloco `for %%P in (...)` dentro de `setup_all_v3.cmd`.
* **Idioma/canal do Office** – substitua `Microsoft.Office` por  
  `Microsoft.Office -c MonthlyEnterprise -l pt-BR` (exemplo).

---

## ⚠️ Avisos de segurança

* Usar conta sem senha facilita a implantação, mas pode **reduzir a segurança**.  
  Recomenda-se definir senha depois da instalação.
* Scripts modificam grupos locais, serviços e firewall — teste primeiro em ambiente de
  homologação.
* O tempo de instalação do Office depende da velocidade da internet
  (2 GB+ de download).

---

## 📄 Licença

Distribuído sob a licença **MIT**. Veja `LICENSE` para detalhes.

---

Feito com ❤️ por _r0b14 para simplificar a inclusão digital.
```
