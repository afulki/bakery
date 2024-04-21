defmodule Bakery.Repo.Migrations.ChangeNumGuestsColumnToString do
  use Ecto.Migration

  def up do
    alter table(:cakes) do
      modify :num_guests, :string
    end
  end

  def down do
    alter table(:cakes) do
      modify :num_guests, :integer
    end
  end
end
