defmodule GraphbankingWeb.Resolvers.Bank do

  def list_accounts(_parent, _args, _resolution) do
    {:ok, Graphbanking.Bank.list_accounts()}
  end

  def create_account(_parent, %{balance: balance}, _resolution) do
    Graphbanking.Bank.create_account(balance)
  end

end