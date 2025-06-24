defmodule HomeDash.Groceries do
  alias HomeDash.{Grocery, Repo}

  def list_groceries do
    Repo.all(Grocery)
  end

  def create_grocery(attrs) do
    %Grocery{}
    |> Grocery.changeset(attrs)
    |> Repo.insert()
  end
end
