defmodule BakeryWeb.SheetCakeLive.Show do
  use BakeryWeb, :live_view

  alias Bakery.Events

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:sheet_cake, Events.get_sheet_cake!(id))}
  end

  defp page_title(:show), do: "Show Sheet cake"
  defp page_title(:edit), do: "Edit Sheet cake"
end
