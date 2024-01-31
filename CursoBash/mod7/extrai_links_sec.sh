#!/usr/bin/env bash
#
# extrai_links_sec.sh - Extrai links de relatórios de segurança do site CisoAdvisor
#
# Site:       https://github.com/jadsonmorais
# Autor:      Jadson Morais
# Manutenção: Jadson Morais
#
# ------------------------------------------------------------------------ #
#  Extrai links de relatórios de segurança do site CisoAdvisor
#
#  Exemplos:
#      $ extrai_links_sec.sh
#      
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 13/02/2022, Jadson:
#       - Início do programa
#       - Conta com a funcionalidade de buscar links da página de relatórios do site Ciso Advisor
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 5.1.8
# ------------------------------------------------------------------------ #

# ------------------------------- VARIÁVEIS ----------------------------------------- #
ROXO="\033[35;1m"
CIANO="\033[36;1m"
VERDE="\033[32;1m"
AMARELO="\033[33;1m"

MENSAGEM_USO="
  $(basename $0) - [OPÇÕES]

      -h - Menu de ajuda
      -v - Versão do programa
      -l [0-9] - Abre o link escolhido usando o navegador padrao
"
VERSAO="v1.0"

TITLE="title.txt"
LINKS="links.txt"
PEDE_LINK=0

# ------------------------------------------------------------------------ #

# ------------------------------- TESTES ----------------------------------------- #
[ ! -x "$(which lynx)" ] && sudo apt install lynx -y # Lynx Instalado?
# ------------------------------------------------------------------------ #

# ------------------------------- FUNÇÕES ----------------------------------------- #
Get_links(){
    lynx -source https://www.cisoadvisor.com.br/branded-posts/ \
    | egrep "^....[A-Z].*</a>$" \
    | sed 's/<\/a>$//g' > title.txt
}

Get_title(){
    lynx -source https://www.cisoadvisor.com.br/branded-posts/ \
    | egrep "<a href=.https://www.cisoadvisor.com.br/branded-posts/" \
    | sed 's/...<a href=\"//;s/\" >//' > links.txt
}

# ------------------------------------------------------------------------ #

# ------------------------------- EXECUÇÃO ----------------------------------------- #
Get_links
Get_title

while test -n "$1"
do
    case "$1" in
        -h) echo "$MENSAGEM_USO" && exit 0      ;;
        -v) echo "$VERSAO" && exit 0            ;;
        -l) PEDE_LINK=1                         ;;
        -*) echo "Opção inválida, consulte: -h" ;;
    esac
    shift
done

contador=0
while read -r title
    do
        contador=$(($contador+1))
        echo -e "${ROXO}Título $contador: ${CIANO}$title"
    done < "$TITLE" 
if [ $PEDE_LINK -eq 1 ] 
then
    echo -e "${AMARELO}# ------------------------------------------------------------------------ #"
    contador=0
    while read -r links
    do
        contador=$(($contador+1))
        echo -e "${AMARELO}Link $contador: ${VERDE}$links"
    done < "$LINKS"
fi
# ------------------------------------------------------------------------ #
