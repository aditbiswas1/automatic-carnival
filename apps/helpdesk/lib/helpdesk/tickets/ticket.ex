defmodule Helpdesk.Tickets.Ticket do
  use Ecto.Schema
  import Ecto.Changeset
  import IEx
  alias Helpdesk.Tickets.Ticket
  alias Helpdesk.Repo
  schema "tickets" do
    field :subject, :string
    belongs_to :customer, Helpdesk.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Ticket{} = ticket, attrs) do
    ticket
    |> cast(attrs, [:subject])
    |> validate_required([:subject])
  end

  def create_changeset(%Ticket{} = ticket, attrs) do
    ticket
    |> cast(attrs, [:subject])
    |> put_assoc(:customer, attrs["customer"])
    |> validate_required([:subject, :customer])
  end
end
