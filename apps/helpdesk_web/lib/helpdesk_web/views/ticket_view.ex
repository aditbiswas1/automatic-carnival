defmodule HelpdeskWeb.TicketView do
  use HelpdeskWeb, :view
  alias HelpdeskWeb.TicketView

  def render("index.json", %{tickets: tickets}) do
    %{data: render_many(tickets, TicketView, "ticket.json")}
  end

  def render("show.json", %{ticket: ticket}) do
    %{data: render_one(ticket, TicketView, "ticket.json")}
  end

  def render("ticket.json", %{ticket: ticket}) do
    %{id: ticket.id,
      subject: ticket.subject}
  end
end
