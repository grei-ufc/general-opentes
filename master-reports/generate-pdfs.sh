#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

usage() {
  cat <<'EOF'
Uso:
  ./generate-pdfs.sh                # gera PDF para todos os .md em master-reports/
  ./generate-pdfs.sh arquivo.md     # gera PDF apenas para um arquivo
  ./generate-pdfs.sh a.md b.md      # gera PDF para arquivos específicos

Requisitos:
  - pandoc
  - xelatex
  - fonte "EB Garamond" instalada no sistema
EOF
}

require_command() {
  local cmd="$1"
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "Erro: comando obrigatório não encontrado: $cmd" >&2
    exit 1
  fi
}

require_command pandoc
require_command xelatex

if ! fc-match "EB Garamond" >/dev/null 2>&1; then
  echo 'Erro: a fonte "EB Garamond" não está instalada no sistema.' >&2
  exit 1
fi

declare -a inputs=()

if [[ $# -eq 0 ]]; then
  while IFS= read -r -d '' file; do
    inputs+=("$file")
  done < <(find "$SCRIPT_DIR" -maxdepth 1 -type f -name '*.md' -print0 | sort -z)
else
  for arg in "$@"; do
    case "$arg" in
      -h|--help)
        usage
        exit 0
        ;;
    esac

    if [[ "$arg" = /* ]]; then
      input="$arg"
    else
      input="$SCRIPT_DIR/$arg"
    fi

    if [[ ! -f "$input" ]]; then
      echo "Erro: arquivo não encontrado: $arg" >&2
      exit 1
    fi

    if [[ "${input##*.}" != "md" ]]; then
      echo "Erro: o arquivo deve estar em Markdown (.md): $arg" >&2
      exit 1
    fi

    inputs+=("$input")
  done
fi

if [[ ${#inputs[@]} -eq 0 ]]; then
  echo "Nenhum arquivo Markdown encontrado em $SCRIPT_DIR." >&2
  exit 1
fi

for input in "${inputs[@]}"; do
  output="${input%.md}.pdf"
  echo "Gerando $(basename "$output")..."
  pandoc "$input" --pdf-engine=xelatex -o "$output"
done

echo "Concluído: ${#inputs[@]} PDF(s) gerado(s) em $SCRIPT_DIR."
