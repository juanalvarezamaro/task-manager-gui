# TASK-002: Visualización completa de todos los proyectos

- **Proyecto:** task-manager-gui
- **Prioridad:** alta
- **Creado:** 2026-03-17
- **Regenerado:** 2026-03-17 (specs perdidas, regeneradas por Jimmy)
- **Repo:** https://github.com/juanalvarezamaro/task-manager-gui

## Petición original
Juan detectó que la interfaz no muestra correctamente todos los proyectos existentes en `~/task-manager/`. La app debe escanear y mostrar TODOS los proyectos de forma dinámica, no solo los que se conozcan de antemano.

## Especificaciones funcionales (Jimmy)

### 1. Escaneo dinámico de proyectos
- El sistema debe escanear `~/task-manager/` y mostrar **todos** los directorios de proyecto existentes (actualmente `hello-world` y `task-manager-gui`, pero podrían crearse más en cualquier momento).
- Un directorio es un proyecto si es una carpeta directa bajo `~/task-manager/` y contiene al menos una subcarpeta de pipeline (`1-specs`, `2-architecture`, `3-development`, `4-qa`, `5-deployment`, `done`, o `blocked`).

### 2. Vista principal — Listado de proyectos
- En la pantalla principal, mostrar una lista/grid con **todos los proyectos detectados**.
- Para cada proyecto, mostrar:
  - Nombre del proyecto (derivado del nombre de la carpeta)
  - Número total de tareas
  - Resumen de tareas por estado (ej: "2 en desarrollo, 1 en QA, 3 done")
- Permitir hacer clic en un proyecto para ver su tablero Kanban completo.

### 3. Tablero Kanban por proyecto
- Al entrar a un proyecto, mostrar el tablero Kanban con columnas correspondientes a las carpetas del pipeline.
- Las tareas deben aparecer en la columna correcta según su ubicación en el sistema de archivos.
- Cada tarjeta de tarea debe mostrar:
  - Identificador (TASK-NNN)
  - Título/descripción breve
  - Prioridad si está indicada en el .md
- Permitir expandir/colapsar columnas.

### 4. Actualización en tiempo real
- La interfaz debe reflejar cambios en el filesystem automáticamente:
  - Nuevo proyecto creado (nueva carpeta en `~/task-manager/`)
  - Proyecto eliminado
  - Tareas movidas entre carpetas (por agentes u otros procesos)
  - Nuevas tareas creadas
- Usar FileWatcher + PubSub (ya implementado en TASK-001) para esto.
- Aplicar debounce para evitar ráfagas de actualizaciones.

### 5. Navegación
- Navegación fluida entre la lista de proyectos y los tableros individuales.
- Breadcrumb o botón "volver" visible en la vista de tablero.
- URL amigable por proyecto (ej: `/projects/hello-world`).

### 6. Criterios de aceptación
- [ ] Todos los proyectos en `~/task-manager/` son visibles en la pantalla principal.
- [ ] Los contadores de tareas por estado son correctos.
- [ ] Al crear una nueva carpeta de proyecto en `~/task-manager/`, aparece automáticamente.
- [ ] Al mover una tarea de carpeta, la UI se actualiza sin recargar.
- [ ] La navegación entre proyectos es intuitiva (máximo 1 clic).
- [ ] No hay proyectos hardcodeados — todo es dinámico.

---
*Firmado: Jimmy (Product Owner) — 2026-03-17T16:22+01:00*
*Nota: Specs regeneradas tras pérdida del fichero original. Contenido reconstruido a partir de la petición original de Juan y el contexto del proyecto.*

## Plan de arquitectura (Pepe)
(Próximo paso)

## Implementación (Paco)
(Próximo paso)

## Revisión QA (Tony)
(Próximo paso)

## Deploy (Ron)
(Próximo paso — uso local, no requiere deploy a producción)
