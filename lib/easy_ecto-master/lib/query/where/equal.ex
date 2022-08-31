defmodule Query.Where.Equal do
  @moduledoc false
  import Ecto.Query

  defmacro __using__(_options) do
    quote location: :keep do

      def query_where(dynamics, {k, %{"$notequal" => value}}, opts) do
        if !is_list(value) do
          if Query.Helper.is_field?(value) do
            value = String.replace(value, "$", "", global: false)
            dynamic(
              [..., q],
              field(q, ^String.to_existing_atom(k)) != field(q, ^String.to_existing_atom(value)) and
              ^dynamics
            )
          else
            dynamic(
              [..., q],
              field(q, ^String.to_existing_atom(k)) != ^value and ^dynamics
            )
          end
        else
          Enum.reduce(value, dynamics, fn value, dynamics ->
            if Query.Helper.is_field?(value) do
              value = String.replace(value, "$", "", global: false)
              dynamic(
                [..., q],
                field(q, ^String.to_existing_atom(k)) != field(q, ^String.to_existing_atom(value)) and
                ^dynamics
              )
            else
              dynamic(
                [..., q],
                field(q, ^String.to_existing_atom(k)) != ^value and ^dynamics
              )
            end
          end)
        end
      end

      def query_or_where(dynamics, {key, %{"$notequal" => value}}, opts) do
        if !is_list(value) do
          if Query.Helper.is_field?(value) do
            value = String.replace(value, "$", "", global: false)
            dynamic(
              [..., q],
              field(q, ^String.to_existing_atom(key)) != field(q, ^String.to_existing_atom(value)) or
              ^dynamics
            )
          else
            dynamic(
              [..., q],
              field(q, ^String.to_existing_atom(key)) != ^value or ^dynamics
            )
          end
        else
          Enum.reduce(value, dynamics, fn value, dynamics ->
            if Query.Helper.is_field?(value) do
              value = String.replace(value, "$", "", global: false)
              dynamic(
                [..., q],
                field(q, ^String.to_existing_atom(key)) != field(q, ^String.to_existing_atom(value)) or
                ^dynamics
              )
            else
              dynamic(
                [..., q],
                field(q, ^String.to_existing_atom(key)) != ^value or ^dynamics
              )
            end
          end)
        end
      end

      def query_where(dynamics, {k, map_cond}, opts) when not is_list(map_cond) and not is_map(map_cond) do
        if Query.Helper.is_field?(map_cond) do
          value = String.replace(map_cond, "$", "", global: false)
          dynamic(
            [..., q],
            field(q, ^String.to_existing_atom(k)) == field(q, ^String.to_existing_atom(value)) and
            ^dynamics
          )
        else
          dynamic(
            [..., q],
            field(q, ^String.to_existing_atom(k)) == ^map_cond and ^dynamics
          )
        end
      end

      def query_or_where(dynamics, {k, map_cond}, opts) when not is_list(map_cond) and not is_map(map_cond) do
        if Query.Helper.is_field?(map_cond) do
          value = String.replace(map_cond, "$", "", global: false)
          dynamic(
            [..., q],
            field(q, ^String.to_existing_atom(k)) == field(q, ^String.to_existing_atom(value)) or
            ^dynamics
          )
        else
          dynamic(
            [..., q],
            field(q, ^String.to_existing_atom(k)) == ^map_cond or ^dynamics
          )
        end
      end
      def query_where(dynamics, {k, map_cond}, opts)  do
      dynamics
      end
      def query_or_where(dynamics, {k, map_cond}, opts) do
      dynamics
      end

    end
  end
end
