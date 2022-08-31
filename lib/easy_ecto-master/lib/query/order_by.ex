defmodule Query.OrderBy do
  @moduledoc false
  defmacro __using__(_options) do
    quote location: :keep do
      @doc """
      Build up a dynamic `order_by` asc or desc query.
      ## Parameters

        - Schema_name: Schema name that represents your database model.
        - Opts: %{"$order" => %{"field" => "$desc"}}.
      ## Examples

          iex> build(schema_name, opts)
          #Ecto.Query<from j in TestModel.Join, order_by: [desc: j.field]>

      """
      def build_order_by(queryable, opts_order_by) do
        IO.inspect("=======================build order by=====================")
        IO.inspect(queryable)
        IO.inspect(opts_order_by)
        IO.inspect("=======================build order by=====================")
        case opts_order_by do
          nil -> queryable
          [] -> queryable
          %{} ->
            Enum.reduce(opts_order_by, queryable, fn {field, format}, queryable ->
              if format == "$desc" do
                from(
                  queryable,
                  order_by: [
                    desc: ^String.to_existing_atom(field)
                  ]
                )
              else
                from(
                  queryable,
                  order_by: [
                    asc: ^String.to_existing_atom(field)
                  ]
                )
              end
            end)
          opts_order_by ->
            from(
              queryable,
              order_by: ^convert_list_into_atoms(opts_order_by)
            )
        end
      end

      defp convert_list_into_atoms(opts) do
        Enum.map(opts, fn item ->
          String.to_existing_atom(item)
        end)
      end
    end
  end
end
