defmodule GraphbankingWeb.Resolvers.Account do

    def list_transactions(%Graphbanking.Bank.Account{} = account, args, _resolution) do
        {:ok, Graphbanking.Account.list_transactions(account, args)}
    end
    
    def list_transactions(_parent, _args, _resolution) do
      {:ok, Graphbanking.Account.list_transactions()}
    end

    def transfer_money(_parent, %{sender: sender, address: address, amount: amount}, _resolution) do
        Graphbanking.Account.transfer_money(sender, address, amount)
    end
  
  end