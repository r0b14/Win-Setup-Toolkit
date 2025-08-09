@echo off
:: settings_v1.cmd
:: Ajusta configurações de energia e desempenho para Windows 10 desktop.
:: Necessário: executar COMO ADMINISTRADOR.

:: 1. Checagem de privilégio
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo =====================================================
    echo  Este script precisa ser executado como ADMINISTRADOR
    echo =====================================================
    pause
    exit /b 1
)

:: 2. Ativa plano "Alto desempenho" (High performance). Se não existir, cria.
for /f "tokens=1" %%i in ('powercfg /l ^| findstr /I "High performance"') do (
    set "HPGUID=%%i"
)
if defined HPGUID (
    echo Ativando plano de energia Alto desempenho...
    powercfg /setactive %HPGUID%
) else (
    echo Plano Alto desempenho não encontrado. Criando cópia do balanceado...
    powercfg /duplicatescheme SCHEME_BALANCED
    for /f "tokens=1" %%i in ('powercfg /l ^| findstr /I "Copy of"') do set "HPNEW=%%i"
    if defined HPNEW (
        powercfg /changename %HPNEW% "High performance"
        powercfg /setactive %HPNEW%
    )
)

:: 3. Ajusta tempos: tela 10 min, suspensão 15 min (AC)
powercfg /change monitor-timeout-ac 10
powercfg /change standby-timeout-ac 15

:: 4. Ajusta tempos para bateria (DC) se aplicável (notebook)
powercfg /change monitor-timeout-dc 10
powercfg /change standby-timeout-dc 15

:: 5. Desativa apps em segundo plano (todos os usuários via política)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v LetAppsRunInBackground /t REG_DWORD /d 2 /f
:: Também desativar para usuário atual
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f

echo.
echo Configurações aplicadas com sucesso!
pause