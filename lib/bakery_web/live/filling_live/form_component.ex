defmodule BakeryWeb.FillingLive.FormComponent do
  use BakeryWeb, :live_component

  alias Bakery.Ingredients

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage filling records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="filling-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Filling</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{filling: filling} = assigns, socket) do
    changeset = Ingredients.change_filling(filling)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"filling" => filling_params}, socket) do
    changeset =
      socket.assigns.filling
      |> Ingredients.change_filling(filling_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"filling" => filling_params}, socket) do
    save_filling(socket, socket.assigns.action, filling_params)
  end

  defp save_filling(socket, :edit, filling_params) do
    case Ingredients.update_filling(socket.assigns.filling, filling_params) do
      {:ok, filling} ->
        notify_parent({:saved, filling})

        {:noreply,
         socket
         |> put_flash(:info, "Filling updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_filling(socket, :new, filling_params) do
    case Ingredients.create_filling(filling_params) do
      {:ok, filling} ->
        notify_parent({:saved, filling})

        {:noreply,
         socket
         |> put_flash(:info, "Filling created successfully")
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
