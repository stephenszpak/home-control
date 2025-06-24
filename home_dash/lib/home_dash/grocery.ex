defmodule HomeDash.Grocery do
  use Ecto.Schema
  import Ecto.Changeset

  schema "groceries" do
    field :name, :string
    field :done, :boolean, default: false
    timestamps()
  end

  def changeset(grocery, attrs) do
    grocery
    |> cast(attrs, [:name, :done])
    |> validate_required([:name])
  end
end
