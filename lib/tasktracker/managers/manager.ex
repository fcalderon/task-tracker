defmodule Tasktracker.Managers.Manager do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Managers.Manager
  alias Tasktracker.Accounts.User

  schema "managers" do
    field :underling_id, :id
    field :manager_id, :id

    belongs_to :manager, User, references: :id, define_field: false
    belongs_to :underling, User, references: :id, define_field: false


    timestamps()
  end

  @doc false
  def changeset(%Manager{} = manager, attrs) do
    manager
    |> cast(attrs, [:manager_id, :underling_id])
    |> validate_required([:manager_id, :underling_id])
  end
end
