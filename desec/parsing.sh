 #!/bin/bash
if [ "$1" == "" ]
then
    echo -e "${VERMELHO}${BOLD}#################    ATENCAO    #####################${ENDC}";
    echo -e "Modo de usar: \n\n$0 HOST";
else 
    echo -e "${AMARELO}######################################################${ENDC}";
    echo -e "${AMARELO} - >             BUSCANDO HOSTS                   < - ${ENDC}";
    echo -e "${AMARELO}######################################################${ENDC}";
    rm -rf index.html 1> /dev/null;
    wget -q $1;
    cat index.html | grep 'href="h' | cut -d "/" -f 3 | grep "\." | cut -d '"' -f 1 > lista;
    cat lista | egrep -i "^[[:alpha:]]";
    echo -e "${AMARELO}######################################################${ENDC}";
    echo -e "${AMARELO} - >           RESOLVENDO HOSTS                   < - ${ENDC}";
    echo -e "${AMARELO}######################################################${ENDC}";
    for ip in $(cat lista | egrep "^[[:alpha:]]"); do host $ip; done | egrep -i "has address";
fi
