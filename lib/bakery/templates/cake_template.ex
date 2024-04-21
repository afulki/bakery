defmodule Bakery.Templates.CakeTemplate do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cake_templates" do
    field :name, :string
    field :image, :string
    field :serves, :string
    field :tiers, :integer
    field :shape, :string
    field :style, :string
    field :price, :decimal
    field :t1_diam, :decimal
    field :t2_diam, :decimal
    field :t3_diam, :decimal
    field :t4_diam, :decimal
    field :t5_diam, :decimal

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(cake_template, attrs) do
    cake_template
    |> cast(attrs, [
      :name,
      :serves,
      :tiers,
      :shape,
      :style,
      :price,
      :image,
      :t1_diam,
      :t2_diam,
      :t3_diam,
      :t4_diam,
      :t5_diam
    ])
    |> validate_required([
      :name,
      :serves,
      :tiers,
      :shape,
      :style,
      :price,
      :image,
      :t1_diam,
      :t2_diam,
      :t3_diam,
      :t4_diam,
      :t5_diam
    ])
  end
end
