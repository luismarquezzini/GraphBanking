defmodule GraphbankingWeb.Schema.AccountTypes do
    use Absinthe.Schema.Notation
    use Absinthe.Ecto, repo: Graphbanking.Repo

    @desc "An account of the Bank"
    object :account do
      field :id, :id
      field :current_balance, :float
      field :transactions, list_of(:transaction), resolve: assoc(:transactions)
    end
  end