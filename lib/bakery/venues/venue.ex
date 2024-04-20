defmodule Bakery.Venues.Venue do
  use Ecto.Schema
  import Ecto.Changeset

  schema "venues" do
    field :name, :string
    field :state, :string
    field :zip, :string
    field :street, :string
    field :city, :string
    field :contact, :string
    field :phone, :string
    field :email, :string
    field :distance_in_miles, :integer
    has_many :events, Bakery.Events.Event

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(venue, attrs) do
    venue
    |> cast(attrs, [
      :name,
      :street,
      :city,
      :state,
      :zip,
      :contact,
      :phone,
      :email,
      :distance_in_miles
    ])
    |> validate_required([
      :name,
      :street,
      :city,
      :state,
      :zip,
      :contact,
      :phone,
      :email,
      :distance_in_miles
    ])
  end
end
