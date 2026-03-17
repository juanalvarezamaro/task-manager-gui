defmodule TaskManagerGui.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TaskManagerGuiWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:task_manager_gui, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: TaskManagerGui.PubSub},
      # Start a worker by calling: TaskManagerGui.Worker.start_link(arg)
      # {TaskManagerGui.Worker, arg},
      TaskManagerGui.FileWatcher,
      # Start to serve requests, typically the last entry
      TaskManagerGuiWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TaskManagerGui.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TaskManagerGuiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
