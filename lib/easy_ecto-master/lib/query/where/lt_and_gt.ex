defmodule Query.Where.Lt_and_Gt do
  @moduledoc false


  import Ecto.Query
  defmacro __using__(_options) do
    quote location: :keep do

      def query_where(dynamics, {k, %{"$lt" => value}}, opts) do
        if Query.Helper.is_field?(value) do
          value = String.replace(value, "$", "", global: false)
          dynamic(
            [..., q],
            field(q, ^String.to_existing_atom(k)) < field(q, ^String.to_existing_atom(value)) and
            ^dynamics
          )
        else
          dynamic(
            [..., q],
            field(q, ^String.to_existing_atom(k)) < ^value and
            ^dynamics
          )
        end
      end

      def query_where(dynamics, {k, %{"$lte" => value}}, opts) do
        if Query.Helper.is_field?(value) do
          value = String.replace(value, "$", "", global: false)
          dynamic(
            [..., q],
            field(q, ^String.to_existing_atom(k)) <= field(q, ^String.to_existing_atom(value)) and
            ^dynamics
          )
        else
          dynamic(
            [..., q],
            field(q, ^String.to_existing_atom(k)) <= ^value and
            ^dynamics
          )
        end
      end

      def query_where(dynamics, {k, %{"$gt" => value}}, opts) do
        if Query.Helper.is_field?(value) do
          value = String.replace(value, "$", "", global: false)
          dynamic(
            [..., q],
            field(q, ^String.to_existing_atom(k)) > field(q, ^String.to_existing_atom(value)) and
            ^dynamics
          )
        else
          dynamic(
            [..., q],
            field(q, ^String.to_existing_atom(k)) > ^value and
            ^dynamics
          )
        end
      end

      def query_where(dynamics, {k, %{"$gte" => value}}, opts) do
        if Query.Helper.is_field?(value) do
          value = String.replace(value, "$", "", global: false)
          dynamic(
            [..., q],
            field(q, ^String.to_existing_atom(k)) >= field(q, ^String.to_existing_atom(value)) and
            ^dynamics
          )
        else
          dynamic(
            [..., q],
            field(q, ^String.to_existing_atom(k)) >= ^value and
            ^dynamics
          )
        end
      end

      def query_or_where(dynamics, {key, %{"$lt" => value}}, opts) do
        if Query.Helper.is_field?(value) do
          value = String.replace(value, "$", "", global: false)
          dynamic(
            [..., q],
            field(q, ^String.to_existing_atom(key)) < field(q, ^String.to_existing_atom(value)) or
            ^dynamics
          )
        else
          dynamic(
            [..., q],
            field(q, ^String.to_existing_atom(key)) < ^value or ^dynamics
          )
        end
      end

      def query_or_where(dynamics, {key, %{"$lte" => value}}, opts) do
        if Query.Helper.is_field?(value) do
          value = String.replace(value, "$", "", global: false)
          dynamic(
            [..., q],
            field(q, ^String.to_existing_atom(key)) <= field(q, ^String.to_existing_atom(value)) or
            ^dynamics
          )
        else
          dynamic(
            [..., q],
            field(q, ^String.to_existing_atom(key)) <= ^value or ^dynamics
          )
        end
      end

      def query_or_where(dynamics, {key, %{"$gt" => value}}, opts) do
        if Query.Helper.is_field?(value) do
          value = String.replace(value, "$", "", global: false)
          dynamic(
            [..., q],
            field(q, ^String.to_existing_atom(key)) > field(q, ^String.to_existing_atom(value)) or
            ^dynamics
          )
        else
          dynamic(
            [..., q],
            field(q, ^String.to_existing_atom(key)) > ^value or ^dynamics
          )
        end
      end

      def query_or_where(dynamics, {key, %{"$gte" => value}}, opts) do
        if Query.Helper.is_field?(value) do
          value = String.replace(value, "$", "", global: false)
          dynamic(
            [..., q],
            field(q, ^String.to_existing_atom(key)) >= field(q, ^String.to_existing_atom(value)) or
            ^dynamics
          )
        else
          dynamic(
            [..., q],
            field(q, ^String.to_existing_atom(key)) >= ^value or ^dynamics
          )
        end
      end

    end
  end
end
