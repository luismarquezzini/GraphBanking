defmodule Graphbanking.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :amount, :float
      add :address, references(:accounts, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:transactions, [:address])
  end
end
