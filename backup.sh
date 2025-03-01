#!/bin/bash
# Configurações do banco
PG_HOST="dpg-cugf0can91rc73d68lmg-a.oregon-postgres.render.com"
PG_DATABASE="greenmakerlab"
PG_USER="greenmakerlab_user"
PG_PASSWORD="vpOEv1FoHD2eKTFCxUb04VhrPyDWX7pb"

# Configurações do backup
DATA=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_DIR="./backups"
BACKUP_FILE="$BACKUP_DIR/backup_$DATA.dump"

# Criar diretório de backups
mkdir -p "$BACKUP_DIR"

# Exportar o banco
PGPASSWORD=$PG_PASSWORD pg_dump -Fc -h $PG_HOST -U $PG_USER -d $PG_DATABASE -f "$BACKUP_FILE"

# Compactar e enviar para o Google Drive
if [ -f "$BACKUP_FILE" ]; then
    tar -czvf "$BACKUP_FILE.tar.gz" "$BACKUP_FILE"
    rclone copy "$BACKUP_FILE.tar.gz" gdrive:Backups --log-file=backup_log.txt --log-level INFO
    rm -rf "$BACKUP_FILE"*
else
    echo "Falha ao criar o backup!"
    exit 1
fi