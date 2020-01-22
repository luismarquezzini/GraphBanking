defmodule GraphbankingWeb.Schema.TransactionTypes do
    use Absinthe.Schema.Notation

    @desc "A Bank Transaction"
    object :transaction do
      field :id, :id
      field :address, :account
      field :amount, :float
    end
  end