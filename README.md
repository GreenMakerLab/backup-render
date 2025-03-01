# Backup Automático

Este repositório contém um workflow do GitHub Actions para fazer backup de um banco de dados PostgreSQL e enviá-lo para o Google Drive.

## Como Funciona
- O backup é executado automaticamente toda segunda-feira às 00:00 UTC.
- O script usa `pg_dump` para exportar o banco e `rclone` para enviar o backup ao Google Drive.