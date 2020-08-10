defmodule Reproduce.ResourcesTest do
  use Reproduce.DataCase

  alias Reproduce.Resources

  describe "item" do
    alias Reproduce.Resources.Item

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def item_fixture(attrs \\ %{}) do
      {:ok, item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Resources.create_item()

      item
    end

    test "list_item/0 returns all item" do
      item = item_fixture()
      assert Resources.list_item() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Resources.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      assert {:ok, %Item{} = item} = Resources.create_item(@valid_attrs)
      assert item.name == "some name"
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Resources.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      assert {:ok, %Item{} = item} = Resources.update_item(item, @update_attrs)
      assert item.name == "some updated name"
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Resources.update_item(item, @invalid_attrs)
      assert item == Resources.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Resources.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Resources.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Resources.change_item(item)
    end
  end

  describe "product" do
    alias Reproduce.Resources.Product

    @valid_attrs %{active: true, name: "some name"}
    @update_attrs %{active: false, name: "some updated name"}
    @invalid_attrs %{active: nil, name: nil}

    def product_fixture(attrs \\ %{}) do
      {:ok, product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Resources.create_product()

      product
    end

    test "list_product/0 returns all product" do
      product = product_fixture()
      assert Resources.list_product() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Resources.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      assert {:ok, %Product{} = product} = Resources.create_product(@valid_attrs)
      assert product.active == true
      assert product.name == "some name"
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Resources.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      assert {:ok, %Product{} = product} = Resources.update_product(product, @update_attrs)
      assert product.active == false
      assert product.name == "some updated name"
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Resources.update_product(product, @invalid_attrs)
      assert product == Resources.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Resources.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Resources.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Resources.change_product(product)
    end
  end
end
