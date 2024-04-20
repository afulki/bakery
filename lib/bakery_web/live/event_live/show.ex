defmodule BakeryWeb.EventLive.Show do
  use BakeryWeb, :live_view

  alias Bakery.Events

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> assign(:show_modal, :none)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:event, Events.get_event!(id))}
  end

  @impl true
  def handle_event("add_cake", _params, socket) do
    {:noreply, socket |> assign(:show_modal, :add_cake_modal)}
  end

  @impl true
  def handle_info({BakeryWeb.CakeLive.FormComponent, {:saved, _cake}}, socket) do
    {:noreply, socket |> assign(:show_modal, :none)}
  end

  def count_cakes(event) do
    Events.cakes_for_event(event) |> Enum.count()
  end

  defp page_title(:show), do: "Show Event"
  defp page_title(:edit), do: "Edit Event"
end
