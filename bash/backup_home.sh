#!/bin/bash

SOURCE="$HOME"
BACKUP_DIR="$HOME/backups"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

mkdir -p "$BACKUP_DIR"

tar -czf "$BACKUP_DIR/home_backup_$TIMESTAMP.tar.gz" "$SOURCE"

echo "Backup completed: home_backup_$TIMESTAMP.tar.gz"
