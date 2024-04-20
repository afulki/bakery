defmodule Bakery.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :name, :string
    field :when, :date
    field :delivery_time, :time
    field :reception_time, :time
    field :c1_name, :string
    field :c1_email, :string
    field :c1_phone, :string
    field :c2_name, :string
    field :c2_phone, :string
    field :c2_email, :string
    belongs_to :venue, Bakery.Venues.Venue
    has_many :cakes, Bakery.Events.Cake

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [
      :name,
      :when,
      :delivery_time,
      :reception_time,
      :c1_name,
      :c1_email,
      :c1_phone,
      :c2_name,
      :c2_phone,
      :c2_email,
      :venue_id
    ])
    |> validate_required([
      :name,
      :when,
      :delivery_time,
      :reception_time,
      :c1_name,
      :c1_email,
      :c1_phone
    ])
  end
end
