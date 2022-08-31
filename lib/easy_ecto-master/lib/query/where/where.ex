defmodule Query.Where do
  @moduledoc false


  import Ecto.Query
  defmacro __using__(_options) do
    quote location: :keep do
      @doc """
      Build up a dynamic `where` query using Ecto.Query.API methods.
      ## Parameters

        - Schema_name: Schema name that represents your database model.
        - Opts: %{"$where" => %{"field" => %{"$like" => "%value %"}}}.
      ## Examples

          iex> build(schema_name, opts)
          #Ecto.Query<from w in schema_name, where: like(w.field, ^"%value %")>

      """

#      use Query.Where.Or
#      use Query.Where.And



      use Query.Where.Between
      use Query.Where.Contains
      use Query.Where.In
      use Query.Where.Lt_and_Gt
      use Query.Where.Like
      use Query.Where.Null
      use Query.Where.Equal

      def build_where(queryable, opts_where, opts \\ []) do
        if opts_where == nil do
          queryable
        else
          dynamics = Enum.reduce(opts_where, false, fn {k, v}, dynamics ->
          case k  do
            "$or" ->
            Enum.reduce(v, false, fn {key, condition}, dynamics ->
              query_or_where(dynamics, {key, condition}, opts)
            end)
          _ ->
            dynamics = if dynamics, do: dynamics, else: true
            query_where(dynamics, {k, v}, opts)
          end
          end)
          if opts[:binding] == :last && opts[:outer] == "or"do
            from(q in queryable, or_where: ^dynamics)
          else
            from(q in queryable, where: ^dynamics)
          end
        end
      end

#      def query_where(dynamics, {"$or", map_cond}, opts) when is_map(map_cond) do
#        IO.inspect("============= $or =================")
#        IO.inspect("map_cond---------")
#        IO.inspect(map_cond)
#
#      end

    end
  end
end
