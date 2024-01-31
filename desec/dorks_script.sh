#!/bin/bash
SEARCH="firefox"
TARGET="$1"
echo "Pesquisa no Pastebin"
$SEARCH "https://google.com/search?q=site:pastebin.com+$TARGET" 2> /dev/null
echo "Pesquisa no Trello"
$SEARCH "https://google.com/search?q=site:trello.com+$TARGET" 2> /dev/null
echo "Pesquisa por arquivos"
$SEARCH "https://google.com/search?q=$TARGET+ext:php+OR+ext:asp+OR+ext:txt" 2> /dev/null

