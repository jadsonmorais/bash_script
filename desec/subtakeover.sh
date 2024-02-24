#!/usr/bin/env bash
#
# Script para fazer pesquisa direta por dominio
#
# Autor:      Jadson Morais
# Manutenção: Jadson Morais
#
# ------------------------------------------------------------------------ #
#  Exemplos:
#      $ ./dnsrecon.sh businesscorp.com.br
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 13/02/2024, Jadson:
#       - Início do programa
#       - Conta com as funcionalidades:
#			- Fazer brute force num determinado dominio buscando
#			  por registros CNAME
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 5.2.21
# ------------------------------------------------------------------------ #

# ------------------------------- VARIÁVEIS ----------------------------------------- #
MENSAGEM_USO="
  $0 - [OPÇÕES]

  -h - Menu de ajuda
  -v - Versão
  -d - Passar o dominio
"
VERSAO="v1.0"
TARGET= 
# ------------------------------------------------------------------------ #

# ------------------------------- TESTES ----------------------------------------- #

# ------------------------------------------------------------------------ #

# ------------------------------- FUNÇÕES ----------------------------------------- 

# ------------------------------------------------------------------------ #

# ------------------------------- EXECUÇÃO ----------------------------------------- #
while test -n "$1"
do
	case "$1" in
		-h) echo "$MENSAGEM_USO" && exit 0						;;
		-v) echo "$VERSAO" && exit 0							;;
		-d) TARGET="$2" && shift								;;
		 *) echo "Invalid Option, try to -h option." && exit 1	;;
	esac
	shift
done
if [ -z "$TARGET" ]
then
	echo "O dominio alvo e obrigatorio. Use a opcao -d para definir."
	echo "$MENSAGEM_USO"
	exit 1
fi

for word in $(cat /etc/theHarvester/wordlists/names_small.txt); do 
	host -t cname $word.$TARGET
done | grep "alias for"

# ------------------------------------------------------------------------ #


