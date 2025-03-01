FROM ubuntu:latest

# Instalar dependências
RUN apt-get update && apt-get install -y \
    postgresql-client \
    curl \
    tar \
    && curl https://rclone.org/install.sh | bash

# Copiar configuração do Rclone
COPY rclone.conf /root/.config/rclone/rclone.conf

# Copiar script de backup
COPY backup.sh /backup.sh

# Dar permissão de execução
RUN chmod +x /backup.sh

# Comando para executar o backup
CMD ["/backup.sh"]