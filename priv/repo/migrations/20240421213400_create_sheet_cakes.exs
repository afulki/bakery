defmodule Bakery.Repo.Migrations.CreateSheetCakes do
  use Ecto.Migration

  def change do
    create table(:sheet_cakes) do
      add :name, :string
      add :quantity, :integer
      add :price, :decimal
      add :filling_id, references(:fillings, on_delete: :nothing)
      add :flavor_id, references(:flavors, on_delete: :nothing)
      add :event_id, references(:events, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:sheet_cakes, [:filling_id])
    create index(:sheet_cakes, [:flavor_id])
    create index(:sheet_cakes, [:event_id])
  end
end
