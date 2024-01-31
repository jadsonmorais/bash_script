
#!/usr/bin/env bash
# ------------------------------------------------------------------------ #
#  Este programa irá contar de 1 a 100
#
#  Exemplos:
#      $ ./task.sh
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 03/10/2018, Jadson:
#       - Início do programa
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 5.0.17
# ------------------------------------------------------------------------ #

#Variáveis
comeca=0 ate=100;
#Testes
[ $comeca -ge $ate ] && exit 1
#Funções
for i in $(seq $comeca $ate);do
  for j in $(seq $i $ate);do
    printf "*";
  done;
  printf "\n";
done
