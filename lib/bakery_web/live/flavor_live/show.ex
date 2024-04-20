defmodule BakeryWeb.FlavorLive.Show do
  use BakeryWeb, :live_view

  alias Bakery.Ingredients

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:flavor, Ingredients.get_flavor!(id))}
  end

  defp page_title(:show), do: "Show Flavor"
  defp page_title(:edit), do: "Edit Flavor"
end
