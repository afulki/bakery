defmodule Bakery.Repo.Migrations.CreateCakes do
  use Ecto.Migration

  def change do
    create table(:cakes) do
      add :tiers, :integer
      add :shape, :string
      add :style, :string
      add :base_price, :decimal
      add :num_guests, :integer
      add :t1_flavor, :string
      add :t2_flavor, :string
      add :t3_flavor, :string
      add :t4_flavor, :string
      add :t5_flavor, :string
      add :t1_filling, :string
      add :t2_filling, :string
      add :t3_filling, :string
      add :t4_filling, :string
      add :t5_filling, :string
      add :t1_add_cost, :decimal
      add :t2_add_cost, :decimal
      add :t3_add_cost, :decimal
      add :t4_add_cost, :decimal
      add :t5_add_cost, :decimal
      add :t1_description, :text
      add :t2_description, :text
      add :t3_description, :text
      add :t4_description, :text
      add :t5_description, :text
      add :event_id, references(:events, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end
  end
end
