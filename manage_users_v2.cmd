@echo off
:: manage_users_v2.cmd
:: - Garante usuário atual como administrador.
:: - Cria usuário "Curso Fenix" sem senha e com privilégios padrão (Users).
:: Execute como Administrador.

net session >nul 2>&1
if %errorlevel% neq 0 (
  echo ===============================================
  echo  Este script precisa de privilegios de ADMIN.
  echo ===============================================
  pause
  exit /b 1
)

setlocal EnableDelayedExpansion
set "CUR=%USERNAME%"
set "NEW=Curso Fenix"

echo Usuário atual: %CUR%

:: 1) Adiciona usuario atual ao grupo Administrators
net localgroup Administrators "%CUR%" | find /I "%CUR%" >nul
if errorlevel 1 (
  echo Adicionando %CUR% ao grupo Administrators...
  net localgroup Administrators "%CUR%" /add
) else (
  echo %CUR% já é Administrador.
)

:: 2) Cria "Curso Fenix" sem senha (se nao existir)
net user "%NEW%" >nul 2>&1
if %errorlevel% neq 0 (
  echo Criando usuario "%NEW%" sem senha...
  net user "%NEW%" "" /add /expires:never /passwordchg:yes /passwordreq:no
  net localgroup Users "%NEW%" /add
) else (
  echo Usuario "%NEW%" já existe.
)

echo.
echo Script concluído.
pause