defmodule DApp.Auth.AuthErrorHandler do
  @moduledoc false

  import Plug.Conn
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]

  def auth_error(conn, {_type, _reason}, _opts) do
    conn
#    |> put_flash(:error, "You are unauthorized to view this page. It could be due to inactivity. Please login to continue.")
    |> redirect(to: "/")
  end
end
