defmodule Bakery.Repo.Migrations.UpdateCakesWithReferences do
  use Ecto.Migration

  def change do
    alter table(:cakes) do
      remove :t1_flavor_id
      remove :t2_flavor_id
      remove :t3_flavor_id
      remove :t4_flavor_id
      remove :t5_flavor_id
      remove :t1_filling_id
      remove :t2_filling_id
      remove :t3_filling_id
      remove :t4_filling_id
      remove :t5_filling_id

      add :t1_flavor_id, references(:flavors)
      add :t2_flavor_id, references(:flavors)
      add :t3_flavor_id, references(:flavors)
      add :t4_flavor_id, references(:flavors)
      add :t5_flavor_id, references(:flavors)
      add :t1_filling_id, references(:fillings)
      add :t2_filling_id, references(:fillings)
      add :t3_filling_id, references(:fillings)
      add :t4_filling_id, references(:fillings)
      add :t5_filling_id, references(:fillings)
    end
  end
end
