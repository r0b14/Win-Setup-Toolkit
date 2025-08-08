<#
.SYNOPSIS
    Ensure Windows Package Manager (winget) is installed.

.DESCRIPTION
    Checks for winget. If missing, downloads the official App Installer package
    and installs it silently. Run as Administrator.

.NOTES
    Tested on Windows 10 21H2+ and Windows 11.
#>

# Requires elevation
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
    Write-Warning 'Execute este script como Administrador (Run as administrator).'
    Pause
    exit 1
}

if (Get-Command winget -ErrorAction SilentlyContinue) {
    Write-Host 'winget já está instalado! Versão:' -ForegroundColor Green
    winget --version
    Pause
    exit 0
}

Write-Host 'winget não encontrado. Instalando App Installer...' -ForegroundColor Yellow
$bundle = "$env:TEMP\winget.msixbundle"

Invoke-WebRequest -Uri 'https://aka.ms/getwinget' -OutFile $bundle -UseBasicParsing
Add-AppxPackage -Path $bundle

if ($?) {
    Write-Host 'winget instalado com sucesso!' -ForegroundColor Green
} else {
    Write-Error 'Falha ao instalar o winget. Instale manualmente pela Microsoft Store (App Installer).'
}

Pause