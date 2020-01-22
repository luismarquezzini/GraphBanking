defmodule GraphbankingWeb.Schema.TransactionTypes do
    use Absinthe.Schema.Notation

    @desc "A Bank Transaction"
    object :transaction do
      field :id, :id
      field :address, :string
      field :amount, :float
      field :account_id, :account
      field :receiver, :string
      field :sender, :string
      field :msg, :string
    end
  end