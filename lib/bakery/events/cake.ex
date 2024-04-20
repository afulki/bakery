defmodule Bakery.Events.Cake do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cakes" do
    field :tiers, :integer
    field :shape, :string
    field :style, :string
    field :base_price, :decimal
    field :num_guests, :integer
    field :t1_flavor, :string
    field :t2_flavor, :string
    field :t3_flavor, :string
    field :t4_flavor, :string
    field :t5_flavor, :string
    field :t1_filling, :string
    field :t2_filling, :string
    field :t3_filling, :string
    field :t4_filling, :string
    field :t5_filling, :string
    field :t1_add_cost, :decimal
    field :t2_add_cost, :decimal
    field :t3_add_cost, :decimal
    field :t4_add_cost, :decimal
    field :t5_add_cost, :decimal
    field :t1_description, :string
    field :t2_description, :string
    field :t3_description, :string
    field :t4_description, :string
    field :t5_description, :string
    belongs_to :event, Bakery.Events.Event

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
      :t1_flavor,
      :t2_flavor,
      :t3_flavor,
      :t4_flavor,
      :t5_flavor,
      :t1_filling,
      :t2_filling,
      :t3_filling,
      :t4_filling,
      :t5_filling,
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
      :t1_flavor,
      :t2_flavor,
      :t3_flavor,
      :t4_flavor,
      :t5_flavor,
      :t1_filling,
      :t2_filling,
      :t3_filling,
      :t4_filling,
      :t5_filling,
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
  end
end
