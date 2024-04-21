defmodule BakeryWeb.EventLive.Show do
  use BakeryWeb, :live_view

  alias Bakery.Events
  alias Bakery.Events.Cake

  @impl true
  def mount(_params, _session, socket) do
    assigns =
      socket
      |> assign(:show_modal, :none)

    {:ok, assigns}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:event, Events.get_event!(id))
     |> assign_cart()}
  end

  @impl true
  def handle_event("add_cake", _params, socket) do
    {:noreply, socket |> assign(:show_modal, :add_cake_modal)}
  end

  @impl true
  def handle_event("add_sheetcake", _params, socket) do
    {:noreply, socket |> assign(:show_modal, :add_sheetcake_modal)}
  end

  @impl true
  def handle_info({BakeryWeb.CakeLive.FormComponent, {:saved, _cake}}, socket) do
    {:noreply, socket |> assign(:show_modal, :none)}
  end

  @impl true
  def handle_info({BakeryWeb.SheetCakeLive.FormComponent, {:saved, _cake}}, socket) do
    {:noreply, socket |> assign(:show_modal, :none)}
  end

  def count_cakes(event) do
    Events.cakes_for_event(event) |> Enum.count()
  end

  def assign_cart(socket) do
    event = socket.assigns.event

    cakes = Events.cakes_for_event(event)
    cakes_subtotal = calc_cake_subtotal(cakes)

    sheetcakes = Events.sheetcakes_for_event(event)
    sheetcakes_subtotal = calc_sheetcake_subtotal(sheetcakes)

    sub_total = sum([cakes_subtotal, sheetcakes_subtotal])
    tax = Decimal.new("0.115") |> Decimal.mult(sub_total) |> Decimal.round(2)
    total = Decimal.add(sub_total, tax)

    socket
    |> assign(
      cart: %{
        cakes: cakes,
        sheet_cakes: sheetcakes,
        cupcakes: [],
        cakes_count: count_cakes(socket.assigns.event),
        cupcakes_count: 0,
        sheet_cakes_count: Enum.count(sheetcakes),
        sub_total: sub_total,
        tax: tax,
        total: total
      }
    )
  end

  defp page_title(:show), do: "Show Event"
  defp page_title(:edit), do: "Edit Event"

  defp sum(values) do
    Enum.reduce(values, Decimal.new(1, 0, 0), fn v, acc -> Decimal.add(acc, v) end)
  end

  defp calc_cake_subtotal([]), do: Decimal.new("0.00")

  defp calc_cake_subtotal(cakes) do
    Enum.reduce(cakes, Decimal.new(1, 0, 0), fn cake, acc ->
      cake_subtotal = Cake.sub_total(cake)
      Decimal.add(acc, cake_subtotal)
    end)
  end

  defp calc_sheetcake_subtotal([]), do: Decimal.new("0.00")

  defp calc_sheetcake_subtotal(cakes) do
    Enum.reduce(cakes, Decimal.new(1, 0, 0), fn cake, acc ->
      Decimal.add(acc, cake.price)
    end)
  end
end
