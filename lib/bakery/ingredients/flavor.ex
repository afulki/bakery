defmodule Bakery.Ingredients.Flavor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "flavors" do
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(flavor, attrs) do
    flavor
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
