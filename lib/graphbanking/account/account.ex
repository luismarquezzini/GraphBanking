defmodule Graphbanking.Account do
    @moduledoc """
    The Account context.
    """
  
    import Ecto.Query, warn: false
    alias Graphbanking.Repo
  
    alias Graphbanking.Account.Transaction
  
    @doc """
    Returns the list of transactions.
  
    ## Examples
  
        iex> list_transactions()
        [%Transaction{}, ...]
  
    """

    def list_transactions(account, _) do
        from(t in Graphbanking.Account.Transaction, where: t.address == ^account.id)
        |> Repo.all
    end

    def list_transactions do
      Repo.all(Transaction)
    end
  
    @doc """
    Gets a single transaction.
  
    Raises `Ecto.NoResultsError` if the Transaction does not exist.
  
    ## Examples
  
        iex> get_transaction!(123)
        %Transaction{}
  
        iex> get_transaction!(456)
        ** (Ecto.NoResultsError)
  
    """
    def get_transaction!(id), do: Repo.get!(Transaction, id)
  
    @doc """
    Creates a Transaction.
  
    ## Examples
  
        iex> create_transaction(%{field: value})
        {:ok, %Account{}}
  
        iex> create_transaction(%{field: bad_value})
        {:error, %Ecto.Changeset{}}
  
    """
    def transfer_money(attrs \\ %{}, sender, address, amount) do
      if(amount < 0) do
        {:error, "Can't transfer negative values"}
      else
        senderaccount = Graphbanking.Bank.get_account(sender)
        receiveraccount = Graphbanking.Bank.get_account(address)
        senderamount = senderaccount.current_balance
        receiveramount = receiveraccount.current_balance
        updatedvalue_sender = senderamount - amount
        updatedvalue_receiver = receiveramount + amount
        if(updatedvalue_sender < 0) do
          {:error, "You don't have sufficient Money"}
        else

          if(sender == address) do
            {:error, "you can't transfer money to yourself"}
          else
            %Transaction{account_id: sender, address: address, amount: amount}
            |> Transaction.changeset(attrs)
            |> Repo.insert()
            Graphbanking.Bank.update_account(senderaccount, %{current_balance: updatedvalue_sender})
            Graphbanking.Bank.update_account(receiveraccount, %{current_balance: updatedvalue_receiver})
            {:ok, %{sender: sender, receiver: address, amount: amount, msg: "Transferido com sucesso"}}
          end

        end
      
      end

    end

    def create_transaction(attrs \\ %{}) do
      %Transaction{}
      |> Transaction.changeset(attrs)
      |> Repo.insert()
    end
  
    @doc """
    Updates a transaction.
  
    ## Examples
  
        iex> update_transaction(account, %{field: new_value})
        {:ok, %Account{}}
  
        iex> update_transaction(account, %{field: bad_value})
        {:error, %Ecto.Changeset{}}
  
    """
    def update_transaction(%Transaction{} = transaction, attrs) do
      transaction
      |> Transaction.changeset(attrs)
      |> Repo.update()
    end
  
    @doc """
    Deletes a Transaction.
  
    ## Examples
  
        iex> delete_transaction(transaction)
        {:ok, %Transaction{}}
  
        iex> delete_transaction(transaction)
        {:error, %Ecto.Changeset{}}
  
    """
    def delete_transaction(%Transaction{} = transaction) do
      Repo.delete(transaction)
    end
  
    @doc """
    Returns an `%Ecto.Changeset{}` for tracking transaction changes.
  
    ## Examples
  
        iex> change_transaction(transaction)
        %Ecto.Changeset{source: %Transaction{}}
  
    """

    def change_transaction(%Transaction{} = transaction) do
      Transaction.changeset(transaction, %{})
    end
  end