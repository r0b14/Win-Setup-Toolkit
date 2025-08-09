<#
.SYNOPSIS
    Ensure Windows Package Manager (winget) is installed.

.DESCRIPTION
    Checks for winget. If missing, downloads the official App Installer package
    and installs it silently. Run as Administrator.

.NOTES
    Tested on Windows 10 21H2+ and Windows 11.
#>

# install_winget.ps1
# Baixa e instala o App Installer (winget) no Windows 10 via PowerShell.

# 1) Verifica privilégio de administrador
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host '====================================================='
    Write-Host ' Este script deve ser executado como ADMINISTRADOR!'
    Write-Host ' Clique com o direito e escolha "Executar como administrador".'
    Write-Host '====================================================='
    Pause
    exit 1
}

# 2) Baixa o pacote oficial do App Installer/winget
Write-Host 'Baixando winget...'
$tempFile = "$env:TEMP\winget.msixbundle"
try {
    Invoke-WebRequest -Uri 'https://aka.ms/getwinget' -OutFile $tempFile -ErrorAction Stop
} catch {
    Write-Host 'ERRO: falha no download. Verifique a conexão.'
    Pause
    exit 1
}

if (-not (Test-Path $tempFile)) {
    Write-Host 'ERRO: falha no download. Verifique a conexão.'
    Pause
    exit 1
}

# 3) Instala o winget
Write-Host 'Instalando winget...'
try {
    Add-AppxPackage -Path $tempFile -ErrorAction Stop
} catch {
    Write-Host 'ERRO: não foi possível instalar o App Installer.'
    Write-Host 'Tente instalar pela Microsoft Store pesquisando por "App Installer".'
    Pause
    exit 1
}

# 4) Confirma instalação
if (Get-Command winget -ErrorAction SilentlyContinue) {
    Write-Host ''
    Write-Host '============================================='
    winget --version
    Write-Host 'winget instalado com sucesso!'
    Write-Host '============================================='

    # 5) Instala/atualiza PowerShell 7
    Write-Host ''
    Write-Host 'Verificando se o PowerShell 7 está instalado...'
    $pwshCmd = Get-Command pwsh -ErrorAction SilentlyContinue
    if ($pwshCmd) {
        $pwshVersion = & pwsh -NoLogo -NoProfile -Command "$PSVersionTable.PSVersion.ToString()"
        Write-Host "PowerShell 7 já instalado. Versão: $pwshVersion"
        Write-Host 'Verificando se há atualização disponível...'
        winget upgrade --id Microsoft.Powershell --silent --accept-package-agreements --accept-source-agreements
    } else {
        Write-Host 'Instalando PowerShell 7...'
        winget install --id Microsoft.Powershell --source winget --silent --accept-package-agreements --accept-source-agreements
    }
    Write-Host 'Se solicitado, reinicie o computador para concluir a instalação do PowerShell 7.'
} else {
    Write-Host 'Algo deu errado: winget ainda não foi encontrado no PATH.'
    Write-Host 'A atualização do PowerShell 7 requer o winget instalado.'
}

Pause