defmodule Helpdesk.Repo.Migrations.CreateTickets do
  use Ecto.Migration

  def change do
    create table(:tickets) do
      add :subject, :string
      add :customer_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:tickets, [:customer_id])
  end
end
