defmodule Bakery.Events.SheetCake do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sheet_cakes" do
    field :name, :string
    field :quantity, :integer, default: 1
    field :price, :decimal

    belongs_to :event, Bakery.Events.Event
    belongs_to :flavor, Bakery.Ingredients.Flavor
    belongs_to :filling, Bakery.Ingredients.Filling

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(sheet_cake, attrs) do
    sheet_cake
    |> cast(attrs, [:name, :quantity, :price, :event_id, :flavor_id, :filling_id])
    |> validate_required([:name, :quantity, :price, :flavor_id, :filling_id, :event_id])
    |> validate_number(:quantity, greater_than: 0)
  end
end
