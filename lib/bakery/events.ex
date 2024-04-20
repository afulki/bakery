defmodule Bakery.Events do
  @moduledoc """
  The Events context.
  """

  import Ecto.Query, warn: false
  alias Bakery.Repo

  alias Bakery.Events.Event

  @doc """
  Returns the list of events.

  ## Examples

      iex> list_events()
      [%Event{}, ...]

  """
  def list_events do
    Repo.all(Event)
  end

  @doc """
  Gets a single event.

  Raises `Ecto.NoResultsError` if the Event does not exist.

  ## Examples

      iex> get_event!(123)
      %Event{}

      iex> get_event!(456)
      ** (Ecto.NoResultsError)

  """
  def get_event!(id) do
    Repo.get!(Event, id)
    |> Repo.preload(:venue)
  end

  @doc """
  Creates a event.

  ## Examples

      iex> create_event(%{field: value})
      {:ok, %Event{}}

      iex> create_event(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_event(attrs \\ %{}) do
    %Event{}
    |> Event.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a event.

  ## Examples

      iex> update_event(event, %{field: new_value})
      {:ok, %Event{}}

      iex> update_event(event, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_event(%Event{} = event, attrs) do
    event
    |> Event.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a event.

  ## Examples

      iex> delete_event(event)
      {:ok, %Event{}}

      iex> delete_event(event)
      {:error, %Ecto.Changeset{}}

  """
  def delete_event(%Event{} = event) do
    Repo.delete(event)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking event changes.

  ## Examples

      iex> change_event(event)
      %Ecto.Changeset{data: %Event{}}

  """
  def change_event(%Event{} = event, attrs \\ %{}) do
    Event.changeset(event, attrs)
  end

  alias Bakery.Events.Cake

  @doc """
  Returns the list of cakes.

  ## Examples

      iex> list_cakes()
      [%Cake{}, ...]

  """
  def list_cakes do
    Repo.all(Cake)
  end

  @doc """
  Gets a single cake.

  Raises `Ecto.NoResultsError` if the Cake does not exist.

  ## Examples

      iex> get_cake!(123)
      %Cake{}

      iex> get_cake!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cake!(id), do: Repo.get!(Cake, id)

  @doc """
  Creates a cake.

  ## Examples

      iex> create_cake(%{field: value})
      {:ok, %Cake{}}

      iex> create_cake(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cake(attrs \\ %{}) do
    %Cake{}
    |> Cake.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a cake.

  ## Examples

      iex> update_cake(cake, %{field: new_value})
      {:ok, %Cake{}}

      iex> update_cake(cake, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cake(%Cake{} = cake, attrs) do
    cake
    |> Cake.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a cake.

  ## Examples

      iex> delete_cake(cake)
      {:ok, %Cake{}}

      iex> delete_cake(cake)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cake(%Cake{} = cake) do
    Repo.delete(cake)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cake changes.

  ## Examples

      iex> change_cake(cake)
      %Ecto.Changeset{data: %Cake{}}

  """
  def change_cake(%Cake{} = cake, attrs \\ %{}) do
    Cake.changeset(cake, attrs)
  end

  @doc """
  Counts the cakes for this event

  ## Example

    iex> cakes_for_event(%Event{})
    [%Cake{}]
  """
  def cakes_for_event(%Event{id: id}) do
    query = from(c in Cake, where: c.event_id == ^id)

    Repo.all(query)
  end
end
