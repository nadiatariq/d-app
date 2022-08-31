defmodule DAppWeb.UserController do
  use DAppWeb, :controller
  alias DApp.AuthHelper, as: Data

  def get_student_list(_, _params, _) do
    {:ok, Data.get_students()}
  end

  def get_users_list(_, _params, _) do
    {:ok, Data.get_users_list()}
  end

  def get_roles_list(_, _params, _) do
    {:ok, Data.get_roles_list()}
  end

  def update_user(_, %{input: %{email: email} = params}, _) do
    {:ok, user} = case Data.get_user(email) do
      {:ok, user} -> {:ok, user}
      _ -> {:error, ["email is incorrect"]}
    end

    case Data.get_update(user, params) do
      {:ok, user} -> {:ok, user}
      _ -> {:error, ["something went wrong"]}
    end
  end

  def delete_user(_, %{input: %{id: id}}, _) do
    with {:ok, user} <- Data.get_user_by_id(id),
         {:ok, user} <- Data.delete(user) do
      {:ok, user}
    else
      {:error, reason} -> {:error, [reason]}
      _ -> {:error, ["Something went wrong"]}
    end
  end
end