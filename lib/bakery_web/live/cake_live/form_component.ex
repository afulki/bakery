defmodule BakeryWeb.CakeLive.FormComponent do
  use BakeryWeb, :live_component

  alias Bakery.Events
  alias Bakery.Ingredients

  @impl true
  def mount(socket) do
    {
      :ok,
      assign(socket, flavors: flavors(), fillings: fillings())
    }
  end

  @impl true
  def update(%{cake: cake, event_id: event_id} = assigns, socket) do
    changeset = Events.change_cake(cake, %{event_id: event_id})

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"cake" => cake_params}, socket) do
    cake_params =
      cake_params
      |> IO.inspect(label: "Cake Params on Validate")
      |> update_cake_params()

    changeset =
      socket.assigns.cake
      |> Events.change_cake(cake_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"cake" => cake_params}, socket) do
    %{event_id: event_id} = socket.assigns
    cake_params = Map.put(cake_params, "event_id", event_id)
    save_cake(socket, socket.assigns.action, cake_params)
  end

  def cake_image(assigns) do
    ~H"""
    <div class="flex items-center justify-center">
      <.svg name={@cake_image} class="pt-4 sm:w-32 sm:h-32 lg:w-64 lg:h-64 " />
    </div>
    """
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
    case Events.create_cake(cake_params) do
      {:ok, cake} ->
        notify_parent({:saved, cake})

        {:noreply,
         socket
         |> put_flash(:info, "Cake created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp update_cake_params(
         %{"shape" => shape, "style" => style, "num_guests" => num_guests} = cake_params
       ) do
    cake_template =
      find_template(num_guests, style, shape) || find_template("25", "single", "round")

    cake_params
    |> Map.put("tiers", cake_template.tiers)
    |> Map.put("base_price", cake_template.price)
    |> IO.inspect(label: "Updated params")
  end

  # defp assign_updated_cake(socket) do
  #   cake = socket.assigns.cake
  #
  #   %{
  #     "cake_shape" => cake_shape,
  #     "cake_style" => cake_style,
  #     "number_of_guests" => number_of_guests
  #   } = cake
  #
  #   cake_template =
  #     find_template(number_of_guests, cake_style, cake_shape) ||
  #       find_template("25", "single", "round")
  #
  #   cake =
  #     cake
  #     |> Map.put("base_price", cake_template.price)
  #
  #   payment =
  #     socket.assigns.payment
  #     |> Map.put("cake_price", cake_template.price)
  #     |> assign_calculated_fields(socket)
  #
  #   socket
  #   |> assign(:cake_template, cake_template)
  #   |> assign(:cake, cake)
  #   |> assign(:number_of_tiers, cake_template.tiers)
  #   |> assign(:cake_image, name_from_template(cake_template))
  #   |> assign(:payment, payment)
  # end

  defp find_template(number_of_guests, style, shape) do
    Bakery.Templates.find_template(number_of_guests, style, shape)
  end

  # defp name_from_template(%Bakery.Templates.CakeTemplate{} = template) do
  #   case template.image do
  #     nil -> "default"
  #     image -> image |> Path.basename(".svg")
  #   end
  # end

  defp flavors do
    Ingredients.list_flavors()
    |> Enum.map(&{&1.name, &1.id})
  end

  defp fillings do
    Ingredients.list_fillings()
    |> Enum.map(&{&1.name, &1.id})
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
