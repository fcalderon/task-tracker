defmodule TasktrackerWeb.TimeBlockController do
  use TasktrackerWeb, :controller

  alias Tasktracker.TimeBlocks
  alias Tasktracker.TimeBlocks.TimeBlock
  alias Tasktracker.Tasks

  def action(conn, _) do
    task = Tasks.get_task!(conn.params["task_id"])
    args = [conn, conn.params, task]
    apply(__MODULE__, action_name(conn), args)
  end

  def index(conn, _params, task) do
    time_blocks = TimeBlocks.list_time_blocks(task)
    render(conn, "index.html", time_blocks: time_blocks, task: task)
  end

  def new(conn, _params, task) do
    changeset = TimeBlocks.change_time_block(%TimeBlock{task_id: task.id})
    render(conn, "new.html", changeset: changeset, task: task)
  end

  def create(conn, %{"time_block" => time_block_params}, task) do
    IO.puts("Creating time block")
    IO.inspect(task)
    IO.inspect(time_block_params)
    time_block_params = time_block_params
                        |> Map.put("task_id", task.id)
    case TimeBlocks.create_time_block(time_block_params) do
      {:ok, time_block} ->
        conn
        |> put_flash(:info, "Time block created successfully.")
        |> redirect(to: task_time_block_path(conn, :show, task, time_block))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, task: task)
    end
  end

  def show(conn, %{"id" => id}, task) do
    time_block = TimeBlocks.get_time_block!(task, id)
    render(conn, "show.html", time_block: time_block, task: task)
  end

  def edit(conn, %{"id" => id}, task) do
    time_block = TimeBlocks.get_time_block!(task, id)
    changeset = TimeBlocks.change_time_block(time_block)
    render(conn, "edit.html", time_block: time_block, changeset: changeset, task: task)
  end

  def update(conn, %{"id" => id, "time_block" => time_block_params}, task) do
    time_block = TimeBlocks.get_time_block!(task, id)

    case TimeBlocks.update_time_block(time_block, time_block_params) do
      {:ok, time_block} ->
        conn
        |> put_flash(:info, "Time block updated successfully.")
        |> redirect(to: task_time_block_path(conn, :show, time_block, task: task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", time_block: time_block, changeset: changeset, task: task)
    end
  end

  def delete(conn, %{"id" => id}, task) do
    time_block = TimeBlocks.get_time_block!(task, id)
    {:ok, _time_block} = TimeBlocks.delete_time_block(time_block)

    conn
    |> put_flash(:info, "Time block deleted successfully.")
    |> redirect(to: task_time_block_path(conn, :index, task: task))
  end
end
