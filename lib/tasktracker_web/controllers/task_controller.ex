defmodule TasktrackerWeb.TaskController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Tasks
  alias Tasktracker.Tasks.Task
  alias Tasktracker.Accounts
  alias Tasktracker.Managers

  def index(conn, _params) do
    user_id = get_session(conn, :user_id)

    tasks = Tasks.list_non_completed_tasks_by_manager_id(user_id)
    completed_tasks = Tasks.list_completed_tasks_by_manager_id(user_id)
    render(conn, "index.html", tasks: tasks, completed_tasks: completed_tasks)
  end

  def new(conn, _params) do
    changeset = Tasks.change_task(%Task{})

    user_id = get_session(conn, :user_id)

    users = Managers.list_by_manager_id(user_id) |> Enum.map(&{&1.underling.name, &1.underling.id})

    render(conn, "new.html", changeset: changeset, users: users, task: nil)
  end

  def create(conn, %{"task" => task_params}) do
    case Tasks.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    render(conn, "show.html", task: task)
  end

  def edit(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    changeset = Tasks.change_task(task)
    users = Accounts.list_users() |> Enum.map(&{&1.name, &1.id})
    render(conn, "edit.html", task: task, changeset: changeset, users: users)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Tasks.get_task!(id)

    case Tasks.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    {:ok, _task} = Tasks.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: task_path(conn, :index))
  end
end
