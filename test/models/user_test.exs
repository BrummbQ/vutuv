defmodule Vutuv.UserTest do
  use Vutuv.ModelCase

  alias Vutuv.User

  @valid_attrs %{"first_name" => "first_name"}
  @invalid_attrs %{"emails" => %{"0" => %{"value" => "invalid email"}}}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
