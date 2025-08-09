@echo off
:: setup_all_v2_3.cmd
:: LEGADO: Correção de erro "CALL :label outside script" - Use setup_all_v3.cmd
:: Instala aplicativos essenciais, Office antes do Windows Update
:: Versão intermediária com melhorias de logging
:: Execute COMO ADMINISTRADOR.

setlocal EnableDelayedExpansion
set "LOG=%~dp0setup_all_v2_3.log"

echo ============================================================= > "%LOG%"
echo  LOG de instalacao - %DATE% %TIME%                         >> "%LOG%"
echo =============================================================>> "%LOG%"

REM -------- Verifica privilegio ----------
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    echo [ERRO] Execute como Administrador. >> "%LOG%"
    pause
    exit /b 1
)

call :log "[0] Verificando winget..."
where winget >nul 2>&1
if %errorlevel% neq 0 (
    call :log "winget não encontrado. Instalando..."
    powershell -NoProfile -ExecutionPolicy Bypass -Command ^
      "Invoke-WebRequest 'https://aka.ms/getwinget' -OutFile '$env:TEMP\\winget.msixbundle'; Add-AppxPackage -Path '$env:TEMP\\winget.msixbundle'" >> "%LOG%" 2>&1
)

set "PATH=%PATH%;%ProgramFiles%\WindowsApps"
set "COMMON=--exact -h -e --scope machine --accept-package-agreements --accept-source-agreements"

call :log ""
call :log "[1/5] Instalando pacotes (7zip, Git, Java, Chrome, VSCode, AnyDesk)..."
for %%P in (7zip.7zip Git.Git Oracle.JavaRuntime Google.Chrome Microsoft.VisualStudioCode AnyDeskSoftware.AnyDesk) do (
    call :log "  - %%P"
    winget install --id %%P %COMMON% >> "%LOG%" 2>&1
)

call :log ""
call :log "[2/5] Habilitando RSAT Active Directory..."
dism /online /add-capability /capabilityname:Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0 >> "%LOG%" 2>&1

call :log ""
call :log "[3/5] Atualizando todos os pacotes via winget..."
winget upgrade --all -h --scope machine --accept-package-agreements --accept-source-agreements >> "%LOG%" 2>&1

call :log ""
call :log "[4/5] Instalando Microsoft 365 (Office)..."
winget install --id Microsoft.Office %COMMON% >> "%LOG%" 2>&1

call :log ""
call :log "[5/5] Iniciando verificação rápida do Windows Update..."
wuauclt /detectnow >> "%LOG%" 2>&1
wuauclt /updatenow  >> "%LOG%" 2>&1

call :log ""
call :log "Script concluído. Veja %LOG% para detalhes."
pause
exit /b

:log
:: Função de log: ecoa no console e grava no arquivo
echo %*
echo %*>>"%LOG%"
exit /b