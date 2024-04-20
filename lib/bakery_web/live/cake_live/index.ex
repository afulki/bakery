defmodule BakeryWeb.CakeLive.Index do
  use BakeryWeb, :live_view

  alias Bakery.Events
  alias Bakery.Events.Cake

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :cakes, Events.list_cakes())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Cake")
    |> assign(:cake, Events.get_cake!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Cake")
    |> assign(:cake, %Cake{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Cakes")
    |> assign(:cake, nil)
  end

  @impl true
  def handle_info({BakeryWeb.CakeLive.FormComponent, {:saved, cake}}, socket) do
    {:noreply, stream_insert(socket, :cakes, cake)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    cake = Events.get_cake!(id)
    {:ok, _} = Events.delete_cake(cake)

    {:noreply, stream_delete(socket, :cakes, cake)}
  end
end
