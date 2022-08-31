defmodule DApp.AuthHelper do
  @moduledoc """
  This is the Users API for the data layer
  """
  alias DApp.Query.Users, as: Query
  alias DApp.Schema.User, as: Schema

  def create_user(params), do: Query.create_user(params)

  def get_user(params), do: Query.get_user_by_email(params)

  def get_user_by_id(params), do: Query.get_user(params)

  def get_students(), do: Query.get_students()

  def get_users_list(), do: Query.get_users_list()

  def get_roles_list(), do: Query.list_user_roles()

  def get_changeset(),
      do: Schema.changeset(%DApp.Schema.User{})

  def delete(params) do
    Query.delete_user(params)
  end
  def get_update(user, params) do
    Query.update_user(user, params)
  end

  def change_user(user ,params), do: Query.change_user(user, params)
end
