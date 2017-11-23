defmodule HelpdeskWeb.TicketControllerTest do
  use HelpdeskWeb.ConnCase

  alias Helpdesk.Tickets
  alias Helpdesk.Tickets.Ticket

  @create_attrs  %{"subject" => "some subject",
                  "customer" => %{
                      "email" =>"abc@gmail.com",
                      "name" => "hello",
                    }
                  }
  @update_attrs %{"subject"=> "some updated subject"}
  @invalid_attrs %{"subject" => nil}

  def fixture(:ticket) do
    {:ok, ticket} = Tickets.create_ticket(@create_attrs)
    ticket
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all tickets", %{conn: conn} do
      conn = get conn, ticket_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create ticket" do
    test "renders ticket when data is valid", %{conn: conn} do
      conn = post conn, ticket_path(conn, :create), ticket: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, ticket_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "subject" => "some subject"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, ticket_path(conn, :create), ticket: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update ticket" do
    setup [:create_ticket]

    test "renders ticket when data is valid", %{conn: conn, ticket: %Ticket{id: id} = ticket} do
      conn = put conn, ticket_path(conn, :update, ticket), ticket: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, ticket_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "subject" => "some updated subject"}
    end

    test "renders errors when data is invalid", %{conn: conn, ticket: ticket} do
      conn = put conn, ticket_path(conn, :update, ticket), ticket: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete ticket" do
    setup [:create_ticket]

    test "deletes chosen ticket", %{conn: conn, ticket: ticket} do
      conn = delete conn, ticket_path(conn, :delete, ticket)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, ticket_path(conn, :show, ticket)
      end
    end
  end

  defp create_ticket(_) do
    ticket = fixture(:ticket)
    {:ok, ticket: ticket}
  end
end
