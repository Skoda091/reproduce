defmodule Reproduce.Repo.Migrations.CreateProduct do
  use Ecto.Migration

  def change do
    create table(:product) do
      add :name, :string
      add :active, :boolean, default: false, null: false

      timestamps()
    end

  end
end
