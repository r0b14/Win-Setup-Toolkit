@echo off
:: network_share_config.cmd
::
:: 1. Habilita descoberta de rede (Network Discovery) e compartilhamento de arquivos.
:: 2. Deixa o notebook visível na rede.
:: 3. Mantém o "Password‑protected sharing" ativado (acesso só com credenciais do PC).
::
:: Execute como Administrador.

REM ---- Verifica privilégio ----
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo =====================================================
    echo  Este script precisa ser executado como ADMINISTRADOR.
    echo =====================================================
    pause
    exit /b 1
)

echo.
echo [1/4] Ativando servicos de descoberta de rede...

for %%S in (FDResPub upnphost SSDPSRV) do (
    sc config %%S start= auto >nul 2>&1
    net start %%S >nul 2>&1
)

echo [2/4] Habilitando regras de firewall para Network Discovery e File & Printer Sharing...
netsh advfirewall firewall set rule group="Network Discovery" new enable=Yes
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=Yes

echo [3/4] Garantindo que o compartilhamento protegido por senha esteja ATIVADO...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v ForceGuest /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v LimitBlankPasswordUse /t REG_DWORD /d 1 /f

echo [4/4] Limpando cache de DNS NetBIOS e anunciando na rede...
nbtstat -R
nbtstat -RR

echo.
echo Configuracao concluida! O notebook agora aparece na rede e exige senha para acessar compartilhamentos.
pause