defmodule ReproduceWeb.ItemLive.Index do
  use ReproduceWeb, :live_view

  alias Reproduce.Resources
  alias Reproduce.Resources.Item

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :item_collection, list_item())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Item")
    |> assign(:item, Resources.get_item!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Item")
    |> assign(:item, %Item{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Item")
    |> assign(:item, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    item = Resources.get_item!(id)
    {:ok, _} = Resources.delete_item(item)

    {:noreply, assign(socket, :item_collection, list_item())}
  end

  defp list_item do
    Resources.list_item()
  end
end
