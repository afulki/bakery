defmodule Bakery.Events.Cake do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cakes" do
    field :tiers, :integer, default: 1
    field :shape, :string, default: "round"
    field :style, :string, default: "single"
    field :base_price, :decimal, default: Decimal.new("100.00")
    field :num_guests, :string, default: "25"
    field :t1_add_cost, :decimal, default: Decimal.new("0.0")
    field :t2_add_cost, :decimal, default: Decimal.new("0.0")
    field :t3_add_cost, :decimal, default: Decimal.new("0.0")
    field :t4_add_cost, :decimal, default: Decimal.new("0.0")
    field :t5_add_cost, :decimal, default: Decimal.new("0.0")
    field :t1_description, :string
    field :t2_description, :string
    field :t3_description, :string
    field :t4_description, :string
    field :t5_description, :string

    belongs_to :event, Bakery.Events.Event
    belongs_to :t1_flavor, Bakery.Ingredients.Flavor, foreign_key: :t1_flavor_id
    belongs_to :t2_flavor, Bakery.Ingredients.Flavor, foreign_key: :t2_flavor_id
    belongs_to :t3_flavor, Bakery.Ingredients.Flavor, foreign_key: :t3_flavor_id
    belongs_to :t4_flavor, Bakery.Ingredients.Flavor, foreign_key: :t4_flavor_id
    belongs_to :t5_flavor, Bakery.Ingredients.Flavor, foreign_key: :t5_flavor_id
    belongs_to :t1_filling, Bakery.Ingredients.Filling, foreign_key: :t1_filling_id
    belongs_to :t2_filling, Bakery.Ingredients.Filling, foreign_key: :t2_filling_id
    belongs_to :t3_filling, Bakery.Ingredients.Filling, foreign_key: :t3_filling_id
    belongs_to :t4_filling, Bakery.Ingredients.Filling, foreign_key: :t4_filling_id
    belongs_to :t5_filling, Bakery.Ingredients.Filling, foreign_key: :t5_filling_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(cake, attrs) do
    cake
    |> cast(attrs, [
      :tiers,
      :shape,
      :style,
      :base_price,
      :num_guests,
      :t1_flavor_id,
      :t2_flavor_id,
      :t3_flavor_id,
      :t4_flavor_id,
      :t5_flavor_id,
      :t1_filling_id,
      :t2_filling_id,
      :t3_filling_id,
      :t4_filling_id,
      :t5_filling_id,
      :t1_add_cost,
      :t2_add_cost,
      :t3_add_cost,
      :t4_add_cost,
      :t5_add_cost,
      :t1_description,
      :t2_description,
      :t3_description,
      :t4_description,
      :t5_description,
      :event_id
    ])
    |> validate_required([
      :tiers,
      :shape,
      :style,
      :base_price,
      :num_guests,
      :t1_add_cost,
      :t2_add_cost,
      :t3_add_cost,
      :t4_add_cost,
      :t5_add_cost,
      :event_id
    ])
  end

  def sub_total(cake) do
    sum([cake.base_price, calc_cake_addons(cake)])
  end

  defp sum(values) do
    Enum.reduce(values, Decimal.new(1, 0, 0), fn v, acc -> Decimal.add(acc, v) end)
  end

  defp calc_cake_addons(cake) do
    [cake.t1_add_cost, cake.t2_add_cost, cake.t3_add_cost, cake.t4_add_cost, cake.t5_add_cost]
    |> sum()
  end
end
