defmodule Bakery.IngredientsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bakery.Ingredients` context.
  """

  @doc """
  Generate a flavor.
  """
  def flavor_fixture(attrs \\ %{}) do
    {:ok, flavor} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Bakery.Ingredients.create_flavor()

    flavor
  end

  @doc """
  Generate a filling.
  """
  def filling_fixture(attrs \\ %{}) do
    {:ok, filling} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Bakery.Ingredients.create_filling()

    filling
  end
end
