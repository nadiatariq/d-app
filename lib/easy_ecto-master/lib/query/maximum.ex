defmodule Query.Maximum do
  @moduledoc false
  defmacro __using__(_options) do
    quote location: :keep do
      def build_maximum(queryable, opts_max) do
        Enum.reduce(opts_max, queryable, fn {k, v}, queryable ->
          case v do
            nil ->
              queryable

            v when is_list(v) ->
              value = Enum.at(v, 0)

              from(
                q in queryable,
                order_by: [
                  desc: ^String.to_existing_atom(value)
                ],
                limit: 1
              )
          end
        end)
      end
    end
  end
end
