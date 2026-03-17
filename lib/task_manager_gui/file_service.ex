defmodule TaskManagerGui.FileService do
  @moduledoc """
  Service to interact with the task-manager file system.
  """

  @base_path Path.expand("~/task-manager")
  @columns [
    "1-specs",
    "2-architecture",
    "3-development",
    "4-qa",
    "5-deployment",
    "done",
    "blocked"
  ]

  def base_path, do: @base_path
  def columns, do: @columns

  def list_projects do
    @base_path
    |> File.ls!()
    |> Enum.filter(&File.dir?(Path.join(@base_path, &1)))
    |> Enum.reject(&(&1 in [".git", "task-manager-gui"]))
    |> Enum.sort()
  end

  def get_board(project_name) do
    project_path = Path.join(@base_path, project_name)

    Enum.into(@columns, %{}, fn col ->
      col_path = Path.join(project_path, col)
      tasks =
        if File.dir?(col_path) do
          col_path
          |> File.ls!()
          |> Enum.filter(&String.ends_with?(&1, ".md"))
          |> Enum.sort()
        else
          []
        end
      {col, tasks}
    end)
  end

  def read_task_content(project_name, column, filename) do
    Path.join([@base_path, project_name, column, filename])
    |> File.read()
  end

  def move_task(project_name, filename, source_col, target_col) do
    source_path = Path.join([@base_path, project_name, source_col, filename])
    target_dir = Path.join([@base_path, project_name, target_col])
    target_path = Path.join(target_dir, filename)

    File.mkdir_p!(target_dir)

    case File.rename(source_path, target_path) do
      :ok -> {:ok, target_path}
      {:error, reason} -> {:error, reason}
    end
  end
end
