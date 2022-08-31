defmodule DAppWeb.SessionController do
  import Sage
  use DAppWeb, :controller

  alias DApp.Auth.Guardian, as: Guardian
  alias DApp.AuthHelper, as: Data

  def create_user(_, params, _) do
    new()
    |> run(:email_taken, &is_email_taken/2, &abort/3)
    |> run(:create_user, &create_user/2, &abort/3)
    |> run(:updated_user, &put_token/2, &abort/3)
    |> transaction(DApp.Repo, params)
  end

  def signin(_, params, _) do
    new()
    |> run(:authenticate, &authenticate/2, &abort/3)
    |> run(:login_user, &put_token/2, &abort/3)
    |> transaction(DApp.Repo, params)
  end

  def get_user_from_jwt(_, params, _) do
    new()
    |> run(:extracted_user, &extract_user/2, &abort/3)
    |> transaction(DApp.Repo, params)
  end

  defp authenticate(_, %{input: %{email: email, password: password}} = params) do
    case Data.get_user(email) do
      {:error, :user_does_not_exist} ->
        {:error, ["User Doesn't Exist"]}

      {:ok, user} ->
        if(Argon2.verify_pass(password, user.password)) do
          {:ok, user}
        else
          {:error, ["Invalid Password"]}
        end

        _ -> {:error, ["Authentication Failed!!"]}
    end
  end

  defp is_email_taken(_, %{input: %{email: email} = params}) do
    case Data.get_user(email) do
      {:ok, user} ->
        {:error, ["User Already Exists"]}

      {:error, _} ->
        {:ok, :can_create}
    end
  end

  defp create_user(%{email_taken: :can_create} = all, %{input: user} = params) do
    Data.create_user(user)
  end
  defp create_user(all, _) do
    IO.inspect(all)
  end

  defp put_token(%{create_user: user} = all, _) do
    case Guardian.encode_and_sign(user) do
      {:ok, jwt, _} -> {:ok, Map.merge(user, %{token: jwt})}
    end
  end
  defp put_token(%{authenticate: user} = all, _) do
    case Guardian.encode_and_sign(user) do
      {:ok, jwt, _} -> {:ok, Map.merge(user, %{token: jwt})}
    end
  end

  defp extract_user(_, %{input: %{token: token}}) do
    with {:ok, claims} <- Guardian.decode_and_verify(token),
         {:ok, user} <- Guardian.resource_from_claims(claims) do
      {:ok, user}
    else
      {:error, error} -> {:error, error}
    end
  end

  defp abort(_, _, _) do
    :abort
  end
end