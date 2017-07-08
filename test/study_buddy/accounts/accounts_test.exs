defmodule StudyBuddy.AccountsTest do
  use StudyBuddy.DataCase

  alias StudyBuddy.Accounts
  alias StudyBuddy.Accounts.User

  ExUnit.configure exclude: :pending, trace: true

  describe "registrations" do

    @valid_registration_attrs %{email: "email@example.com", first_name: "some first name", last_name: "some last name",
                                password: "password", username: "some username"}
    @invalid_registrations_attrs %{email: 1, first_name: ["awesome"], last_name: ["cool"], password: 1, username: nil}
    @update_attrs %{email: "some updated email", name: "some updated name", username: "new_username"}
    @invalid_attrs %{email: nil, name: nil, username: nil}

    def user_fixture(_attrs \\ %{}) do
      {:ok, user} = Accounts.register_user(@valid_registration_attrs)
      user
    end

    test "register_user/1 creates a new user" do
      Accounts.register_user(@valid_registration_attrs)
      assert Accounts.list_users() |> length() == 1
    end

    test "A registration with a first_name and last_name attr should be appended to constitute the name attr of the created user" do
      user = user_fixture()
      assert user.name == "some first name some last name"
    end

    test "Users cannot register with bogus emails" do
      register_with = Map.put(@valid_registration_attrs, :email, "bademail")
      {:error, changeset} = Accounts.register_user(register_with)
      refute changeset.valid?
    end

    test "No user should be committed to the database when invalid registration attributes are given" do
      Accounts.register_user(@invalid_registrations_attrs)
      assert Accounts.list_users() |> length() == 0
    end

    test "Passing an invalid email format to a registration should result in an invalid changeset" do
      bad_email = Map.put(@valid_registration_attrs, :email, "not_an_email")
      {:error, changeset} = Accounts.register_user(bad_email)
      assert "has invalid format" in errors_on(changeset).email
    end
  end

  describe "users" do
    test "Accounts.get_user/1 should return the correct user" do
      user = user_fixture()
      assert Accounts.get_user!(user.id).name == "some first name some last name"
    end

    test "list_users/0 lists all users" do
      Accounts.register_user(@valid_registration_attrs)
      assert Accounts.list_users() |> length() == 1
    end

    test "update_user/2 with valid attrs should modify the user fields in the database" do
      user = user_fixture()
      {:ok, updated_user} = Accounts.update_user(user, @update_attrs)
      assert updated_user.id == user.id
      assert updated_user.name == "some updated name"
      assert updated_user.username == "new_username"
      assert updated_user.email == "some updated email"
    end

    test "update_user/2 with invalid attrs should return {:error, %Ecto.Changeset(valid?: false)}" do
      user = user_fixture()
      {:error, changeset} = Accounts.update_user(user, @invalid_attrs)
      refute changeset.valid?
    end

    test "delete_user/1 should remove the user from the database" do
      user = user_fixture()
      assert Accounts.list_users() |> length() == 1
      {:ok, %User{}} = Accounts.delete_user(user)
      assert Accounts.list_users() |> length() == 0
    end
  end
end
