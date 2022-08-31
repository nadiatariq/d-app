defmodule Query.Where.Like do
  @moduledoc false

  import Ecto.Query
  defmacro __using__(_options) do
    quote location: :keep do

      def query_where(dynamics, {k, %{"$like" => value}}, opts) do
        dynamic(
          [..., q],
          like(
            fragment("(?)::TEXT", field(q, ^String.to_existing_atom(k))),
            ^value
          ) and ^dynamics
        )
      end

      def query_where(dynamics, {k, %{"$ilike" => value}}, opts) do
        dynamic(
          [..., q],
          ilike(
            fragment("(?)::TEXT", field(q, ^String.to_existing_atom(k))),
            ^value
          ) and ^dynamics
        )
      end

      def query_where(dynamics, {k, %{"$notlike" => value}}, opts) do
        dynamic(
          [..., q],
          not like(
            fragment("(?)::TEXT", field(q, ^String.to_existing_atom(k))),
            ^value
          ) and ^dynamics
        )
      end

      def query_where(dynamics, {k, %{"$notilike" => value}}, opts) do
        dynamic(
          [..., q],
          not ilike(
            fragment("(?)::TEXT", field(q, ^String.to_existing_atom(k))),
            ^value
          ) and ^dynamics
        )
      end

      def query_or_where(dynamics, {key, %{"$like" => value}}, opts) do
        dynamic(
          [..., q],
          like(
            fragment("(?)::TEXT", field(q, ^String.to_existing_atom(key))),
            ^value
          ) or ^dynamics
        )
      end

      def query_or_where(dynamics, {key, %{"$ilike" => value}}, opts) do
        dynamic(
          [..., q],
          ilike(
            fragment("(?)::TEXT", field(q, ^String.to_existing_atom(key))),
            ^value
          ) or ^dynamics
        )
      end

      def query_or_where(dynamics, {key, %{"$notlike" => value}}, opts) do
        dynamic(
          [..., q],
          not like(
            fragment("(?)::TEXT", field(q, ^String.to_existing_atom(key))),
            ^value
          ) or ^dynamics
        )
      end

      def query_or_where(dynamics, {key, %{"$notilike" => value}}, opts) do
        dynamic(
          [..., q],
          not ilike(
            fragment("(?)::TEXT", field(q, ^String.to_existing_atom(key))),
            ^value
          ) or ^dynamics
        )
      end

    end
  end
end
