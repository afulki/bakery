defmodule BakeryWeb.FillingLive.Index do
  use BakeryWeb, :live_view

  alias Bakery.Ingredients
  alias Bakery.Ingredients.Filling

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :fillings, Ingredients.list_fillings())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Filling")
    |> assign(:filling, Ingredients.get_filling!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Filling")
    |> assign(:filling, %Filling{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Fillings")
    |> assign(:filling, nil)
  end

  @impl true
  def handle_info({BakeryWeb.FillingLive.FormComponent, {:saved, filling}}, socket) do
    {:noreply, stream_insert(socket, :fillings, filling)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    filling = Ingredients.get_filling!(id)
    {:ok, _} = Ingredients.delete_filling(filling)

    {:noreply, stream_delete(socket, :fillings, filling)}
  end
end
