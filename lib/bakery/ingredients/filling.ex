defmodule Bakery.Ingredients.Filling do
  use Ecto.Schema
  import Ecto.Changeset

  schema "fillings" do
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(filling, attrs) do
    filling
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
