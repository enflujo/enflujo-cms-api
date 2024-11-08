#!/bin/bash
# crearRespaldo.sh

# Install Environment file
source .env 

# Backup MongoDB
/usr/bin/docker exec -t enflujo-cms-bd pg_dump \
  -U $BD_USUARIO $BD_NOMBRE_BD \
  > ./dump/enflujobd.sql
