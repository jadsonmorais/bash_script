#!/usr/bin/env bash
#
# Script para fazer pesquisa direta por dominio
#
# Autor:      Jadson Morais
# Manutenção: Jadson Morais
#
# ------------------------------------------------------------------------ #
#  Exemplos:
#      $ ./webrecon.sh businesscorp.com.br
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 13/02/2024, Jadson:
#       - Início do programa
#       - Conta com as funcionalidades:
#			- Fazer brute force de arquivos e pastas em um dominio 
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 5.2.21
# ------------------------------------------------------------------------ #
[ -f toilet ] && echo "Instalando toilet" && (sudo apt update && sudo apt install toilet -y)  

# ------------------------------- VARIÁVEIS ----------------------------------------- #
MENSAGEM_USO="
$(toilet -f pagga "_______________")
$(toilet -f future "Security - WEB RECON")
$(toilet -f pagga "_______________")

  $0 - [OPÇÕES]

  -h - Menu de ajuda
  -v - Versão
  -d - Passar o dominio
  -w - Passar wordlist
  -e - Passar a extensão
"
VERSAO="v1.0"
TARGET=
EXT=
WORDLIST=

# Atribuindo variaveis
while test -n "$1"
do
	case "$1" in
		-h) echo "$MENSAGEM_USO" && exit 0						;;
		-v) echo "$VERSAO" && exit 0							;;
		-d) TARGET="$2" && shift								;;
		-e) EXT="$2" && shift									;;
		-w) WORDLIST="$2" && shift								;;
		 *) echo "Invalid Option, try to -h option." && exit 1	;;
	esac
	shift
done
# ------------------------------------------------------------------------ #
# ------------------------------- TESTES ----------------------------------------- #
if [ -z "$TARGET" ] || [ -z "$WORDLIST" ]; then
		echo "O dominio alvo e wordlist sao obrigatorios."
		echo "$MENSAGEM_USO"
		exit 1
fi
[ ! -e "$WORDLIST" ] && echo "Arquivo wordlist nao existe." && exit 1
# ------------------------------------------------------------------------ #

# ------------------------------- FUNÇÕES ----------------------------------------- 

# ------------------------------------------------------------------------ #

# ------------------------------- EXECUÇÃO ----------------------------------------- #
toilet -f pagga "_______________"
toilet -f future "Security - WEB RECON"  
toilet -f pagga "_______________"
echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - " 
toilet -f wideterm "# Buscando por arquivos e diretorios"
echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - " 

for word in $(cat $WORDLIST); do
	URL="$TARGET/$word"	
	STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$URL")
	STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$URL")
	echo "URL: $URL - Status Code: $STATUS_CODE" | egrep -v "404"
done

if [ ! -z "$EXT" ]
then
	
	echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - " 
	toilet -f wideterm "# Buscando por arquivos com a extensao"
	echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - " 
	for word in $(cat $WORDLIST); do 
		URL="$TARGET/$word.$EXT"
        STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$URL")
        echo "URL: $URL - Status Code: $STATUS_CODE" | egrep -v "404"  
	done
fi
# ------------------------------------------------------------------------ #
