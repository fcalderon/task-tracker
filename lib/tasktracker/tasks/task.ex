defmodule Tasktracker.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Tasks.Task


  schema "tasks" do
    field :title, :string
    field :body, :string
    belongs_to :user, Tasktracker.Accounts.User
    field :minutes_worked, :integer, default: 15
    field :completed, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:title, :body, :user_id, :minutes_worked, :completed])
    |> validate_required([:body, :user_id])
  end
end
