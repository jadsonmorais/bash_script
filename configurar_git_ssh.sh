#!/bin/bash

# Script para configurar a autenticação SSH do Git

# Solicita ao usuário o e-mail associado à chave SSH
read -p "Digite o e-mail associado à sua chave SSH: " email

# Caminho padrão onde a chave SSH é armazenada
SSH_KEY_PATH="$HOME/.ssh/id_rsa"

# Verifica se a chave SSH existe
if [ ! -f "$SSH_KEY_PATH" ]; then
    echo "A chave SSH não foi encontrada em $SSH_KEY_PATH."
    echo "Por favor, gere uma chave SSH usando 'ssh-keygen' antes de executar este script."
    exit 1
fi

# Ajusta as permissões da chave SSH
chmod 600 "$SSH_KEY_PATH"

# Configura o Git para usar a chave SSH especificada
echo "Configurando o Git para usar a chave SSH..."
git config --global user.email "$email"

# Inicia o ssh-agent e adiciona a chave SSH
eval "$(ssh-agent -s)"
ssh-add "$SSH_KEY_PATH"

echo "Configuração do Git e SSH concluída com sucesso."
