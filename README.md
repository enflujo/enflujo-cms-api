# EnFlujo CMS + API

El administrador de contenidos para los diferentes sitios web del laboratorio.

Es un *headless CMS* en [Directus](https://directus.io/) independiente de las aplicaciones que construyen los sitios web. La idea es que el CMS sea un sitio único para administrar los contenidos, y que este exponga los datos por medio de un API. Usamos la nueva versión de Directus **>9** que esta hecha en NodeJS (antes era PHP).

:octocat: Este repositorio contiene la instancia de desarrollo del CMS pero cualquiera lo puede descargar, modificar y usarlo para otros proyectos.

:construction: Los desarrolladores de EnFlujo pueden hacer PR's para actualizar el CMS que usamos en producción. Las actualizaciones a este repositorio activan las acciones de despliegue en el servidor del laboratorio por medio de [Github Actions](https://docs.github.com/en/actions)

## Desarrollo

:heavy_exclamation_mark: Debe tener [Docker](https://docs.docker.com/get-docker/) instalado.

### Descargar repositorio

Debe descargar este repositorio en su computador. Desde el terminal, ir a la carpeta donde quiere descargar los archivos y desde allí clonar este repo:

```sh
git clone https://github.com/enflujo/sitios-cms-api.git
```

Entrar a la carpeta que acaba de clonar:

```sh
cd sitios-cms-api
```

### Iniciar contenedores Docker

Este es el comando que usamos cada ves que queremos iniciar la aplicación localmente:

```sh
# Si tiene problemas o quiere ver los "Logs" diretamente en el terminal,
# puede borrar -d del comando.
docker-compose up -d
```

El CMS queda disponible en: http://localhost:8055/

Las credenciales del usuario predeterminado son:

email: **admin@admin.com**

clave: **admin**

Para apagar los contenedores:

```sh
docker-compose down
```

La primera ves que iniciamos los contenedores se puede demorar mientras descarga las imágenes necesarias de Docker Hub. Luego de esa primera descarga, las imágenes quedan guardadas en su computador y el inicio es más rápido. *En este caso, imágenes se refiere a imágenes de Docker.*

Las imágenes que usa esta aplicación son (ver la configuración y versiones en `docker-compose.yaml`):

- [Directus](https://hub.docker.com/r/directus/directus) para el CMS.
- [Postgres](https://hub.docker.com/_/postgres) para la base de datos.
- [Redis](https://hub.docker.com/_/redis) para el cache.

### Persistencia de datos y archivos

En Docker, cada ves que apagamos los contenedores se pierden los datos, pero para facilitar el desarrollo vamos a tener una estructura básica de inicio y algunos assets que construyen el administrador con esta configuración inicial.

En la primera iniciada de los contenedores se van a crear unas carpetas dentro de `/sitios-cms-api` que estarán conectadas a los contenedores por medio de [Volumes](https://docs.docker.com/storage/volumes/). Que básicamente se encargan de crear un espejo entre los archivos dentro de los contenedores y unas carpetas locales. En el `docker-compose.yaml` esta conexión se ve así:

La lógica en Docker es primero la ruta local y luego la del contenedor

**local:contenedor**

```yaml
# Base de datos
# localmente en: ./data
# en el contenedor: /var/lib/postgresql/data
database:
  # ...
  volumes:
    - ./data:/var/lib/postgresql/data

# CMS
directus:
  # ...
  volumes:
    - ./uploads:/directus/uploads
    - ./extensions:/directus/extensions
```

Cuando iniciamos por primera vez los contenedores, el proceso se encarga de crear las carpetas locales (si no existen) y se ve algo así:

```md
/sitios-cms-api
  /data
  /extensions
  /uploads
```

Estas carpetas se pueden eliminar si se quiere crear una instancia de esta aplicación completamente desde cero.

## Desarrolladores de EnFlujo

La instancia básica que dejamos armada en este repositorio no va a reflejar exactamente la de producción pero tiene algunos datos y assets iniciales para trabajar sobre la misma base.

### Datos

La carpeta local `/data` tiene la copia de los datos del contenedor `postgres`. Esta carpeta es ignorada en este repositorio ya que contiene demasiados archivos que son innecesarios. Cada uno puede tener su propia versión de `sitios-cms-api/data/` que va a contener cualquier cambio que hagan dentro del CMS. Pueden borrar `sitios-cms-api/data/` en cualquier momento para volver al estado inicial.

Al crear los contenedores desde cero con `docker-compose up` se van a copiar unos datos iniciales desde el archivo `dump/datos.sql`. Estos contienen:

- Los registros de la configuración general que se hace en "Settings->Project Setting" dentro de Directus.
- Registros del uso que le damos a las imágenes que tenemos en `/uploads`.
- Estructura de los datos: registros, entradas con información general, etc.

El archivo `dump/datos.sql` se debe crear de nuevo cuando cambiamos alguna imagen o se modifica la estructura de los datos. De esta manera los otros desarrolladores pueden reiniciar sus contenedores y tener la base con la nueva estructura.

Para crear un nuevo **dump**, ir en el terminal a esta carpeta y ejecutar el siguiente comando:

```sh
docker exec -t enflujo-cms-database pg_dump -U enflujo --clean --column-inserts --if-exists --on-conflict-do-nothing > ./dump/datos.sql
```

### Extensiones

La carpeta local `/extensions` la usamos para modificar los usos predeterminados de Directus. Estos pueden ser al panel de administrador o al API (crear nuevos *endpoints* o *hooks*, por ejemplo). Ver documentación de [extensiones en Directus](https://docs.directus.io/concepts/extensions/). 

Los cambios en este directorio si se van a ver reflejados en producción. Para hacer cambios en las extensiones, crear un branch para cada implementación y crear PR cuando se quieran proponer a revisión.

### Archivos

La carpeta `/uploads` la vamos a incluir en el repositorio pero sólo se deben incluir archivos globales del administrador que se modifican desde el CMS en "Settings->Project Setting":

- **Project Logo**: Para el icono de 40 x 40 en SVG.
- **Public Foreground**: El logo grande que se muestra en la página de inicio del CMS.
- **Public Background**: La imagen de fondo en la página de inicio al CMS.

Si se cambia alguno de estos elementos, se deben borrar los viejos desde "File Library" en Directus.

El proceso debe ser así: 

1. Entrar como administrador a Directus.
2. Cambiar la imagen en "Settings->Project Setting".
3. Borrar la imagen que se reemplazó desde "File Library".

Estos cambios sólo se verán reflejados en esta versión del CMS de desarrollo y no en la de producción. Lo hacemos sólo para tener una versión personalizada en el espacio de desarrollo. Para cambiar la de producción, se deben repetir estos pasos en el administrador público.

## TODO

- Usar Switches para ignorar algunas tablas durante el dump. https://stackoverflow.com/questions/40642359/ignoring-a-table-in-pg-dump-and-restore