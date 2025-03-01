name: Backup PostgreSQL

on:
  schedule:
    - cron: '0 0 * * 1'  # Toda segunda-feira às 00:00 UTC
  workflow_dispatch:       # Permite execução manual

jobs:
  backup:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout do código
        uses: actions/checkout@v4

      - name: Configurar ambiente
        run: |
          sudo apt-get update
          sudo apt-get install -y postgresql-client rclone

      - name: Configurar Rclone
        env:
          RCLONE_CONFIG: ${{ secrets.RCLONE_CONFIG }}
        run: |
          mkdir -p ~/.config/rclone
          echo "$RCLONE_CONFIG" > ~/.config/rclone/rclone.conf

      - name: Executar Backup
        env:
          PG_HOST: dpg-cugf0can91rc73d68lmg-a.oregon-postgres.render.com
          PG_DATABASE: greenmakerlab
          PG_USER: greenmakerlab_user
          PG_PASSWORD: ${{ secrets.DB_PASSWORD }}
        run: |
          # Nome do arquivo de backup
          BACKUP_FILE="backup_$(date +'%Y-%m-%d_%H-%M-%S').dump"
          
          # Exportar o banco
          pg_dump -Fc -h $PG_HOST -U $PG_USER -d $PG_DATABASE -f $BACKUP_FILE

          # Compactar
          tar -czvf "$BACKUP_FILE.tar.gz" "$BACKUP_FILE"

          # Enviar para o Google Drive
          rclone copy "$BACKUP_FILE.tar.gz" gdrive:Backups

          # Limpar arquivos locais
          rm -rf "$BACKUP_FILE"*