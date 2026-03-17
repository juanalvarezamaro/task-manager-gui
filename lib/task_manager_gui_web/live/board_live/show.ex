defmodule TaskManagerGuiWeb.BoardLive.Show do
  use TaskManagerGuiWeb, :live_view
  alias TaskManagerGui.FileService

  @impl true
  def mount(%{"id" => project_id}, _session, socket) do
    if connected?(socket) do
      Phoenix.PubSub.subscribe(TaskManagerGui.PubSub, "file_changes")
    end

    {:ok,
     socket
     |> assign(:project_id, project_id)
     |> assign(:board, FileService.get_board(project_id))
     |> assign(:selected_task, nil)
     |> assign(:modal_open, false)}
  end

  @impl true
  def handle_info(:remote_change, socket) do
    {:noreply,
     socket
     |> assign(:board, FileService.get_board(socket.assigns.project_id))}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="px-4 py-8 sm:px-6 lg:px-8">
      <div class="flex items-center justify-between mb-8">
        <h1 class="text-2xl font-bold text-gray-900">Proyecto: <%= @project_id %></h1>
        <.link navigate={~p"/"} class="text-sm font-semibold leading-6 text-gray-900">
          &larr; Volver a proyectos
        </link>
      </div>

      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 xl:grid-cols-7 gap-4 overflow-x-auto pb-4">
        <%= for col <- FileService.columns() do %>
          <div class="bg-gray-100 p-4 rounded-lg flex-shrink-0 min-w-[250px]">
            <h2 class="font-bold text-gray-700 mb-4 uppercase text-xs tracking-wider font-mono">
              <%= String.replace(col, "-", " ") %> (<%= length(Map.get(@board, col, [])) %>)
            </h2>

            <div
              id={"col-#{col}"}
              phx-hook="Sortable"
              data-column={col}
              class="space-y-3 min-h-[500px]"
            >
              <%= for task <- Map.get(@board, col, []) do %>
                <div
                  id={task}
                  data-id={task}
                  class="bg-white p-3 rounded shadow-sm border border-gray-200 cursor-pointer hover:border-indigo-500 transition-colors group relative"
                  phx-click="show_task"
                  phx-value-task={task}
                  phx-value-col={col}
                >
                  <div class="text-sm font-medium text-gray-900 truncate pr-2">
                    <%= String.trim_trailing(task, ".md") %>
                  </div>
                  <div class="mt-1 text-xs text-gray-500">
                    <span class="inline-flex items-center rounded-md bg-blue-50 px-2 py-1 text-xs font-medium text-blue-700 ring-1 ring-inset ring-blue-700/10">
                      Task
                    </span>
                  </div>
                </div>
              <% end %>
            </div>
          </div>
        <% end %>
      </div>

      <.modal
        :if={@modal_open}
        id="task-modal"
        show
        on_cancel={JS.push("close_modal")}
      >
        <div class="space-y-4">
          <h3 class="text-xl font-bold"><%= @selected_task.filename %></h3>
          <div class="prose prose-sm max-w-none border-t pt-4">
            <pre class="bg-gray-50 p-4 rounded text-xs overflow-auto max-h-[60vh]"><%= @selected_task.content %></pre>
          </div>
        </div>
      </.modal>
    </div>
    """
  end

  @impl true
  def handle_event("show_task", %{"task" => task, "col" => col}, socket) do
    case FileService.read_task_content(socket.assigns.project_id, col, task) do
      {:ok, content} ->
        {:noreply,
         socket
         |> assign(:selected_task, %{filename: task, content: content})
         |> assign(:modal_open, true)}

      _ ->
        {:noreply, socket}
    end
  end

  @impl true
  def handle_event("close_modal", _, socket) do
    {:noreply, socket |> assign(:selected_task, nil) |> assign(:modal_open, false)}
  end

  @impl true
  def handle_event("move_task", %{"id" => filename, "from" => from, "to" => to}, socket) do
    project_id = socket.assigns.project_id

    case FileService.move_task(project_id, filename, from, to) do
      {:ok, _} ->
        {:noreply,
         socket
         |> assign(:board, FileService.get_board(project_id))
         |> put_flash(:info, "Tarea movida con éxito")}

      {:error, _} ->
        {:noreply,
         socket
         |> assign(:board, FileService.get_board(project_id))
         |> put_flash(:error, "Error al mover la tarea")}
    end
  end
end
