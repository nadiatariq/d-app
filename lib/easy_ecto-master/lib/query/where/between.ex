defmodule Query.Where.Between do
  @moduledoc false


  import Ecto.Query
  defmacro __using__(_options) do
    quote location: :keep do

      def query_where(dynamics, {k, %{"$between" => value}}, opts) do
        dynamic(
          [..., q],
          field(q, ^String.to_existing_atom(k)) > ^Enum.min(value) and
          field(q, ^String.to_existing_atom(k)) < ^Enum.max(value) and
          ^dynamics
        )
      end

      def query_where(dynamics, {k, %{"$notbetween" => value}}, opts) do

        dynamic(
          [..., q],
          field(q, ^String.to_existing_atom(k)) < ^Enum.min(value) or
          field(q, ^String.to_existing_atom(k)) > ^Enum.max(value) and
          ^dynamics
        )
      end

      def query_or_where(dynamics, {key, %{"$between" => value}}, opts) do
        dynamic(
          [..., q],
          field(q, ^String.to_existing_atom(key)) > ^Enum.min(value) and
          field(q, ^String.to_existing_atom(key)) < ^Enum.max(value) or
          ^dynamics
        )
      end

      def query_or_where(dynamics, {key, %{"$notbetween" => value}}, opts) do
        dynamic(
          [..., q],
          field(q, ^String.to_existing_atom(key)) < ^Enum.min(value) or
          field(q, ^String.to_existing_atom(key)) > ^Enum.max(value) or
          ^dynamics
        )
      end


    end
  end
end
