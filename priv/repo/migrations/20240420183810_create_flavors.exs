defmodule Bakery.Repo.Migrations.CreateFlavors do
  use Ecto.Migration

  def change do
    create table(:flavors) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
