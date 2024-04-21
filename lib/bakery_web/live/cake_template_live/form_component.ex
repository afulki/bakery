defmodule BakeryWeb.CakeTemplateLive.FormComponent do
  use BakeryWeb, :live_component

  alias Bakery.Templates

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage cake_template records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="cake_template-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:serves]} type="text" label="Serves" />
        <.input field={@form[:tiers]} type="number" label="Tiers" />
        <.input field={@form[:shape]} type="text" label="Shape" />
        <.input field={@form[:style]} type="text" label="Style" />
        <.input field={@form[:price]} type="number" label="Price" step="any" />
        <.input field={@form[:image]} type="text" label="Image" />
        <.input field={@form[:t1_diam]} type="number" label="T1 diam" step="any" />
        <.input field={@form[:t2_diam]} type="number" label="T2 diam" step="any" />
        <.input field={@form[:t3_diam]} type="number" label="T3 diam" step="any" />
        <.input field={@form[:t4_diam]} type="number" label="T4 diam" step="any" />
        <.input field={@form[:t5_diam]} type="number" label="T5 diam" step="any" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Cake template</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{cake_template: cake_template} = assigns, socket) do
    changeset = Templates.change_cake_template(cake_template)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"cake_template" => cake_template_params}, socket) do
    changeset =
      socket.assigns.cake_template
      |> Templates.change_cake_template(cake_template_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"cake_template" => cake_template_params}, socket) do
    save_cake_template(socket, socket.assigns.action, cake_template_params)
  end

  defp save_cake_template(socket, :edit, cake_template_params) do
    case Templates.update_cake_template(socket.assigns.cake_template, cake_template_params) do
      {:ok, cake_template} ->
        notify_parent({:saved, cake_template})

        {:noreply,
         socket
         |> put_flash(:info, "Cake template updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_cake_template(socket, :new, cake_template_params) do
    case Templates.create_cake_template(cake_template_params) do
      {:ok, cake_template} ->
        notify_parent({:saved, cake_template})

        {:noreply,
         socket
         |> put_flash(:info, "Cake template created successfully")
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
