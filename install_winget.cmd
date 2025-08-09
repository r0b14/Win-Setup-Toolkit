@echo off
:: install_winget.cmd
:: Baixa e instala o App Installer (winget) no Windows 10.

:: 1) Verifica privilégio de administrador
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo =====================================================
    echo  Este script deve ser executado como ADMINISTRADOR!
    echo  Clique com o direito e escolha "Run as administrator".
    echo =====================================================
    pause
    exit /b 1
)

:: 2) Baixa o pacote oficial do App Installer/winget
echo Baixando winget...
set "TEMPFILE=%TEMP%\winget.msixbundle"
powershell -NoProfile -ExecutionPolicy Bypass ^
  "Invoke-WebRequest -Uri 'https://aka.ms/getwinget' -OutFile '%TEMPFILE%'"

if not exist "%TEMPFILE%" (
    echo ERRO: falha no download. Verifique a conexão.
    pause
    exit /b 1
)

:: 3) Instala o winget usando PowerShell
echo Instalando winget...
powershell -NoProfile -ExecutionPolicy Bypass ^
  "Add-AppxPackage -Path '%TEMPFILE%'"

if %errorlevel% neq 0 (
    echo ERRO: nao foi possível instalar o App Installer.
    echo Tente instalar pela Microsoft Store pesquisando por "App Installer".
    pause
    exit /b 1
)

:: 4) Confirma instalação
where winget >nul 2>&1
if %errorlevel% equ 0 (
    echo.
    echo =============================================
    echo winget instalado com sucesso!
    winget --version
    echo =============================================
) else (
    echo Algo deu errado: winget ainda nao foi encontrado no PATH.
)

pause
