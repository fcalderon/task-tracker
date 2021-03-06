defmodule Tasktracker.Tasks do
  @moduledoc """
  The Tasks context.
  """

  import Ecto.Query, warn: false
  alias Tasktracker.Repo

  alias Tasktracker.Tasks.Task

  @doc """
  Returns the list of tasks.

  ## Examples

      iex> list_tasks()
      [%Task{}, ...]

  """
  def list_tasks do
    Repo.all(Task)
    |> Repo.preload(:user)
  end

  def list_completed_tasks_by_assignee(id) do
    query = from t in Task, join: u in assoc(t, :user), join: m in assoc(u, :underlings), where: u.id== ^id and t.completed == true

    Repo.all(query)
    |> Repo.preload(:user)
  end

  def list_non_completed_tasks_by_assignee(id) do
    query = from t in Task, join: u in assoc(t, :user), join: m in assoc(u, :underlings), where: u.id== ^id and t.completed == false

    Repo.all(query)
    |> Repo.preload(:user)
  end

  def list_completed_tasks_by_manager_id(id) do
    query = from t in Task, join: u in assoc(t, :user), join: m in assoc(u, :underlings), where: m.manager_id == ^id and t.completed == true

    Repo.all(query)
    |> Repo.preload(:user)
  end

  def list_non_completed_tasks_by_manager_id(id) do
    query = from t in Task, join: u in assoc(t, :user), join: m in assoc(u, :underlings), where: m.manager_id == ^id and t.completed == false

    Repo.all(query)
    |> Repo.preload(:user)
  end

  def list_by_user_id(id) do
    query = from t in Task, join: u in assoc(t, :user), where: u.id == ^id

    Repo.all(query)
    |> Repo.preload(:user)
  end

  def list_by_manager_id(id) do
    query = from t in Task, join: u in assoc(t, :user), join: m in assoc(u, :underlings), where: m.manager_id == ^id

    Repo.all(query)
    |> Repo.preload(:user)
  end

  @doc """
  Gets a single task.

  Raises `Ecto.NoResultsError` if the Task does not exist.

  ## Examples

      iex> get_task!(123)
      %Task{}

      iex> get_task!(456)
      ** (Ecto.NoResultsError)

  """
  def get_task!(id), do: Repo.get!(Task, id)
                         |> Repo.preload(:user)
                         |> Repo.preload(:time_blocks)

  @doc """
  Creates a task.

  ## Examples

      iex> create_task(%{field: value})
      {:ok, %Task{}}

      iex> create_task(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a task.

  ## Examples

      iex> update_task(task, %{field: new_value})
      {:ok, %Task{}}

      iex> update_task(task, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Task.

  ## Examples

      iex> delete_task(task)
      {:ok, %Task{}}

      iex> delete_task(task)
      {:error, %Ecto.Changeset{}}

  """
  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task changes.

  ## Examples

      iex> change_task(task)
      %Ecto.Changeset{source: %Task{}}

  """
  def change_task(%Task{} = task) do
    Task.changeset(task, %{})
  end
end
