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

        @desc "Transfers between accounts"
        field :transfer_money, type: :transaction do
            arg :sender, non_null(:string)
            arg :address, non_null(:string)
            arg :amount, non_null(:float)

            resolve &Resolvers.Account.transfer_money/3
        end
      
    end
  
    query do
      @desc "Get all transactions"
      field :transactions, list_of(:transaction) do
        resolve &Resolvers.Account.list_transactions/3
      end

      @desc "Get an account"
      field :account, :account do
        arg :id, non_null(:id)
        resolve &Resolvers.Bank.get_account/3
      end  
  
      @desc "Get all accounts"
      field :accounts, list_of(:account) do
        resolve &Resolvers.Bank.list_accounts/3
      end
  
    end
  
  end