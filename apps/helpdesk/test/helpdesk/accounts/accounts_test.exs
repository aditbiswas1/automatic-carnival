defmodule Helpdesk.AccountsTest do
  use Helpdesk.DataCase

  alias Helpdesk.Accounts
  @valid_attrs %{email: "email@email.com", name: "some name"}
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(@valid_attrs)
      |> Accounts.create_user()

    user
  end
  describe "users" do
    alias Helpdesk.Accounts.User

    @valid_attrs_2 %{email: "email2#@email.com", name: "some name2"}
    @update_attrs %{email: "email2@email.com", name: "some updated name"}
    @invalid_attrs %{email: nil, name: nil}
    @duplicate_email_attrs %{email: "email@email.com", name: "some name"}


    def secod_user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs_2)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "email@email.com"
      assert user.name == "some name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "create_user/1 with duplicate email returns error changeset" do
      _user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@duplicate_email_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "email2@email.com"
      assert user.name == "some updated name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "update_user/2 with duplicate email data returns error changeset" do
      _user = user_fixture()
      user_2 = secod_user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user_2, @duplicate_email_attrs)
      assert user_2 == Accounts.get_user!(user_2.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end

    test "get_or_create_user/1 creates user when user does not exist" do
      {:ok, user} = Accounts.get_or_create_user(@valid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "get_or_create_user/1 returns user when user is present" do
      user = user_fixture()
      {:ok, fetched_user} = Accounts.get_or_create_user(%{"email" => user.email})
      assert fetched_user == user
    end

    test "get_or_create_user/1 returns ecto error with invalid params" do
      {:error, %Ecto.Changeset{}} = Accounts.get_or_create_user(@invalid_attrs)
    end
  end
end
