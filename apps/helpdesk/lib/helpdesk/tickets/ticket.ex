defmodule Helpdesk.Tickets.Ticket do
  use Ecto.Schema
  import Ecto.Changeset
  alias Helpdesk.Tickets.Ticket


  schema "tickets" do
    field :subject, :string
    field :customer_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Ticket{} = ticket, attrs) do
    ticket
    |> cast(attrs, [:subject])
    |> validate_required([:subject])
  end
end
