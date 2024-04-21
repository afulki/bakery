defmodule Bakery.Ingredients.Flavor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "flavors" do
    field :name, :string
    has_many :t1_flavor_cakes, Bakery.Events.Cake, foreign_key: :t1_flavor_id
    has_many :t2_flavor_cakes, Bakery.Events.Cake, foreign_key: :t2_flavor_id
    has_many :t3_flavor_cakes, Bakery.Events.Cake, foreign_key: :t3_flavor_id
    has_many :t4_flavor_cakes, Bakery.Events.Cake, foreign_key: :t4_flavor_id
    has_many :t5_flavor_cakes, Bakery.Events.Cake, foreign_key: :t5_flavor_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(flavor, attrs) do
    flavor
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
