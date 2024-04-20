defmodule BakeryWeb.FlavorLive.Index do
  use BakeryWeb, :live_view

  alias Bakery.Ingredients
  alias Bakery.Ingredients.Flavor

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :flavors, Ingredients.list_flavors())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Flavor")
    |> assign(:flavor, Ingredients.get_flavor!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Flavor")
    |> assign(:flavor, %Flavor{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Flavors")
    |> assign(:flavor, nil)
  end

  @impl true
  def handle_info({BakeryWeb.FlavorLive.FormComponent, {:saved, flavor}}, socket) do
    {:noreply, stream_insert(socket, :flavors, flavor)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    flavor = Ingredients.get_flavor!(id)
    {:ok, _} = Ingredients.delete_flavor(flavor)

    {:noreply, stream_delete(socket, :flavors, flavor)}
  end
end
