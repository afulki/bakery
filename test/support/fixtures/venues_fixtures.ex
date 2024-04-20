defmodule Bakery.VenuesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bakery.Venues` context.
  """

  @doc """
  Generate a venue.
  """
  def venue_fixture(attrs \\ %{}) do
    {:ok, venue} =
      attrs
      |> Enum.into(%{
        city: "some city",
        contact: "some contact",
        distance_in_miles: 42,
        email: "some email",
        name: "some name",
        phone: "some phone",
        state: "some state",
        street: "some street",
        zip: "some zip"
      })
      |> Bakery.Venues.create_venue()

    venue
  end
end
