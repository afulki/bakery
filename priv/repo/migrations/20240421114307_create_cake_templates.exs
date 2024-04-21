defmodule Bakery.Repo.Migrations.CreateCakeTemplates do
  use Ecto.Migration

  def change do
    create table(:cake_templates) do
      add :name, :string
      add :serves, :integer
      add :tiers, :integer
      add :shape, :string
      add :style, :string
      add :price, :decimal
      add :image, :string
      add :t1_diam, :decimal
      add :t2_diam, :decimal
      add :t3_diam, :decimal
      add :t4_diam, :decimal
      add :t5_diam, :decimal

      timestamps(type: :utc_datetime)
    end
  end
end
