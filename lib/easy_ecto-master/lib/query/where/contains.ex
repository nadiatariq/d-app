defmodule Query.Where.Contains do
  @moduledoc false


  import Ecto.Query
  defmacro __using__(_options) do
    quote location: :keep do

      def query_where(dynamics, {k, %{"$contains" => value}}, opts) do
        dynamic(
          [..., q],
          fragment("? @> ?", field(q, ^String.to_existing_atom(k)), ^value) and
          ^dynamics
        )
      end

      def query_where(dynamics, {k, %{"$contains_any" => value}}, opts) do
        dynamic(
          [..., q],
          fragment("? && ?", field(q, ^String.to_existing_atom(k)), ^value) and
          ^dynamics
        )
      end

      def query_or_where(dynamics, {key, %{"$contains" => value}}, opts) do
        dynamic(
          [..., q],
          fragment("? @> ?", field(q, ^String.to_existing_atom(key)), ^value) or
          ^dynamics
        )
      end

      def query_or_where(dynamics, {key, %{"$contains_any" => value}}, opts) do
        dynamic(
          [..., q],
          fragment("? && ?", field(q, ^String.to_existing_atom(key)), ^value) or
          ^dynamics
        )
      end

    end
  end
end
