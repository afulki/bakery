defmodule BakeryWeb.VenueLive.FormComponent do
  use BakeryWeb, :live_component

  alias Bakery.Venues

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage venue records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="venue-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:street]} type="text" label="Street" />
        <.input field={@form[:city]} type="text" label="City" />
        <.input field={@form[:state]} type="text" label="State" />
        <.input field={@form[:zip]} type="text" label="Zip" />
        <.input field={@form[:contact]} type="text" label="Contact" />
        <.input field={@form[:phone]} type="text" label="Phone" />
        <.input field={@form[:email]} type="text" label="Email" />
        <.input field={@form[:distance_in_miles]} type="number" label="Distance in miles" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Venue</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{venue: venue} = assigns, socket) do
    changeset = Venues.change_venue(venue)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"venue" => venue_params}, socket) do
    changeset =
      socket.assigns.venue
      |> Venues.change_venue(venue_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"venue" => venue_params}, socket) do
    save_venue(socket, socket.assigns.action, venue_params)
  end

  defp save_venue(socket, :edit, venue_params) do
    case Venues.update_venue(socket.assigns.venue, venue_params) do
      {:ok, venue} ->
        notify_parent({:saved, venue})

        {:noreply,
         socket
         |> put_flash(:info, "Venue updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_venue(socket, :new, venue_params) do
    case Venues.create_venue(venue_params) do
      {:ok, venue} ->
        notify_parent({:saved, venue})

        {:noreply,
         socket
         |> put_flash(:info, "Venue created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
