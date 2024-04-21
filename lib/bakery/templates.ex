defmodule Bakery.Templates do
  @moduledoc """
  The Templates context.
  """

  import Ecto.Query, warn: false
  alias Bakery.Repo

  alias Bakery.Templates.CakeTemplate

  @doc """
  Returns the list of cake_templates.

  ## Examples

      iex> list_cake_templates()
      [%CakeTemplate{}, ...]

  """
  def list_cake_templates do
    Repo.all(CakeTemplate)
  end

  @doc """
  Gets a single cake_template.

  Raises `Ecto.NoResultsError` if the Cake template does not exist.

  ## Examples

      iex> get_cake_template!(123)
      %CakeTemplate{}

      iex> get_cake_template!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cake_template!(id), do: Repo.get!(CakeTemplate, id)

  @doc """
  Creates a cake_template.

  ## Examples

      iex> create_cake_template(%{field: value})
      {:ok, %CakeTemplate{}}

      iex> create_cake_template(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cake_template(attrs \\ %{}) do
    %CakeTemplate{}
    |> CakeTemplate.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a cake_template.

  ## Examples

      iex> update_cake_template(cake_template, %{field: new_value})
      {:ok, %CakeTemplate{}}

      iex> update_cake_template(cake_template, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cake_template(%CakeTemplate{} = cake_template, attrs) do
    cake_template
    |> CakeTemplate.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a cake_template.

  ## Examples

      iex> delete_cake_template(cake_template)
      {:ok, %CakeTemplate{}}

      iex> delete_cake_template(cake_template)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cake_template(%CakeTemplate{} = cake_template) do
    Repo.delete(cake_template)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cake_template changes.

  ## Examples

      iex> change_cake_template(cake_template)
      %Ecto.Changeset{data: %CakeTemplate{}}

  """
  def change_cake_template(%CakeTemplate{} = cake_template, attrs \\ %{}) do
    CakeTemplate.changeset(cake_template, attrs)
  end

  def find_template(number_of_guests, style, shape) do
    query =
      from c in CakeTemplate,
        where: c.style == ^style and c.shape == ^shape and c.serves >= ^number_of_guests,
        order_by: [asc: :serves]

    case Repo.all(query) do
      [template | _] -> template
      [] -> nil
    end
  end
end
