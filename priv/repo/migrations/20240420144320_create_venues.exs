defmodule Bakery.Repo.Migrations.CreateVenues do
  use Ecto.Migration

  def change do
    create table(:venues) do
      add :name, :string
      add :street, :string
      add :city, :string
      add :state, :string
      add :zip, :string
      add :contact, :string
      add :phone, :string
      add :email, :string
      add :distance_in_miles, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
