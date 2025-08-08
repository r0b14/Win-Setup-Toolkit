<#
.SYNOPSIS
    Instala 7-Zip, Git, Java Runtime, Google Chrome, Visual Studio Code
    e Microsoft 365 Apps (Office) para TODOS os usuários (scope=machine).
    Em seguida, aplica drivers/patches via Windows Update.

.DESCRIPTION
    Requer winget já instalado. Execute como Administrador.
    Observação: O Office será instalado na versão Microsoft 365 Apps for enterprise.
    O produto exigirá login/licença válida após a instalação.
#>

# Checagem de privilégio Administrador
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
    Write-Warning 'Execute este script como Administrador (Run as administrator).'
    Pause
    exit 1
}

function Install-AppMachine {
    param(
        [string]$Id
    )
    Write-Host "Instalando $Id (scope=machine) ..."
    winget install --id $Id --exact -h -e --scope machine --accept-package-agreements --accept-source-agreements
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "Falha ao instalar $Id (código $LASTEXITCODE)."
    }
}

# Lista de pacotes
$packages = @(
    '7zip.7zip',
    'Git.Git',
    'Oracle.JavaRuntime',
    'Google.Chrome',
    'Microsoft.VisualStudioCode',
    'Microsoft.Office'          # Microsoft 365 Apps (Office)
)

foreach ($pkg in $packages) {
    Install-AppMachine $pkg
}

Write-Host "Atualizando todos os pacotes (scope machine)..." -ForegroundColor Cyan
winget upgrade --all --include-unknown -h --scope machine --accept-package-agreements --accept-source-agreements

# Windows / Driver updates
Write-Host "Aplicando atualizações do Windows Update (incluindo drivers)..." -ForegroundColor Cyan
try {
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force -Scope AllUsers | Out-Null
    if (-not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {
        Install-Module -Name PSWindowsUpdate -Force -Scope AllUsers -Confirm:$false
    }
    Import-Module PSWindowsUpdate
    Get-WindowsUpdate -MicrosoftUpdate -AcceptAll -Install -AutoReboot
} catch {
    Write-Warning "Falha ao aplicar atualizações via PSWindowsUpdate: $_"
}

Write-Host 'Processo concluído! Reinicie o sistema se não reiniciou automaticamente.' -ForegroundColor Green
Pause