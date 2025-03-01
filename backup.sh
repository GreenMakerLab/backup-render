#!/bin/bash
# Configurações do banco (via variáveis de ambiente)
PG_HOST="$DB_HOST"
PG_DATABASE="$DB_NAME"
PG_USER="$DB_USER"
PG_PASSWORD="$DB_PASSWORD"

# Configurações do backup
DATA=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_DIR="./backups"
BACKUP_FILE="$BACKUP_DIR/backup_$DATA.dump"

# Criar diretório de backups
mkdir -p $BACKUP_DIR

# Exportar o banco
PGPASSWORD=$PG_PASSWORD pg_dump -h $PG_HOST -U $PG_USER -d $PG_DATABASE -Fc -f $BACKUP_FILE

# Compactar o backup
tar -czvf "$BACKUP_FILE.tar.gz" $BACKUP_FILE

# Enviar para o Google Drive
rclone copy "$BACKUP_FILE.tar.gz" gdrive:Backups --log-file=backup_log.txt --log-level INFO

# Limpar arquivos locais
rm -rf $BACKUP_FILE*