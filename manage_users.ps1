<#
.SYNOPSIS
    Automatiza gerenciamento de contas locais:
      • Remove todas as contas exceto Administrator, DefaultAccount, Guest,
        usuário logado e 'Curso Fênix'.
      • Concede privilégios de administrador (grupo Administrators) ao usuário logado.
      • Cria o usuário 'Curso Fênix' (senha padrão definida abaixo) se não existir.
      • Copia todos os grupos locais do usuário logado para 'Curso Fênix'.

.NOTES
    Testado em Windows 10 21H2+ / Windows 11.
    Execute em PowerShell elevado (Run as administrator).
    Modifique a variável $PasswordPlain se quiser outra senha.
#>

# ======== CONFIGURÁVEL ========
$PasswordPlain = 'Fenix@123!'   # Altere para a senha desejada
# ==============================

# --- Verifica privilégios de administrador ---
if (-not ([Security.Principal.WindowsPrincipal] `
          [Security.Principal.WindowsIdentity]::GetCurrent() `
         ).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
    Write-Warning 'Execute este script como Administrador (Run as administrator).'
    Pause
    exit 1
}

$CurrentUser = $env:USERNAME
$NewUser     = 'Curso Fênix'
$Protected   = @('Administrator','DefaultAccount','Guest',$CurrentUser,$NewUser)

Write-Host "Usuário atual: $CurrentUser" -ForegroundColor Cyan

# --- Concede privilégio de Administrador ao usuário logado ---
Write-Host "`n[1/4] Adicionando $CurrentUser ao grupo Administrators..." -ForegroundColor Cyan
Try {
    Add-LocalGroupMember -Group 'Administrators' -Member $CurrentUser -ErrorAction Stop
    Write-Host "OK" -ForegroundColor Green
} Catch {
    Write-Host "Já é membro ou ocorreu erro: $_" -ForegroundColor Yellow
}

# --- Remove outros usuários locais habilitados ---
Write-Host "`n[2/4] Removendo contas locais não protegidas..." -ForegroundColor Cyan
Get-LocalUser |
  Where-Object { $_.Enabled -and ($Protected -notcontains $_.Name) } |
  ForEach-Object {
        Write-Host "  - Removendo '$($_.Name)'" -ForegroundColor Yellow
        Remove-LocalUser -Name $_.Name
  }

# --- Cria usuário 'Curso Fênix' se necessário ---
if (-not (Get-LocalUser -Name $NewUser -ErrorAction SilentlyContinue)) {
    Write-Host "`n[3/4] Criando conta '$NewUser'..." -ForegroundColor Cyan
    $SecPassword = ConvertTo-SecureString $PasswordPlain -AsPlainText -Force
    New-LocalUser -Name $NewUser -Password $SecPassword `
                  -FullName $NewUser -Description 'Conta criada pelo script' `
                  -PasswordNeverExpires | Out-Null
    Write-Host "Conta '$NewUser' criada com senha padrão." -ForegroundColor Green
} else {
    Write-Host "`n[3/4] Conta '$NewUser' já existe." -ForegroundColor Green
}

# --- Copia grupos do usuário logado para 'Curso Fênix' ---
Write-Host "`n[4/4] Replicando grupos locais..." -ForegroundColor Cyan
$CurrentGroups = (Get-LocalGroupMember -Member $CurrentUser |
                 Select-Object -ExpandProperty Group)

foreach ($grp in $CurrentGroups) {
    Try {
        Add-LocalGroupMember -Group $grp.Name -Member $NewUser -ErrorAction Stop
        Write-Host "  - Adicionado '$NewUser' ao grupo $($grp.Name)"
    } Catch {
        Write-Host "  - Já pertence ou erro em $($grp.Name): $_" -ForegroundColor Yellow
    }
}

Write-Host "`nTarefas concluídas com sucesso!" -ForegroundColor Green
Pause