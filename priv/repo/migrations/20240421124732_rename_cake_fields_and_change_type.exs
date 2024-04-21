defmodule Bakery.Repo.Migrations.RenameCakeFieldsAndChangeType do
  use Ecto.Migration

  def change do
    alter table(:cakes) do
      remove :t1_flavor
      remove :t2_flavor
      remove :t3_flavor
      remove :t4_flavor
      remove :t5_flavor
      remove :t1_filling
      remove :t2_filling
      remove :t3_filling
      remove :t4_filling
      remove :t5_filling

      add :t1_flavor_id, :integer
      add :t2_flavor_id, :integer
      add :t3_flavor_id, :integer
      add :t4_flavor_id, :integer
      add :t5_flavor_id, :integer
      add :t1_filling_id, :integer
      add :t2_filling_id, :integer
      add :t3_filling_id, :integer
      add :t4_filling_id, :integer
      add :t5_filling_id, :integer
    end
  end
end
