#!/bin/bash

# -------------------------------
# Autor: Jadson Morias
# Data: 24/02/2024 
# Versão: 1.0
# Descrição: Script para varrer uma wordlist, fazendo brute force em requisições curl e substituindo .
# -------------------------------
# Functions
# -------------------------------
usage() {
    echo "Uso: $0 <caminho_para_wordlist>"
    echo "Exemplo: $0 /caminho/para/wordlist.txt"
    exit 1
}

log() {
    echo "[$(date +"%Y-%m-%d %H:%M:%S")] $@" | tee -a "$LOG_FILE"
}

check_dependencies() {
    # Verifica se o comando curl está instalado
    if ! command -v curl &> /dev/null; then
        log "Erro: curl não está instalado."
        exit 1
    fi
}

# Configurações Iniciais
#set -euo pipefail # Modo seguro. Saia em caso de erro.
IFS=$'\n\t'

# Tratamento de Argumentos
if [ $# -ne 1 ]; then
    echo "Erro: Este script requer exatamente um argumento." >&2
    usage
fi

# Variáveis Globais
readonly SCRIPT_DIR=$(dirname "$(realpath "$0")")
readonly LOG_FILE="$SCRIPT_DIR/explore.log"
readonly WORDLIST_FILE="$SCRIPT_DIR/$1" # O primeiro argumento do script deve ser o caminho para a wordlist



# Tratamento de Argumentos
if [ $# -ne 1 || $# -ne 2]; then
    usage
fi

if [ ! -f "$WORDLIST_FILE" ]; then
    log "Erro: Arquivo de wordlist não encontrado."
    exit 1
fi

# Lógica Principal
main() {
    log "Iniciando script..."
    
    #check_dependencies
    
    while IFS= read -r line; do
        local url="businesscorp.com.br/${line}"
        local status_code=$(curl -s -o /dev/null -w "%{http_code}" "$url")
        
        log "URL: $url - Status Code: $status_code" | egrep "200"
    done < "$WORDLIST_FILE"
    
    log "Script concluído."
}

# Executa o script
main "$@"
