defmodule Query.Where.In do
  @moduledoc false


  import Ecto.Query
  defmacro __using__(_options) do
    quote location: :keep do

      def query_where(dynamics, {k, %{"$in" => value}}, opts) do
        dynamic(
          [..., q],
          field(q, ^String.to_existing_atom(k)) in ^value and
          ^dynamics
        )
      end

      def query_where(dynamics, {k, %{"$notin" => value}}, opts) do
        dynamic(
          [..., q],
          field(q, ^String.to_existing_atom(k)) not in ^value and
          ^dynamics
        )
      end

      def query_or_where(dynamics, {key, %{"$in" => value}}, opts) do
        dynamic(
          [..., q],
          field(q, ^String.to_existing_atom(key)) in ^value or
          ^dynamics
        )
      end

      def query_or_where(dynamics, {key, %{"$notin" => value}}, opts) do
        dynamic(
          [..., q],
          field(q, ^String.to_existing_atom(key)) not in ^value or
          ^dynamics
        )
      end

    end
  end
end
