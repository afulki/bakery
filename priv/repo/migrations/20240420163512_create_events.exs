defmodule Bakery.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string
      add :when, :date
      add :delivery_time, :time
      add :reception_time, :time
      add :c1_name, :string
      add :c1_email, :string
      add :c1_phone, :string
      add :c2_name, :string
      add :c2_phone, :string
      add :c2_email, :string
      add :venue_id, references(:venues, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:events, [:venue_id])
  end
end
