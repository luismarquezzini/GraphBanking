defmodule GraphbankingWeb.Resolvers.Bank do

  def list_accounts(_parent, _args, _resolution) do
    {:ok, Graphbanking.Bank.list_accounts()}
  end

end