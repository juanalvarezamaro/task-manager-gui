# TASK-002: Asegurar visualización de todos los proyectos

- **Proyecto:** task-manager-gui
- **Prioridad:** alta
- **Creado:** 2026-03-17
- **Repo:** https://github.com/juanalvarezamaro/task-manager-gui (pendiente de crear)

## Petición original
Juan ha detectado que no se están mostrando correctamente todos los proyectos en la interfaz. Necesitamos asegurar que la interfaz muestre TODOS los proyectos que existan en `~/task-manager/`.

## Especificaciones funcionales (Jimmy)
1. El sistema debe escanear la carpeta `~/task-manager/` y mostrar TODOS los proyectos existentes (actualmente hello-world y task-manager-gui, pero podrían ser más en el futuro).

2. Para cada proyecto encontrado:
   - Mostrar el nombre del proyecto
   - Listar todas sus tareas en el tablero Kanban correspondiente
   - Las tareas deben aparecer en la columna correcta según su ubicación en el sistema de archivos

3. La interfaz debe actualizar la lista de proyectos en tiempo real cuando:
   - Se cree un nuevo proyecto (nueva carpeta en `~/task-manager/`)
   - Se elimine un proyecto existente
   - Se muevan tareas entre carpetas

4. En la vista principal:
   - Mostrar un listado de todos los proyectos
   - Permitir expandir/colapsar el tablero Kanban de cada proyecto
   - Indicar el número de tareas en cada estado para cada proyecto

5. Criterios de aceptación:
   - Todos los proyectos en `~/task-manager/` deben ser visibles
   - Los cambios en el sistema de archivos deben reflejarse inmediatamente
   - La navegación debe ser intuitiva entre proyectos

## Plan de arquitectura (Pepe)

### 1. Sistema de monitoreo de proyectos

```elixir
# lib/task_manager_gui/projects/watcher.ex
defmodule TaskManagerGui.Projects.Watcher do
  use GenServer
  require Logger

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  # Utilizar :fs para monitorear cambios en el sistema de archivos
  # Implementar callbacks para eventos de archivo
  # Broadcast de cambios via PubSub
end
```

### 2. Estructura de datos y contexto

```elixir
# lib/task_manager_gui/projects/project.ex
defmodule TaskManagerGui.Projects.Project do
  defstruct [:name, :path, :tasks]
  
  # Funciones para:
  # - Escanear directorio de proyectos
  # - Parsear estructura de tareas
  # - Mantener estado actualizado
end

# lib/task_manager_gui/projects.ex
defmodule TaskManagerGui.Projects do
  # API pública para gestión de proyectos:
  # - list_projects/0
  # - get_project!/1
  # - get_project_tasks/1
  # - subscribe/0 (para actualizaciones en tiempo real)
end
```

### 3. LiveView y componentes

```elixir
# lib/task_manager_gui_web/live/project_live/index.ex
defmodule TaskManagerGuiWeb.ProjectLive.Index do
  use TaskManagerGuiWeb, :live_view
  
  # Implementar:
  # - mount/3 para carga inicial
  # - handle_info/2 para actualizaciones en tiempo real
  # - render/1 para la vista principal
end

# lib/task_manager_gui_web/live/project_live/components/kanban_board.ex
defmodule TaskManagerGuiWeb.ProjectLive.Components.KanbanBoard do
  use TaskManagerGuiWeb, :live_component
  
  # Componente reutilizable para tableros Kanban
  # Soporta expand/collapse y muestra contadores
end
```

### 4. Sistema de eventos

```elixir
# lib/task_manager_gui/projects/events.ex
defmodule TaskManagerGui.Projects.Events do
  # Tipos de eventos:
  # - :project_created
  # - :project_deleted
  # - :tasks_updated
  
  # Broadcast via Phoenix.PubSub
end
```

### 5. Arquitectura de actualización en tiempo real

1. El `Watcher` monitorea cambios en `~/task-manager/`
2. Los cambios detectados se procesan en el contexto `Projects`
3. Se emiten eventos vía PubSub
4. Los LiveViews suscritos actualizan la UI automáticamente

### 6. Consideraciones técnicas

- Usar `debounce` para evitar actualizaciones excesivas
- Implementar cache para rendimiento
- Manejar errores de sistema de archivos
- Logging apropiado para debugging

## Implementación (Paco)
(Próximo paso)

## Revisión QA (Tony)
(Próximo paso)

## Deploy (Ron)
(Próximo paso - Recordar que es para uso local)