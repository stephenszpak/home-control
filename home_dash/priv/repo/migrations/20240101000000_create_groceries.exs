defmodule HomeDash.Repo.Migrations.CreateGroceries do
  use Ecto.Migration

  def change do
    create table(:groceries) do
      add :name, :string, null: false
      add :done, :boolean, default: false
      timestamps()
    end
  end
end
