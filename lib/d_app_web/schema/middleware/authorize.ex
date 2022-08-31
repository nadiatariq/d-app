defmodule DApp.Schema.Middleware.Authorize do
  @behaviour Absinthe.Middleware
  def call(resolution, role) do
    with %{current_user: %{role_id: role}} <- resolution.context do
      case role do
        "admin" -> resolution
        _role -> resolution |> Absinthe.Resolution.put_result({:error, ["you don't have permission"]})
      end
    else
      _ ->
        resolution
        |> Absinthe.Resolution.put_result({:error, "unauthorized"})
    end
  end

#  def call(resolution, role) do
#    with %{current_user: {:ok, %{role_id: role} = _user} = _current_user} <- resolution.context do
#      case role do
#        "admin" -> resolution
#        _role -> resolution |> Absinthe.Resolution.put_result({:error, ["you don't have permission"]})
#      end
#    else
#      _ ->
#        resolution
#        |> Absinthe.Resolution.put_result({:error, "unauthorized"})
#    end
#  end
end
