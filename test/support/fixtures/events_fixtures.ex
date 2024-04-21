defmodule Bakery.EventsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bakery.Events` context.
  """

  @doc """
  Generate a sheet_cake.
  """
  def sheet_cake_fixture(attrs \\ %{}) do
    {:ok, sheet_cake} =
      attrs
      |> Enum.into(%{
        name: "some name",
        price: "120.5",
        quantity: 42
      })
      |> Bakery.Events.create_sheet_cake()

    sheet_cake
  end
end
