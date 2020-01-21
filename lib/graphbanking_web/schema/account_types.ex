defmodule GraphbankingWeb.Schema.ContentTypes do
    use Absinthe.Schema.Notation
  
    object :account do
      field :id, :id
      field :current_balance, :float
    end
  end