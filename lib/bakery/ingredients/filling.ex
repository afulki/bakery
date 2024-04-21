defmodule Bakery.Ingredients.Filling do
  use Ecto.Schema
  import Ecto.Changeset

  schema "fillings" do
    field :name, :string
    has_many :t1_filling_cakes, Bakery.Events.Cake, foreign_key: :t1_filling_id
    has_many :t2_filling_cakes, Bakery.Events.Cake, foreign_key: :t2_filling_id
    has_many :t3_filling_cakes, Bakery.Events.Cake, foreign_key: :t3_filling_id
    has_many :t4_filling_cakes, Bakery.Events.Cake, foreign_key: :t4_filling_id
    has_many :t5_filling_cakes, Bakery.Events.Cake, foreign_key: :t5_filling_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(filling, attrs) do
    filling
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
