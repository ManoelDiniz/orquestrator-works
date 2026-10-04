# Uso (na raiz do projeto): <caminho>\cursor\instalar.ps1
# Copia regras e comandos para .cursor/ e cria .cursorignore se não existir.
$origem = Split-Path -Parent $MyInvocation.MyCommand.Path
New-Item -ItemType Directory -Force .cursor | Out-Null
Copy-Item -Recurse -Force "$origem\rules" .cursor\
Copy-Item -Recurse -Force "$origem\commands" .cursor\
if (-not (Test-Path .cursorignore)) { Copy-Item "$origem\modelos\cursorignore" .cursorignore }
Write-Host "Pronto. Abra o Cursor nesta pasta e rode /equipe."
