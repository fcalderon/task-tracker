defmodule TasktrackerWeb.TimeBlockApiController do
  use TasktrackerWeb, :controller

  alias Tasktracker.TimeBlocks
  alias Tasktracker.TimeBlocks.TimeBlock
  alias Tasktracker.Tasks

  action_fallback TasktrackerWeb.FallbackController

  def action(conn, _) do
    task = Tasks.get_task!(conn.params["task_id"])
    args = [conn, conn.params, task]
    IO.puts("Calling action::")
    IO.inspect(args)
    apply(__MODULE__, action_name(conn), args)
  end

  def create(conn, %{ "time_block" => time_block_params }, task) do
    time_block_params = time_block_params
                        |> Map.put("task_id", task.id)
    with {:ok, %TimeBlock{} = time_block} <- TimeBlocks.create_time_block(time_block_params) do
      render(conn, "show.json", time_block: TimeBlocks.get_time_block!(task, time_block.id), task: task)
    end

  end

  def show(conn, %{"id" => id}, task) do
    time_block = TimeBlocks.get_time_block!(task, id)
    render(conn, "show.json", time_block: time_block, task: task)
  end

  def update(conn, %{"id" => id, "time_block" => time_block_params}, task) do
    time_block = TimeBlocks.get_time_block!(task, id)

    with {:ok, %TimeBlock{} = time_block} <- TimeBlocks.update_time_block(time_block, time_block_params) do
      render(conn, "show.json", time_block: TimeBlocks.get_time_block!(task, time_block.id), task: task)
    end
  end
end
