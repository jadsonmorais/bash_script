#!/bin/bash
#
# Script para buscar metadados usando google hacking
#
# ##################################################
#	MODO DE USO
# ##################################################
# Passar um dominio e uma extensão.
# Extensoes disponiveis: pdf, docx, doc, xls, xlsx, ppt, pptx
#
# ./metainf.sh businesscorp.com.br pdf
#
# 
# ##################################################
#	CODIGO
# ##################################################
#
# Criando variaveis
#
DOMINIO="$1"
EXT="$2"

# Criando a funcao que verifica as variaveis
verificaVariaveis(){
	# Recebebdo os argumentos
	if [ -z "$1" ] || [ -z "$2" ]; then
		return 1;
	else
		return 0;
	fi
}

fazerPesquisa() {
	# Recebendo os argumentos
	local DOMINIO=$1
	local EXT=$2
	local DIRNAME=$(echo $DOMINIO | cut -d "." -f 1)
	
	
	# Realizando a busca com lynx
	lynx --dump "https://google.com/search?&q=site:$DOMINIO+ext:$EXT" \
		| egrep "\.$EXT" | cut -d "=" -f 2 | sed s/"...$"// > temp
	
	if [ -s "./temp" ];then
		# Criando a pasta onde serao baixados os arquivos
		if ! [ -e "./$DIRNAME" ];then
			mkdir "$DIRNAME"
		fi
		while IFS="" read -r link; do
			echo "##### Arquivo: $link #####"
			wget -P "./$DIRNAME/" -q $link
			
		done < "./temp"
		exiftool ./$DIRNAME/*.$EXT
	else
		echo A pesquisa não retornou resultados.
	fi

}

if verificaVariaveis "$DOMINIO" "$EXT"; then
    fazerPesquisa "$DOMINIO" "$EXT"
else
    cat readme 
fi
