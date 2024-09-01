#!/usr/bin/python
from passlib.hash import yescript
import sys

senha = sys.argv[1]
if not senha:
    print("Esse script recebe uma senha e devolve um hash usando Yescript")
    print("Senha nao informada como argumento")
else:
    # Gerando hash Yescript
    hash_yescript = yescript.hash(senha)
    # Exibindo o hash em Yescript
    print(f'Hash Yescript:{hash_yescript}')
