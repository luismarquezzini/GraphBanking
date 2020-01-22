defmodule GraphbankingWeb.Resolvers.Account do

    def list_transactions(_parent, _args, _resolution) do
      {:ok, Graphbanking.Account.list_transactions()}
    end
  
  end