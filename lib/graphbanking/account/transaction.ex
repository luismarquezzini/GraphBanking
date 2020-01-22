defmodule Graphbanking.Account.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "transactions" do
    field :amount, :float
    field :address, :binary_id

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:amount])
    |> validate_required([:amount])
  end
end
