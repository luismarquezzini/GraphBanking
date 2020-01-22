defmodule Graphbanking.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions, primary_key: false) do
      add :account_id, references("accounts", type: :binary_id)
      add :id, :uuid, primary_key: true
      add :amount, :float
      add :address, :string

      timestamps()
    end

    create index(:transactions, [:address])
  end
end
