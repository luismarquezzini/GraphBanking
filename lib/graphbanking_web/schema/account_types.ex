defmodule GraphbankingWeb.Schema.AccountTypes do
    use Absinthe.Schema.Notation

    @desc "An account of the Bank"
    object :account do
      field :id, :id
      field :current_balance, :float
      field :transactions, list_of(:transaction)
    end
  end