defmodule BakeryWeb.VenueLive.Show do
  use BakeryWeb, :live_view

  alias Bakery.Venues

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:venue, Venues.get_venue!(id))}
  end

  defp page_title(:show), do: "Show Venue"
  defp page_title(:edit), do: "Edit Venue"
end
