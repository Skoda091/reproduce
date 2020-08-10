defmodule ReproduceWeb.ItemLive.FormComponent do
  use ReproduceWeb, :live_component

  alias Reproduce.Resources

  @impl true
  def update(%{item: item} = assigns, socket) do
    changeset = Resources.change_item(item)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:disabled, true)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"item" => item_params}, socket) do
    IO.inspect("1", label: "LABEL")

    changeset =
      socket.assigns.item
      |> Resources.change_item(item_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("validate", _params, socket) do
    IO.inspect("2", label: "LABEL")

    {:noreply, assign(socket, :disabled, false)}
  end

  def handle_event("save", %{"item" => item_params}, socket) do
    save_item(socket, socket.assigns.action, item_params)
  end

  defp save_item(socket, :edit, item_params) do
    case Resources.update_item(socket.assigns.item, item_params) do
      {:ok, _item} ->
        {:noreply,
         socket
         |> put_flash(:info, "Item updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_item(socket, :new, item_params) do
    case Resources.create_item(item_params) do
      {:ok, _item} ->
        {:noreply,
         socket
         |> put_flash(:info, "Item created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
