defmodule GraphbankingWeb.Schema do
    use Absinthe.Schema

    import_types GraphbankingWeb.Schema.AccountTypes
    import_types GraphbankingWeb.Schema.TransactionTypes
  
    alias GraphbankingWeb.Resolvers

    mutation do

        @desc "Create an account"
        field :create_account, type: :account do
          arg :balance, non_null(:float)

          resolve &Resolvers.Bank.create_account/3
        end
      
    end
  
    query do
      @desc "Get all transactions"
      field :transactions, list_of(:transaction) do
        resolve &Resolvers.Bank.list_accounts/3
      end
  
      @desc "Get all accounts"
      field :accounts, list_of(:account) do
        resolve &Resolvers.Bank.list_accounts/3
      end
  
    end
  
  end