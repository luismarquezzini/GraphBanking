defmodule GraphbankingWeb.Resolvers.Bank do

  def list_accounts(_parent, _args, _resolution) do
    {:ok, Graphbanking.Bank.list_accounts()}
  end

  def get_account(_parent, %{id: id}, _resolution) do
    case Graphbanking.Bank.get_account(id) do
      nil ->
        {:error, "Account ID #{id} not found"}
      account ->
        {:ok, account}
    end
  end

  def create_account(_parent, %{balance: balance}, _resolution) do
    Graphbanking.Bank.create_account(balance)
  end

end