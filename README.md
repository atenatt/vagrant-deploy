# Provisionamento de VM com Vagrant e Shell Script

Este repositório contém a configuração de um ambiente de desenvolvimento utilizando Vagrant e um script de provisionamento em Shell. A VM configurada utiliza Ubuntu Trusty64 e está preparada para servir uma aplicação web com o servidor Apache.

## Estrutura do Repositório

- **Vagrantfile**: Arquivo de configuração do Vagrant que define a VM e especifica o script de provisionamento.
- **provision.sh**: Script em Shell responsável por configurar a VM, instalar dependências e configurar o servidor web.

## Vagrantfile

O `Vagrantfile` está configurado para:

- Definir a VM com o nome "srv-dev".
- Utilizar a box `ubuntu/trusty64` na versão `20191107.0.0`.
- Mapear a porta 80 da VM para a porta 8001 no host, acessível através do `localhost`.
- Executar o script de provisionamento `provision.sh` durante o processo de inicialização.

## provision.sh

O script de provisionamento realiza as seguintes ações:

1. **Atualização do Sistema**: Atualiza a lista de pacotes do sistema.
2. **Criação do Diretório de Logs**: Verifica se o diretório de logs existe, caso contrário, tenta criá-lo.
3. **Instalação do Servidor Web (Apache)**: Instala o servidor Apache.
4. **Instalação do Git**: Instala o Git.
5. **Clonagem do Repositório Remoto**: Clona o repositório especificado e copia seu conteúdo para a pasta web do Apache.
6. **Inicialização do Servidor Web**: Inicia o serviço do Apache.
7. **Mensagem de Conclusão**: Exibe uma mensagem de conclusão e informações de acesso ao serviço web.

## Utilização

Para utilizar este repositório, siga os seguintes passos:

1. **Clone o repositório**:
    ```sh
    git clone https://github.com/atenatt/vagrant-deploy.git
    cd vagrant-deploy
    ```

2. **Inicie o Vagrant**:
    ```sh
    vagrant up
    ```

3. **Acesse o serviço web**:
    Abra seu navegador e acesse `http://localhost:8001`.

## Observações

- Certifique-se de ter o Vagrant e o VirtualBox instalados em sua máquina antes de iniciar o processo.
- Verifique os logs de provisionamento em `logs/provision.log` para mais detalhes sobre a execução do script.

---
