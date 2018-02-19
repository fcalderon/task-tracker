defmodule Tasktracker.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :text, null: false
      add :body, :text, null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :completed, :boolean, default: false, null: false
      add :minutes_worked, :integer, null: false

      timestamps()
    end

    create index(:tasks, [:user_id])
    create constraint("tasks", :minutes_must_be_pos, check: "minutes_worked > 0")
  end
end
