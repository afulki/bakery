defmodule BakeryWeb.CakeTemplateLive.Index do
  use BakeryWeb, :live_view

  alias Bakery.Templates
  alias Bakery.Templates.CakeTemplate

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :cake_templates, Templates.list_cake_templates())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Cake template")
    |> assign(:cake_template, Templates.get_cake_template!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Cake template")
    |> assign(:cake_template, %CakeTemplate{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Cake templates")
    |> assign(:cake_template, nil)
  end

  @impl true
  def handle_info({BakeryWeb.CakeTemplateLive.FormComponent, {:saved, cake_template}}, socket) do
    {:noreply, stream_insert(socket, :cake_templates, cake_template)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    cake_template = Templates.get_cake_template!(id)
    {:ok, _} = Templates.delete_cake_template(cake_template)

    {:noreply, stream_delete(socket, :cake_templates, cake_template)}
  end
end
