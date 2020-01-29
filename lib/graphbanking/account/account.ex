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
        from(t in Graphbanking.Account.Transaction, where: t.account_id == ^account.id)
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
    Transfer money between accounts
        ## Examples
  
        iex> transfer_money(ccf15997-0674-4507-b01f-9f8d54fb55d5, 5835bd5b-7f91-4209-99b2-e2f6870f70e4, 20)
        {:ok, %{sender: sender, receiver: address, amount: amount, msg: "Succesful Transfer!"}}

        iex> transfer_money(ccf15997-0674-4507-b01f-9f8d54fb55d5, 5835bd5b-7f91-4209-99b2-e2f6870f70e4, -10)
        {:error, "Can't transfer negative values"}

        iex> transfer_money(ccf15997-0674-4507-b01f-9f8d54fb55d5, 5835bd5b-7f91-4209-99b2-e2f6870f70e4, amount greater than the account balance)
        {:error, "you can't transfer money to yourself"}

        iex> transfer_money(ccf15997-0674-4507-b01f-9f8d54fb55d5, ccf15997-0674-4507-b01f-9f8d54fb55d5, 20)
        {:error, "you can't transfer money to yourself"}
  
    """
    def transfer_money(attrs \\ %{}, sender, address, amount) do
      if(amount < 0) do
        {:error, "Can't transfer negative values"}
      else
        sender_account = Graphbanking.Bank.get_account(sender)
        receiver_account = Graphbanking.Bank.get_account(address)
        sender_amount = sender_account.current_balance
        receiver_amount = receiver_account.current_balance
        updatedvalue_sender = sender_amount - amount
        updatedvalue_receiver = receiver_amount + amount

        if(updatedvalue_sender < 0) do
          {:error, "You don't have sufficient Money"}
        else

          if(sender == address) do
            {:error, "you can't transfer money to yourself"}
          else
            %Transaction{account_id: sender, address: address, amount: amount}
            |> Transaction.changeset(attrs)
            |> Repo.insert()
            Graphbanking.Bank.update_account(sender_account, %{current_balance: updatedvalue_sender})
            Graphbanking.Bank.update_account(receiver_account, %{current_balance: updatedvalue_receiver})
            {:ok, %{sender: sender, receiver: address, amount: amount, msg: "Succesful Transfer!"}}
          end

        end
      
      end

    end

    @doc """
    Creates a Transaction.
  
    ## Examples
  
        iex> create_transaction(%{field: value})
        {:ok, %Account{}}
  
        iex> create_transaction(%{field: bad_value})
        {:error, %Ecto.Changeset{}}
  
    """

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