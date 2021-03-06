defmodule HelpdeskWeb.TicketController do
  use HelpdeskWeb, :controller

  alias Helpdesk.Tickets
  alias Helpdesk.Tickets.Ticket

  action_fallback HelpdeskWeb.FallbackController

  def index(conn, _params) do
    tickets = Tickets.list_tickets()
    render(conn, "index.json", tickets: tickets)
  end

  def create(conn, %{"ticket" => ticket_params}) do
    with {:ok, %Ticket{} = ticket} <- Tickets.create_ticket(ticket_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ticket_path(conn, :show, ticket))
      |> render("show.json", ticket: ticket)
    end
  end

  def show(conn, %{"id" => id}) do
    ticket = Tickets.get_ticket!(id)
    render(conn, "show.json", ticket: ticket)
  end

  def update(conn, %{"id" => id, "ticket" => ticket_params}) do
    ticket = Tickets.get_ticket!(id)

    with {:ok, %Ticket{} = ticket} <- Tickets.update_ticket(ticket, ticket_params) do
      render(conn, "show.json", ticket: ticket)
    end
  end

  def delete(conn, %{"id" => id}) do
    ticket = Tickets.get_ticket!(id)
    with {:ok, %Ticket{}} <- Tickets.delete_ticket(ticket) do
      send_resp(conn, :no_content, "")
    end
  end
end
