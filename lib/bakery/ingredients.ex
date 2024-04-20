defmodule Bakery.Ingredients do
  @moduledoc """
  The Ingredients context.
  """

  import Ecto.Query, warn: false
  alias Bakery.Repo

  alias Bakery.Ingredients.Flavor

  @doc """
  Returns the list of flavors.

  ## Examples

      iex> list_flavors()
      [%Flavor{}, ...]

  """
  def list_flavors do
    Repo.all(Flavor)
  end

  @doc """
  Gets a single flavor.

  Raises `Ecto.NoResultsError` if the Flavor does not exist.

  ## Examples

      iex> get_flavor!(123)
      %Flavor{}

      iex> get_flavor!(456)
      ** (Ecto.NoResultsError)

  """
  def get_flavor!(id), do: Repo.get!(Flavor, id)

  @doc """
  Creates a flavor.

  ## Examples

      iex> create_flavor(%{field: value})
      {:ok, %Flavor{}}

      iex> create_flavor(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_flavor(attrs \\ %{}) do
    %Flavor{}
    |> Flavor.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a flavor.

  ## Examples

      iex> update_flavor(flavor, %{field: new_value})
      {:ok, %Flavor{}}

      iex> update_flavor(flavor, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_flavor(%Flavor{} = flavor, attrs) do
    flavor
    |> Flavor.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a flavor.

  ## Examples

      iex> delete_flavor(flavor)
      {:ok, %Flavor{}}

      iex> delete_flavor(flavor)
      {:error, %Ecto.Changeset{}}

  """
  def delete_flavor(%Flavor{} = flavor) do
    Repo.delete(flavor)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking flavor changes.

  ## Examples

      iex> change_flavor(flavor)
      %Ecto.Changeset{data: %Flavor{}}

  """
  def change_flavor(%Flavor{} = flavor, attrs \\ %{}) do
    Flavor.changeset(flavor, attrs)
  end

  alias Bakery.Ingredients.Filling

  @doc """
  Returns the list of fillings.

  ## Examples

      iex> list_fillings()
      [%Filling{}, ...]

  """
  def list_fillings do
    Repo.all(Filling)
  end

  @doc """
  Gets a single filling.

  Raises `Ecto.NoResultsError` if the Filling does not exist.

  ## Examples

      iex> get_filling!(123)
      %Filling{}

      iex> get_filling!(456)
      ** (Ecto.NoResultsError)

  """
  def get_filling!(id), do: Repo.get!(Filling, id)

  @doc """
  Creates a filling.

  ## Examples

      iex> create_filling(%{field: value})
      {:ok, %Filling{}}

      iex> create_filling(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_filling(attrs \\ %{}) do
    %Filling{}
    |> Filling.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a filling.

  ## Examples

      iex> update_filling(filling, %{field: new_value})
      {:ok, %Filling{}}

      iex> update_filling(filling, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_filling(%Filling{} = filling, attrs) do
    filling
    |> Filling.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a filling.

  ## Examples

      iex> delete_filling(filling)
      {:ok, %Filling{}}

      iex> delete_filling(filling)
      {:error, %Ecto.Changeset{}}

  """
  def delete_filling(%Filling{} = filling) do
    Repo.delete(filling)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking filling changes.

  ## Examples

      iex> change_filling(filling)
      %Ecto.Changeset{data: %Filling{}}

  """
  def change_filling(%Filling{} = filling, attrs \\ %{}) do
    Filling.changeset(filling, attrs)
  end
end
