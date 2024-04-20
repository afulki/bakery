defmodule BakeryWeb.CakeLive.FormComponent do
  use BakeryWeb, :live_component

  alias Bakery.Events

  @impl true
  def update(%{cake: cake, event_id: event_id} = assigns, socket) do
    changeset = Events.change_cake(cake, %{event_id: event_id})

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)
     |> IO.inspect(label: "changset in update")}
  end

  @impl true
  def handle_event("validate", %{"cake" => cake_params}, socket) do
    changeset =
      socket.assigns.cake
      |> Events.change_cake(cake_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"cake" => cake_params}, socket) do
    IO.inspect(socket.assigns, label: "assigns when saving")
    %{event_id: event_id} = socket.assigns
    cake_params = Map.put(cake_params, "event_id", event_id)
    save_cake(socket, socket.assigns.action, cake_params)
  end

  defp save_cake(socket, :edit, cake_params) do
    case Events.update_cake(socket.assigns.cake, cake_params) do
      {:ok, cake} ->
        notify_parent({:saved, cake})

        {:noreply,
         socket
         |> put_flash(:info, "Cake updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_cake(socket, :new, cake_params) do
    IO.inspect(cake_params, label: "Savign the dammed cake!")

    case Events.create_cake(cake_params) do
      {:ok, cake} ->
        notify_parent({:saved, cake})
        IO.puts("IT was saved!!!!")

        {:noreply,
         socket
         |> put_flash(:info, "Cake created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect(changeset, label: "sigh")
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
