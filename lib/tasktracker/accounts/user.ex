defmodule Tasktracker.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Accounts.User
  alias Tasktracker.Tasks.Task
  alias Tasktracker.Managers.Manager


  schema "users" do
    field :email, :string
    field :name, :string
    has_many :tasks, Task
    has_many :underlings, Manager, foreign_key: :underling_id
    has_one  :manager, Manager, foreign_key: :manager_id

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :name])
    |> validate_required([:email, :name])
  end
end
