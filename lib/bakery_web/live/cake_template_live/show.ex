defmodule BakeryWeb.CakeTemplateLive.Show do
  use BakeryWeb, :live_view

  alias Bakery.Templates

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:cake_template, Templates.get_cake_template!(id))}
  end

  defp page_title(:show), do: "Show Cake template"
  defp page_title(:edit), do: "Edit Cake template"
end
