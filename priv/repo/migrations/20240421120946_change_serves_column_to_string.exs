defmodule Bakery.Repo.Migrations.ChangeServesColumnToString do
  use Ecto.Migration

  def up do
    alter table(:cake_templates) do
      modify :serves, :string
    end
  end

  def down do
    alter table(:cake_templates) do
      modify :serves, :integer
    end
  end
end
