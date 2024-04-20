defmodule Bakery.Repo.Migrations.CreateFillings do
  use Ecto.Migration

  def change do
    create table(:fillings) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
