defmodule Helpdesk.TicketsTest do
  use Helpdesk.DataCase
  alias Helpdesk.Tickets

  describe "tickets" do
    alias Helpdesk.Tickets.Ticket
    alias Helpdesk.AccountsTest, as: AccountsTest
    @valid_attrs %{ subject: "some subject",
                    customer: %{
                        email: "abc@gmail.com",
                        name: "hello",
                      }
                    }
    @update_attrs %{subject: "some updated subject"}
    @invalid_attrs %{subject: nil, customer: %{}}

    def ticket_fixture(attrs \\ %{}) do
      user = AccountsTest.user_fixture()
      params = Map.merge(%{customer: user}, @valid_attrs)
      {:ok, ticket} =
        attrs
        |> Enum.into(params)
        |> Tickets.create_ticket()
      ticket
    end

    test "list_tickets/0 returns all tickets" do
      ticket = ticket_fixture()
      assert Tickets.list_tickets() == [ticket]
    end

    test "get_ticket!/1 returns the ticket with given id" do
      ticket = ticket_fixture()
      assert Tickets.get_ticket!(ticket.id) == ticket
    end

    test "create_ticket/1 with valid data creates a ticket" do
      assert {:ok, %Ticket{} = ticket} = Tickets.create_ticket(@valid_attrs)
      assert ticket.subject == "some subject"
    end

    test "create_ticket/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tickets.create_ticket(@invalid_attrs)
    end

    test "create_ticket/1 called multiple times with same user creates tickets" do
      old_ticket = ticket_fixture()
      user = old_ticket.customer
      assert {:ok, %Ticket{} = ticket}  = Tickets.create_ticket(%{customer: user, subject: "abca"})
      assert Tickets.get_ticket!(ticket.id) == ticket
    end

    test "update_ticket/2 with valid data updates the ticket" do
      ticket = ticket_fixture()
      user = ticket.customer.id
      assert {:ok, ticket} = Tickets.update_ticket(ticket, @update_attrs)
      assert %Ticket{} = ticket
      assert ticket.customer.id == user
      assert ticket.subject == "some updated subject"
    end

    test "update_ticket/2 with invalid data returns error changeset" do
      ticket = ticket_fixture()
      assert {:error, %Ecto.Changeset{}} = Tickets.update_ticket(ticket, @invalid_attrs)
      assert ticket == Tickets.get_ticket!(ticket.id)
    end

    test "delete_ticket/1 deletes the ticket" do
      ticket = ticket_fixture()
      assert {:ok, %Ticket{}} = Tickets.delete_ticket(ticket)
      assert_raise Ecto.NoResultsError, fn -> Tickets.get_ticket!(ticket.id) end
    end

    test "change_ticket/1 returns a ticket changeset" do
      ticket = ticket_fixture()
      assert %Ecto.Changeset{} = Tickets.change_ticket(ticket)
    end
  end
end
