#!/bin/bash

set -euo pipefail

script_dir="$(cd "$(dirname "$0")" && pwd)"
repo_dir="$(cd "$script_dir/.." && pwd)"

cd "$repo_dir"

if [[ "$(git branch --show-current)" != "main" ]]; then
  printf 'Erro: troque para a branch main antes de atualizar.\n'
  exit 1
fi

if ! git diff --quiet || ! git diff --cached --quiet; then
  printf 'Erro: existem alterações locais ainda não salvas em um commit.\n'
  printf 'Faça commit ou guarde essas alterações antes de continuar.\n'
  exit 1
fi

if ! git remote get-url upstream >/dev/null 2>&1; then
  printf 'Erro: o remote upstream não está configurado.\n'
  printf 'Execute: git remote add upstream https://github.com/laobamac/itlwm.git\n'
  exit 1
fi

if ! git remote get-url origin >/dev/null 2>&1; then
  printf 'Erro: o remote origin não está configurado.\n'
  exit 1
fi

printf 'Buscando atualizações do projeto original...\n'
git fetch upstream

printf 'Atualizando a branch main local...\n'
git merge --no-edit upstream/main

printf 'Enviando a branch main atualizada para o seu fork...\n'
git push origin main

printf '\nAtualização concluída com sucesso.\n'