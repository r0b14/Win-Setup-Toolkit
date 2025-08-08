@echo off
:: setup_all_v3.cmd
:: Maior robustez: cria LOG de todas as etapas e mantém janela aberta em caso de erro.
:: Ordem: apps essenciais -> RSAT -> upgrades -> Windows Update (log) -> Office.
:: Execute COMO ADMINISTRADOR.

setlocal EnableDelayedExpansion
set "LOG=%~dp0setup_all_v3.log"

echo ============================================================= > "%LOG%"
echo  LOG de instalacao - %DATE% %TIME%                         >> "%LOG%"
echo =============================================================>> "%LOG%"

REM ---------- Verifica privilégio ----------
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute este script como ADMINISTRADOR. >> "%LOG%"
    echo Este script precisa ser executado como ADMINISTRADOR.
    pause
    exit /b 1
)

REM ---------- Winget ----------
echo [0] Verificando winget... | call :log
where winget >nul 2>&1
if %errorlevel% neq 0 (
    echo winget nao encontrado. Instalando... | call :log
    powershell -NoProfile -ExecutionPolicy Bypass -Command ^
      "Invoke-WebRequest -Uri 'https://aka.ms/getwinget' -OutFile '$env:TEMP\\winget.msixbundle'; Add-AppxPackage -Path '$env:TEMP\\winget.msixbundle'" >> "%LOG%" 2>&1
)

REM Atualiza PATH
set "PATH=%PATH%;%ProgramFiles%\WindowsApps"
set "COMMON=--exact -h -e --scope machine --accept-package-agreements --accept-source-agreements"

echo. | call :log
echo [1/5] Instalando pacotes essenciais (7zip, Git, Java, Chrome, VSCode)... | call :log
for %%P in (7zip.7zip Git.Git Oracle.JavaRuntime Google.Chrome Microsoft.VisualStudioCode) do (
    echo Install %%P... | call :log
    winget install --id %%P %COMMON% >> "%LOG%" 2>&1
)

echo. | call :log
echo [2/5] Habilitando RSAT Active Directory... | call :log
dism /online /add-capability /capabilityname:Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0 >> "%LOG%" 2>&1

echo. | call :log
echo [3/5] Atualizando todos os pacotes via winget... | call :log
winget upgrade --all --include-unknown -h --scope machine --accept-package-agreements --accept-source-agreements >> "%LOG%" 2>&1

echo. | call :log
echo [4/5] Executando Windows Update (drivers)... | call :log
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$ProgressPreference='SilentlyContinue'; try { ^
     Install-PackageProvider NuGet -MinimumVersion 2.8.5.201 -Force -Scope AllUsers; ^
     if (-not (Get-Module -ListAvailable PSWindowsUpdate)) { Install-Module PSWindowsUpdate -Force -Scope AllUsers -Confirm:\$false }; ^
     Import-Module PSWindowsUpdate; ^
     Get-WindowsUpdate -MicrosoftUpdate -AcceptAll -Install -AutoReboot ^
   } catch { Write-Host 'Erro em Windows Update:'; Write-Host \$_; exit 1 }" >> "%LOG%" 2>&1

if %errorlevel% neq 0 (
    echo [ERRO] Falha no passo 4 (Windows Update). Veja o log. | call :log
    goto :end
)

echo. | call :log
echo [5/5] Instalando Microsoft 365 (Office)... | call :log
winget install --id Microsoft.Office %COMMON% >> "%LOG%" 2>&1

:end
echo. | call :log
echo Processo concluído. Consulte "%LOG%" para detalhes. | call :log
pause
exit /b

:log
rem Replica a mensagem na tela e no LOG
set "msg=%*"
echo %msg%
echo %msg%>>"%LOG%"
exit /b