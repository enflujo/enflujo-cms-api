#!/bin/bash
# crearDumpInicial.sh

set -euo pipefail

source .env

mkdir -p ./dump

ARCHIVO="./dump/datos.sql"

cleanup() {
  local exit_code=$?
  if [ $exit_code -ne 0 ]; then
    rm -f "${ARCHIVO}"
    echo "❌ Error al crear dump inicial"
  fi
  exit $exit_code
}

trap cleanup EXIT

OTROS_SQL=$(find ./dump -maxdepth 1 -type f -name '*.sql' ! -name 'datos.sql' -print)
if [ -n "${OTROS_SQL}" ]; then
  echo "⚠️ Hay otros archivos .sql en ./dump."
  echo "⚠️ Docker intentará ejecutar todos al iniciar una base vacía:"
  echo "${OTROS_SQL}"
fi

/usr/bin/docker exec -i enflujo-cms-bd pg_dump \
  -U "${BD_USUARIO}" \
  --no-owner \
  --clean \
  --if-exists \
  --column-inserts \
  --on-conflict-do-nothing \
  "${BD_NOMBRE_BD}" > "${ARCHIVO}"

trap - EXIT
echo "✅ Dump inicial creado: ${ARCHIVO}"
