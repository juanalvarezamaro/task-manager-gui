# TASK-003: Integración con GitHub

- **Proyecto:** task-manager-gui
- **Prioridad:** alta
- **Creado:** 2026-03-17
- **Repo:** https://github.com/juanalvarezamaro/task-manager-gui (a crear)

## Petición original
Aunque la aplicación es para uso local, necesitamos integración con GitHub para control de versiones, histórico de cambios y facilitar la colaboración futura.

## Especificaciones funcionales (Jimmy)

1. Crear y configurar repositorio:
   - Crear repo público en GitHub: juanalvarezamaro/task-manager-gui
   - Configurar .gitignore adecuado para Elixir/Phoenix
   - Añadir README.md con descripción del proyecto y guía de instalación
   - Configurar licencia (sugerir MIT)

2. Estructura del repositorio:
   ```
   task-manager-gui/
   ├── .gitignore
   ├── README.md
   ├── LICENSE
   ├── mix.exs
   ├── config/
   ├── lib/
   │   ├── task_manager_gui/
   │   └── task_manager_gui_web/
   ├── test/
   └── docs/
   ```

3. Documentación requerida:
   - README.md con:
     - Descripción del proyecto
     - Requisitos de sistema
     - Instrucciones de instalación
     - Guía de configuración
     - Modo de uso
   - Comentarios en el código siguiendo estándares Elixir
   - Documentación de módulos con ExDoc

4. Workflow de desarrollo:
   - Rama principal: main
   - Ramas de feature: feature/xxx
   - Commits descriptivos y atómicos
   - Pull requests para cambios significativos
   - Code review por el equipo

5. CI/CD (mínimo para uso local):
   - GitHub Actions para:
     - Ejecutar tests
     - Verificar formato de código
     - Ejecutar Credo para calidad
     - Generar documentación

## Plan de arquitectura (Pepe)

### 1. Estructura del proyecto

```
task-manager-gui/
├── .github/                    # Configuración de GitHub
│   ├── workflows/             # GitHub Actions
│   │   ├── test.yml          # Pipeline de pruebas
│   │   └── docs.yml          # Generación de docs
│   └── PULL_REQUEST_TEMPLATE.md
├── .gitignore                 # Configurado para Elixir/Phoenix
├── README.md                  # Documentación principal
├── LICENSE                    # Licencia MIT
├── mix.exs                    # Deps y configuración
├── config/                    # Configs por ambiente
├── lib/
│   ├── task_manager_gui/     # Lógica de negocio
│   │   ├── projects/         # Contexto de proyectos
│   │   └── github/          # Módulos de integración
│   └── task_manager_gui_web/ # Capa web Phoenix
├── test/                     # Tests automatizados
└── docs/                     # Documentación adicional
```

### 2. Integración GitHub

```elixir
# lib/task_manager_gui/github/client.ex
defmodule TaskManagerGui.Github.Client do
  @moduledoc """
  Cliente HTTP para interactuar con la API de GitHub.
  Usa HTTPoison con rate limiting y retry.
  """
  
  # Funciones para:
  # - Crear issues
  # - Manejar PRs
  # - Gestionar labels
end

# lib/task_manager_gui/github/webhook.ex
defmodule TaskManagerGui.Github.Webhook do
  @moduledoc """
  Manejo de webhooks de GitHub para sincronización.
  """
  
  # Endpoints para:
  # - Push events
  # - PR events
  # - Issue events
end
```

### 3. Configuración CI/CD

**.github/workflows/test.yml:**
```yaml
name: Test
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: erlef/setup-beam@v1
        with:
          otp-version: '25'
          elixir-version: '1.14'
      - run: mix deps.get
      - run: mix format --check-formatted
      - run: mix credo --strict
      - run: mix test
```

**.github/workflows/docs.yml:**
```yaml
name: Documentation
on:
  push:
    branches: [ main ]
jobs:
  docs:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: erlef/setup-beam@v1
      - run: mix docs
      - uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./doc
```

### 4. Configuración de desarrollo

**config/dev.exs:**
```elixir
config :task_manager_gui, TaskManagerGui.Github,
  api_url: "https://api.github.com",
  org: "juanalvarezamaro",
  repo: "task-manager-gui",
  # Token se configura via env vars
  token: {:system, "GITHUB_TOKEN"}
```

### 5. Buenas prácticas

1. **Seguridad:**
   - Tokens via env vars
   - Validación de webhooks
   - Rate limiting
   - Manejo seguro de secretos

2. **Código:**
   - Documentación con ExDoc
   - Tests exhaustivos
   - Format y Credo
   - PR templates

3. **Git workflow:**
   - Commits semánticos
   - Branch protection
   - Code owners
   - PR reviews obligatorios

4. **CI/CD:**
   - Tests en cada PR
   - Docs automáticos
   - Análisis estático
   - Coverage reports

## Implementación (Paco)
(Próximo paso)

## Revisión QA (Tony)
(Próximo paso)

## Deploy (Ron)
(Próximo paso)