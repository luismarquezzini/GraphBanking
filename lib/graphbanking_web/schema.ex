defmodule GraphbankingWeb.Schema do
    use Absinthe.Schema
    import_types GraphbankingWeb.Schema.ContentTypes
  
    alias GraphbankingWeb.Resolvers
  
    query do
  
      @desc "Get all accounts"
      field :accounts, list_of(:account) do
        resolve &Resolvers.Bank.list_accounts/3
      end
  
    end
  
  end