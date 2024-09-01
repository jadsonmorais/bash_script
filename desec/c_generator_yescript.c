#include <stdio.h>
#include <string.h>
#include <crypt.h>

int main() {
    const char *password = "513016";
    const char *salt = "$y$j9T$l2FADozMAN0EKzqpowC.H1$"; // Exemplo de salt para Yescrypt

    // Gerar o hash Yescrypt
    char *hash = crypt(password, salt);

    if (hash) {
        printf("Hash Yescrypt: %s\n", hash);
    } else {
        fprintf(stderr, "Erro ao gerar o hash.\n");
    }

    return 0;
}
