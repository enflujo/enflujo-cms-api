#!/bin/bash
# crearRespaldo.sh

# Cargar variables del entorno
source .env

# Crear carpeta respaldos si no existe (separada de dump para no interferir con docker-entrypoint-initdb.d)
mkdir -p ./respaldos

# Fecha y hora actual
FECHA=$(date +"%Y-%m-%d_%H-%M-%S")

# Ruta del respaldo
ARCHIVO="./respaldos/enflujobd_${FECHA}.sql.gz"

# Comando de respaldo comprimido con gzip
/usr/bin/docker exec -t enflujo-cms-bd pg_dump \
  -U "${BD_USUARIO}" \
  --no-owner \
  --clean \
  "${BD_NOMBRE_BD}" \
  | gzip > "${ARCHIVO}"

# Verificación
if [ $? -eq 0 ]; then
  echo "✅ Respaldo creado: ${ARCHIVO}"
else
  echo "❌ Error al crear respaldo"
  exit 1
fi
