#!/bin/bash
# crearRespaldo.sh

set -euo pipefail

# Cargar variables del entorno
source .env

# Crear carpeta respaldos si no existe (separada de dump para no interferir con docker-entrypoint-initdb.d)
mkdir -p ./respaldos

# Fecha y hora actual
FECHA=$(date +"%Y-%m-%d_%H-%M-%S")

# Ruta del respaldo
ARCHIVO="./respaldos/enflujobd_${FECHA}.sql.gz"

cleanup() {
  local exit_code=$?
  if [ $exit_code -ne 0 ]; then
    rm -f "${ARCHIVO}"
    echo "❌ Error al crear respaldo"
  fi
  exit $exit_code
}

trap cleanup EXIT

# Comando de respaldo comprimido con gzip
/usr/bin/docker exec -i enflujo-cms-bd pg_dump \
  -U "${BD_USUARIO}" \
  --no-owner \
  --clean \
  "${BD_NOMBRE_BD}" \
  | gzip > "${ARCHIVO}"

trap - EXIT
echo "✅ Respaldo creado: ${ARCHIVO}"
