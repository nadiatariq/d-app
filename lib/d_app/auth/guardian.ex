defmodule DApp.Auth.Guardian do
  use Guardian, otp_app: :d_app

  alias DApp.Query.Users

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end
  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(%{"sub" => id} = claims) do
    case Users.get_user(id) do
      {:error, error} -> {:error, error}
      {:ok, user} -> {:ok, user}
    end
  end
end