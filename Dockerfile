FROM ubuntu:latest

# Instalar dependências
RUN apt-get update && apt-get install -y \
    postgresql-client \
    curl \
    tar \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Instalar o Rclone
RUN curl https://rclone.org/install.sh | bash

# Copiar configuração do Rclone
COPY rclone.conf /root/.config/rclone/rclone.conf

# Copiar script de backup
COPY backup.sh /backup.sh

# Dar permissão de execução
RUN chmod +x /backup.sh

# Comando para manter o container ativo (sem abrir portas)
CMD tail -f /dev/null