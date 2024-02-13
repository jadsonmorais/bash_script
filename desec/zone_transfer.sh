#!/usr/bin/env bash
#
# cotarBitcoin.sh - Verifica a última cotação do Bitcoin
#
# Autor:      Jadson Morais
# Manutenção: Jadson Morais
#
# ------------------------------------------------------------------------ #
#  O programa irá buscar dado um determinado alvo, buscar informações de infra
#  com a tecnica de transferencia de zona
#
#  Exemplos:
#      $ ./zone_transfer.sh businesscorp.com.br
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 13/02/2024, Jadson:
#       - Início do programa
#       - Conta com as funcionalidades:
#			- Consultar servidores NS do alvo
#			- Tentar fazer a transferência de zona em cada servidor NS
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
	exit 1
fi

for server in $(host -t ns $TARGET | cut -d " " -f4); do 
	host -l -a $TARGET $server
done

# ------------------------------------------------------------------------ #

