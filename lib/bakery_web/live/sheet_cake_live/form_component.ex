defmodule BakeryWeb.SheetCakeLive.FormComponent do
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
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage sheet_cake records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="sheet_cake-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input
          field={@form[:name]}
          type="select"
          prompt="Select Size"
          options={[
            {"1/4 Sheet, serves 25", "1/4 Sheet, serves 25"},
            {"1/2 Sheet, serves 50", "1/2 Sheet, serves 50"},
            {"3/4 Sheet, serves 75", "3/4 Sheet, serves 75"},
            {"Full Sheet, serves 100", "Full Sheet, serves 100"}
          ]}
        />
        <.input field={@form[:quantity]} type="number" label="Quantity" />
        <.input disabled field={@form[:price]} type="number" label="Price $" step="any" />
        <.input
          field={@form[:flavor_id]}
          type="select"
          options={@flavors}
          label="Flavor"
          prompt="Choose Flavor"
        />
        <.input
          field={@form[:filling_id]}
          type="select"
          options={@fillings}
          label="Filling"
          prompt="Choose Filling"
        />
        <:actions>
          <.button phx-disable-with="Saving...">Save Sheet cake</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{sheet_cake: sheet_cake, event_id: event_id} = assigns, socket) do
    changeset = Events.change_sheet_cake(sheet_cake, %{event_id: event_id})

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"sheet_cake" => sheet_cake_params}, socket) do
    %{"quantity" => quantity, "name" => name} = sheet_cake_params |> IO.inspect(label: "HERE!!!")
    price = price_for_quantity(quantity, name)

    sheet_cake_params =
      sheet_cake_params
      |> Map.put("price", price)

    changeset =
      socket.assigns.sheet_cake
      |> Events.change_sheet_cake(sheet_cake_params)
      |> IO.inspect()
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"sheet_cake" => sheet_cake_params}, socket) do
    %{"quantity" => quantity, "name" => name} = sheet_cake_params |> IO.inspect(label: "HERE!!!")
    price = price_for_quantity(quantity, name)

    sheet_cake_params =
      sheet_cake_params
      |> Map.put("price", price)
      |> Map.put("event_id", socket.assigns.event_id)

    save_sheet_cake(socket, socket.assigns.action, sheet_cake_params)
  end

  defp save_sheet_cake(socket, :edit, sheet_cake_params) do
    case Events.update_sheet_cake(socket.assigns.sheet_cake, sheet_cake_params) do
      {:ok, sheet_cake} ->
        notify_parent({:saved, sheet_cake})

        {:noreply,
         socket
         |> put_flash(:info, "Sheet cake updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_sheet_cake(socket, :new, sheet_cake_params) do
    case Events.create_sheet_cake(sheet_cake_params) do
      {:ok, sheet_cake} ->
        notify_parent({:saved, sheet_cake})

        {:noreply,
         socket
         |> put_flash(:info, "Sheet cake created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp flavors do
    Ingredients.list_flavors()
    |> Enum.map(&{&1.name, &1.id})
  end

  defp fillings do
    Ingredients.list_fillings()
    |> Enum.map(&{&1.name, &1.id})
  end

  defp price_for_quantity(qty, "1/4 Sheet, serves 25"), do: calc_price(qty, "25")
  defp price_for_quantity(qty, "1/2 Sheet, serves 50"), do: calc_price(qty, "50")
  defp price_for_quantity(qty, "3/4 Sheet, serves 75"), do: calc_price(qty, "75")
  defp price_for_quantity(qty, "Full Sheet, serves 100"), do: calc_price(qty, "100")

  defp calc_price(qty, serves) do
    Decimal.new(serves) |> Decimal.mult(Decimal.new(qty)) |> Decimal.mult(Decimal.new("4.5"))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
