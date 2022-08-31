defmodule Query.Where.Null do
  @moduledoc false


  import Ecto.Query
  defmacro __using__(_options) do
    quote location: :keep do

      def query_where(dynamics, {k, map_cond}, opts) when is_nil(map_cond)  do
        dynamics = if dynamics, do: dynamics, else: true
        dynamic(
          [..., q],
          is_nil(field(q, ^String.to_existing_atom(k))) and
          ^dynamics
        )
      end

      def query_where(dynamics, {k, map_cond}, opts) when is_list(map_cond) and k == "$notNull" do
        dynamics = if dynamics, do: dynamics, else: true
        Enum.reduce(map_cond, dynamics, fn key, dynamics ->
          dynamic(
            [..., q],
            not is_nil(field(q, ^String.to_existing_atom(key))) and
            ^dynamics
          )
        end)
      end

      def query_or_where(dynamics, {k, map_cond}, opts) when is_nil(map_cond) do
        dynamics = if dynamics, do: dynamics, else: true
        dynamic(
          [..., q],
          is_nil(field(q, ^String.to_existing_atom(k))) or
          ^dynamics
        )
      end

      def query_or_where(dynamics, {k, map_cond}, opts) when is_list(map_cond) and k == "$notNull" do
        dynamics = if dynamics, do: dynamics, else: true
        Enum.reduce(map_cond, dynamics, fn key, dynamics ->
          dynamic(
            [..., q],
            not is_nil(field(q, ^String.to_existing_atom(key))) or
            ^dynamics
          )
        end)
      end

      def query_where(dynamics, {k, map_cond}, opts) when k == "$not" do
         dynamics
      end
      def query_or_where(dynamics, {k, map_cond}, opts) when k == "$not" do
        dynamics
      end

      end
  end
end
