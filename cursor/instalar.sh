#!/bin/sh
# Uso (na raiz do projeto): sh <caminho>/cursor/instalar.sh
# Copia regras e comandos para .cursor/ e cria .cursorignore se não existir.
origem=$(cd "$(dirname "$0")" && pwd)
mkdir -p .cursor
cp -r "$origem/rules" "$origem/commands" .cursor/
[ -f .cursorignore ] || cp "$origem/modelos/cursorignore" .cursorignore
echo "Pronto. Abra o Cursor nesta pasta e rode /equipe."
