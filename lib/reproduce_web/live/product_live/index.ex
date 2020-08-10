defmodule ReproduceWeb.ProductLive.Index do
  use ReproduceWeb, :live_view

  alias Reproduce.Resources
  alias Reproduce.Resources.Product

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :product_collection, list_product())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Product")
    |> assign(:product, Resources.get_product!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Product")
    |> assign(:product, %Product{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Product")
    |> assign(:product, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    product = Resources.get_product!(id)
    {:ok, _} = Resources.delete_product(product)

    {:noreply, assign(socket, :product_collection, list_product())}
  end

  defp list_product do
    Resources.list_product()
  end
end
