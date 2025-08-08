@echo off
:: setup_all_v2_2.cmd
:: v2.2: adiciona AnyDesk, instala Office antes do Windows Update e simplifica a fase de updates.
:: Execute COMO ADMINISTRADOR.

setlocal EnableDelayedExpansion
set "LOG=%~dp0setup_all_v2_2.log"

echo ============================================================= > "%LOG%"
echo  LOG de instalacao - %DATE% %TIME%                         >> "%LOG%"
echo =============================================================>> "%LOG%"

REM -------- Privilégio ----------
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador. >> "%LOG%"
    echo Este script requer privilégios de administrador.
    pause
    exit /b 1
)

REM -------- Winget ----------
echo [0] Checando winget... | call :log
where winget >nul 2>&1
if %errorlevel% neq 0 (
    echo winget não encontrado. Instalando... | call :log
    powershell -NoProfile -ExecutionPolicy Bypass -Command ^
      "Invoke-WebRequest 'https://aka.ms/getwinget' -OutFile '$env:TEMP\\winget.msixbundle'; Add-AppxPackage -Path '$env:TEMP\\winget.msixbundle'" >> "%LOG%" 2>&1
)

set "PATH=%PATH%;%ProgramFiles%\WindowsApps"
set "COMMON=--exact -h -e --scope machine --accept-package-agreements --accept-source-agreements"

echo. | call :log
echo [1/5] Instalando pacotes (7zip, Git, Java, Chrome, VSCode, AnyDesk)... | call :log
for %%P in (7zip.7zip Git.Git Oracle.JavaRuntime Google.Chrome Microsoft.VisualStudioCode AnyDeskSoftware.AnyDesk) do (
    echo  - %%P | call :log
    winget install --id %%P %COMMON% >> "%LOG%" 2>&1
)

echo. | call :log
echo [2/5] Habilitando RSAT Active Directory... | call :log
dism /online /add-capability /capabilityname:Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0 >> "%LOG%" 2>&1

echo. | call :log
echo [3/5] Atualizando todos os pacotes via winget... | call :log
winget upgrade --all --include-unknown -h --scope machine --accept-package-agreements --accept-source-agreements >> "%LOG%" 2>&1

echo. | call :log
echo [4/5] Instalando Microsoft 365 (Office)... | call :log
winget install --id Microsoft.Office %COMMON% >> "%LOG%" 2>&1

echo. | call :log
echo [5/5] Iniciando verificação rápida do Windows Update... | call :log
wuauclt /detectnow >> "%LOG%" 2>&1
wuauclt /updatenow  >> "%LOG%" 2>&1

echo. | call :log
echo Script concluído. Consulte "%LOG%" em caso de dúvidas. | call :log
pause
exit /b

:log
echo %* 
echo %*>>"%LOG%"
exit /b