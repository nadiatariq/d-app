defmodule DApp.Repo do
  use Ecto.Repo,
    otp_app: :d_app,
    adapter: Ecto.Adapters.Postgres
end
