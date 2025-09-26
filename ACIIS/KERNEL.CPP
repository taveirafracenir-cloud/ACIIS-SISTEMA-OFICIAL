#include <iostream>
#include <string>

void mostrar_prompt() {
    std::cout << "\nACCIIS > ";
}

int main() {
    std::string comando;
    std::cout << "ACCIIS Sistema Oficial v1.0" << std::endl;
    std::cout << "-----------------------------------" << std::endl;

    while (true) {
        mostrar_prompt();
        std::getline(std::cin, comando);

        if (comando == "foto") {
            // Em breve, o codigo para tirar fotos vai aqui.
            std::cout << "Iniciando modulo de fotografia..." << std::endl;
        } else if (comando == "conversa") {
            // Em breve, o codigo do aplicativo de conversa vai aqui.
            std::cout << "Iniciando modulo de conversa..." << std::endl;
        } else if (comando == "sair") {
            std::cout << "Desligando o sistema..." << std::endl;
            break;
        } else {
            std::cout << "Comando '" << comando << "' nao reconhecido." << std::endl;
        }
    }

    return 0;
}
