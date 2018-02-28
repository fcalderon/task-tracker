defmodule Tasktracker.TimeBlocks.TimeBlock do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.TimeBlocks.TimeBlock


  schema "time_blocks" do
    field :end_time, :naive_datetime
    field :start_time, :naive_datetime
    belongs_to :task, Tasktracker.Tasks.Task

    timestamps()
  end

  @doc false
  def changeset(%TimeBlock{} = time_block, attrs) do
    time_block
    |> cast(attrs, [:start_time, :end_time, :task_id])
    |> validate_required([:start_time, :task_id])
  end
end