defmodule Reproduce.Resources.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "product" do
    field :active, :boolean, default: false
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :active])
    |> validate_required([:name, :active])
  end
end
