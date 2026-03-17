defmodule TaskManagerGuiWeb.ProjectLive.Index do
  use TaskManagerGuiWeb, :live_view
  alias TaskManagerGui.FileService

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :projects, FileService.list_projects())}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="px-4 py-8 sm:px-6 lg:px-8 max-w-7xl mx-auto">
      <div class="sm:flex sm:items-center">
        <div class="sm:flex-auto">
          <h1 class="text-3xl font-bold leading-7 text-gray-900">Task Manager Projects</h1>
          <p class="mt-2 text-sm text-gray-700">Explora proyectos y gestiona tableros Kanban</p>
        </div>
        <div class="mt-4 sm:ml-16 sm:mt-0 sm:flex-none">
          <button
            type="button"
            phx-click="refresh"
            class="block rounded-md bg-indigo-600 px-3 py-2 text-center text-sm font-semibold text-white shadow-sm hover:bg-indigo-500"
          >
            Actualizar lista
          </button>
        </div>
      </div>

      <div class="mt-8 grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3">
        <%= for project <- @projects do %>
          <div class="relative flex items-center space-x-3 rounded-lg border border-gray-300 bg-white px-6 py-5 shadow-sm focus-within:ring-2 focus-within:ring-indigo-500 focus-within:ring-offset-2 hover:border-gray-400">
            <div class="flex-shrink-0">
              <span class="inline-flex h-10 w-10 items-center justify-center rounded-lg bg-indigo-500 text-white font-bold">
                <%= String.slice(project, 0..1) |> String.upcase() %>
              </span>
            </div>
            <div class="min-w-0 flex-1">
              <.link navigate={~p"/projects/#{project}"} class="focus:outline-none">
                <span class="absolute inset-0" aria-hidden="true"></span>
                <p class="text-sm font-medium text-gray-900 truncate">
                  <%= project %>
                </p>
                <p class="truncate text-xs text-gray-500">
                  /home/juan/task-manager/<%= project %>
                </p>
              </.link>
            </div>
          </div>
        <% end %>
      </div>
    </div>
    """
  end

  @impl true
  def handle_event("refresh", _, socket) do
    {:noreply, assign(socket, :projects, FileService.list_projects())}
  end
end
