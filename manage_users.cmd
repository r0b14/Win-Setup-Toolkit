@echo off
:: manage_users.cmd
:: Remove contas locais, elevar usuário atual e criar 'Curso Fênix' com os
:: mesmos grupos (apenas locais). Execute COMO ADMINISTRADOR.

:: Verifica privilégio
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo *********************************************
    echo  Este script deve ser executado como ADMIN.
    echo  Clique com o direito e escolha "Run as administrator".
    echo *********************************************
    pause
    exit /b 1
)

setlocal EnableDelayedExpansion
set "CUR=%USERNAME%"
set "NEW=Curso Fênix"
set "PASS=Fenix@123!"

echo Usuario atual: %CUR%

:: 1) Garante que o usuario atual faz parte dos Administrators
net localgroup Administrators "%CUR%" /add >nul 2>&1

:: 2) Remove usuarios locais nao protegidos
for /f "skip=4 tokens=1" %%u in ('net user ^| findstr /R "^[A-Za-z]"') do (
    if /I not "%%u"=="Administrator" if /I not "%%u"=="DefaultAccount" if /I not "%%u"=="Guest" if /I not "%%u"=="%CUR%" if /I not "%%u"=="%NEW%" (
        echo Removendo conta local: %%u
        net user "%%u" /delete >nul 2>&1
    )
)

:: 3) Cria usuario 'Curso Fênix' se nao existir
net user "%NEW%" >nul 2>&1
if %errorlevel% neq 0 (
    echo Criando conta "%NEW%"...
    net user "%NEW%" "%PASS%" /add /expires:never >nul
)

:: 4) Copia grupos do usuario atual para o novo
echo Replicando grupos locais...
for /f "tokens=*" %%g in ('net localgroup ^| findstr /R "^[A-Za-z].*"') do (
    rem Verifica se CUR faz parte do grupo
    net localgroup "%%g" | findstr /I /C:" %CUR% " >nul
    if !errorlevel! == 0 (
        rem Adiciona NEW se ainda nao for membro
        net localgroup "%%g" | findstr /I /C:" %NEW% " >nul
        if !errorlevel! neq 0 (
            net localgroup "%%g" "%NEW%" /add >nul 2>&1
        )
    )
)

echo.
echo Operacao concluida!
pause