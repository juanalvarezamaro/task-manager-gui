defmodule TaskManagerGui.FileWatcher do
  use GenServer
  require Logger

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  def init(_args) do
    path = Path.expand("~/task-manager")
    {:ok, watcher_pid} = :fs.start_link(:task_watcher, path)
    :fs.subscribe(:task_watcher)
    {:ok, %{watcher_pid: watcher_pid, path: path}}
  end

  def handle_info({_pid, {:fs, :file_event}, {path, _events}}, state) do
    # Cuando detectamos un cambio, notificamos a través de PubSub
    # Como es una app local simple, podemos enviar un mensaje global
    # o filtrar por proyecto si analizamos el path.
    # Por simplicidad, notificamos que "algo" cambió.

    Phoenix.PubSub.broadcast(TaskManagerGui.PubSub, "file_changes", :remote_change)
    {:noreply, state}
  end
end
