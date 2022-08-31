defmodule DApp.Auth.AuthAccessPipeline do
  @moduledoc false

  use Guardian.Plug.Pipeline,
      otp_app: :d_app,
      module: DApp.Auth.Guardian,
      error_handler: DApp.Auth.AuthErrorHandler

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
