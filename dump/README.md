# Dump

Poner acá solo el archivo `datos.sql` que se quiere correr al iniciar el contenedor por primera vez.

Docker ejecuta todos los archivos `.sql` de esta carpeta cuando crea una base vacía, así que no conviene mezclar dumps viejos, respaldos manuales o variantes incompatibles.

Para regenerarlo desde la raíz del proyecto:

```bash
./crearDumpInicial.sh
```
