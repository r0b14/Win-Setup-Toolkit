@echo off
:: setup_all.cmd
:: LEGADO: Primeira versão do script de instalação - Use setup_all_v3.cmd
:: Instala aplicativos via winget (7zip, Git, Java, Chrome, VSCode, Office),
:: habilita RSAT Active Directory e realiza Windows Update/drivers.
:: Versão básica sem logging avançado
:: Execute COMO ADMINISTRADOR.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo *********************************************
    echo  Este script deve ser executado como ADMIN.
    echo  Clique com o direito e escolha "Run as administrator".
    echo *********************************************
    pause
    exit /b 1
)

:: Ativa ANSI cores se suportado
for /f "tokens=2 delims=[]" %%i in ('ver') do set ver=%%i

echo Verificando winget...
where winget >nul 2>&1
if %errorlevel% neq 0 (
    echo winget nao encontrado. Instalando...
    powershell -NoProfile -ExecutionPolicy Bypass -Command ^
      "Invoke-WebRequest -Uri 'https://aka.ms/getwinget' -OutFile '%TEMP%\\winget.msixbundle'; Add-AppxPackage -Path '%TEMP%\\winget.msixbundle'"
)

:: Recarrega PATH
set "PATH=%PATH%;%ProgramFiles%\WindowsApps"

echo.
echo ===== Instalando pacotes via winget =====
set COMMON_ARGS=--exact -h -e --scope machine --accept-package-agreements --accept-source-agreements

winget install --id 7zip.7zip %COMMON_ARGS%
winget install --id Git.Git %COMMON_ARGS%
winget install --id Oracle.JavaRuntime %COMMON_ARGS%
winget install --id Google.Chrome %COMMON_ARGS%
winget install --id Microsoft.VisualStudioCode %COMMON_ARGS%
winget install --id Microsoft.Office %COMMON_ARGS%

echo.
echo ===== Habilitando RSAT Active Directory =====
dism /online /add-capability /capabilityname:Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0

echo.
echo ===== Atualizando pacotes via winget =====
winget upgrade --all --include-unknown -h --scope machine --accept-package-agreements --accept-source-agreements

echo.
echo ===== Executando Windows Update (drivers incluídos) =====
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force -Scope AllUsers; ^
   if (-not (Get-Module -ListAvailable -Name PSWindowsUpdate)) { Install-Module -Name PSWindowsUpdate -Force -Scope AllUsers -Confirm:$false }; ^
   Import-Module PSWindowsUpdate; ^
   Get-WindowsUpdate -MicrosoftUpdate -AcceptAll -Install -AutoReboot"

echo.
echo Concluido! Reinicie a maquina se nao reiniciou automaticamente.
pause