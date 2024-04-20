defmodule BakeryWeb.FlavorLive.FormComponent do
  use BakeryWeb, :live_component

  alias Bakery.Ingredients

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage flavor records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="flavor-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Flavor</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{flavor: flavor} = assigns, socket) do
    changeset = Ingredients.change_flavor(flavor)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"flavor" => flavor_params}, socket) do
    changeset =
      socket.assigns.flavor
      |> Ingredients.change_flavor(flavor_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"flavor" => flavor_params}, socket) do
    save_flavor(socket, socket.assigns.action, flavor_params)
  end

  defp save_flavor(socket, :edit, flavor_params) do
    case Ingredients.update_flavor(socket.assigns.flavor, flavor_params) do
      {:ok, flavor} ->
        notify_parent({:saved, flavor})

        {:noreply,
         socket
         |> put_flash(:info, "Flavor updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_flavor(socket, :new, flavor_params) do
    case Ingredients.create_flavor(flavor_params) do
      {:ok, flavor} ->
        notify_parent({:saved, flavor})

        {:noreply,
         socket
         |> put_flash(:info, "Flavor created successfully")
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
