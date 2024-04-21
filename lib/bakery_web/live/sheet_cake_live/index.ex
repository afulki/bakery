defmodule BakeryWeb.SheetCakeLive.Index do
  use BakeryWeb, :live_view

  alias Bakery.Events
  alias Bakery.Events.SheetCake

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :sheet_cakes, Events.list_sheet_cakes())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Sheet cake")
    |> assign(:sheet_cake, Events.get_sheet_cake!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Sheet cake")
    |> assign(:sheet_cake, %SheetCake{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Sheet cakes")
    |> assign(:sheet_cake, nil)
  end

  @impl true
  def handle_info({BakeryWeb.SheetCakeLive.FormComponent, {:saved, sheet_cake}}, socket) do
    {:noreply, stream_insert(socket, :sheet_cakes, sheet_cake)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    sheet_cake = Events.get_sheet_cake!(id)
    {:ok, _} = Events.delete_sheet_cake(sheet_cake)

    {:noreply, stream_delete(socket, :sheet_cakes, sheet_cake)}
  end
end
