defmodule Graphbanking.Bank.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    field :current_balance, :float

    has_many(:transactions, Graphbanking.Account.Transaction, foreign_key: :account_id)
    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:current_balance])
    |> validate_required([:current_balance])
  end
end
