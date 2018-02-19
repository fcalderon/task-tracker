defmodule Tasktracker.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Tasks.Task


  schema "tasks" do
    field :body, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end
