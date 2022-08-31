defmodule Query.Join do
  @moduledoc false
  defmacro __using__(_options) do
    quote location: :keep do
      # opts = %{
      #     "$right_join" =>
      #    %{ "provider_companies" => %{
      #     "$to_be_join_field" => "id",
      #     "$join_table_field" => "provider_id",
      #     "$select" => ["id"]
      #   }}}
      # queryable = Core.V1.ProviderModel
      # Query.Join.build(queryable, opts, "$right_join")
      # from p in Core.V1.ProviderModel, join: pc in "provider_companies"
      # , where: pc.provider_id == p.id, select: {map(p, [:id, {"provider_companies", [:id]}]), map(pc, [:id])}

      @doc """
      Build up a dynamic `join` query and spcify  the fields which will be selected as a map .
      ## Parameters

        - Schema_name: Schema name that represents your database model.
        - Opts: %{ "$right_join" => %{ "assoc_model" => %{ "$to_be_join_field" => "field", "$join_table_field" => "field", "$select" => ["field"]}}}

      ## Examples

          iex> build(schema_name, opts)
          #Ecto.Query<from j in model, right_join: e in "assoc_model",
          on: j.field == e.field, select: merge(j, map(e, [:field]))>
      """
      def build_join(queryable, opts, model, join_type \\ "$join") do
        case opts do
          nil ->
            queryable

          _opts ->
            Enum.reduce(opts, queryable, fn {join_key, join_opts}, queryable ->
                  join_table = join_opts["$table"]
                  #              join_table_model = _get_model(model, join_table)
                  join =
                    String.replace(join_type, "_join", "")
                    |> String.replace("$", "")
                    |> String.to_atom()
                  join_on = join_on(join_opts["$on"])

                  queryable =
                    queryable
                    |> join(
                    join,
                    [q],
                     jt in ^join_table,
                      on: ^join_on)

                  queryable =
                    if join_opts["$where"] == nil do
                      queryable
                    else
                      EASY.Query.build_where(queryable, join_opts["$where"], [binding: :last, ilike: :on, outer: join_opts["$outer_condition_operator"]])
                    end

                  queryable = order(queryable, join_opts["$order"])
                  queryable = _select(queryable, join_opts, join_key, model)
                  cond do
                    join_opts["$join"] != nil ->
                      s_build_join(queryable, join_opts["$join"], model, "$join")
                    join_opts["$right_join"] != nil ->
                      s_build_join(queryable, join_opts["$right_join"], model, "$right_join")
                    join_opts["$left_join"] != nil ->
                      s_build_join(queryable, join_opts["$left_join"], model, "$left_join")
                    join_opts["$inner_join"] != nil ->
                      s_build_join(queryable, join_opts["$inner_join"], model, "$inner_join")
                    join_opts["$full_join"] != nil ->
                      s_build_join(queryable, join_opts["$full_join"], model, "$full_join")
                    true ->
                    queryable
                  end
            end)
        end
      end

      defp s_build_join(queryable, opts, model, join_type \\ "$join") do
        case opts do
          nil ->
            queryable

          _opts ->
            Enum.reduce(opts, queryable, fn {join_key, join_opts}, queryable ->
              join_table = join_opts["$table"]
              #              join_table_model = _get_model(model, join_table)
              join =
                String.replace(join_type, "_join", "")
                |> String.replace("$", "")
                |> String.to_atom()

              join_on = s_join_on(join_opts["$on"])
              queryable =
                queryable
                |> join(
                     join,
                     [p,q],
                     st in ^join_table,
                     on: ^join_on)

              queryable =
                if join_opts["$where"] == nil do
                  queryable
                else
                  EASY.Query.build_where(queryable, join_opts["$where"], [binding: :last, ilike: :on, outer: join_opts["$outer_condition_operator"]])
                end

              queryable = order(queryable, join_opts["$order"])
              queryable = _select(queryable, join_opts, join_key, model)
              cond do
                join_opts["$join"] != nil ->
                  s_build_join(queryable, join_opts["$join"], model, "$join")
                join_opts["$right_join"] != nil ->
                  s_build_join(queryable, join_opts["$right_join"], model, "$right_join")
                join_opts["$left_join"] != nil ->
                  s_build_join(queryable, join_opts["$left_join"], model, "$left_join")
                join_opts["$inner_join"] != nil ->
                  s_build_join(queryable, join_opts["$inner_join"], model, "$inner_join")
                join_opts["$full_join"] != nil ->
                  s_build_join(queryable, join_opts["$full_join"], model, "$full_join")
                true ->
                  queryable
              end
            end)
        end
      end

      defp _select(queryable, join_opts, join_table, model) do
        case join_opts["$select"] do
          nil ->
            queryable
          "*" ->
            s_model = _get_model(model, join_table)
            s_table_fields = s_model.__schema__(:fields)
            #          s_table_key = String.split(join_table, "_") |> List.last()

            from([q, ..., c] in queryable, select_merge: %{^Inflex.singularize(join_table) => map(c, ^s_table_fields)})
          select when is_list(select) ->
            # Below syntax doesn't support ... in binding
            # queryable |> select_merge([q, c], (%{location_dest_zone: map(c, ^select_atoms)}))

            # TODO: use dynamics to build queries where ever possible
            # dynamic = dynamic([q, ..., c], c.id == 1)
            # from query, where: ^dynamic

            select_atoms = Enum.map(select, &String.to_atom/1)

            case join_table do
              "customer" ->
                from([q, ..., c] in queryable, select_merge: %{customer: map(c, ^select_atoms)})

              "provider" ->
                from([q, ..., c] in queryable, select_merge: %{provider: map(c, ^select_atoms)})

              "companies" ->
                from([q, ..., c] in queryable, select_merge: %{companies: map(c, ^select_atoms)})

              "location_dest_zone" ->
                from(
                  [q, ..., c] in queryable,
                  select_merge: %{location_dest_zone: map(c, ^select_atoms)}
                )

              "service" ->
                from([q, ..., c] in queryable, select_merge: %{service: map(c, ^select_atoms)})

              "services" ->
                from([q, ..., c] in queryable, select_merge: %{services: map(c, ^select_atoms)})

              "current_zone" ->
                from(
                  [q, ..., c] in queryable,
                  select_merge: %{current_zone: map(c, ^select_atoms)}
                )

              "transport_type" ->
                from(
                  [q, ..., c] in queryable,
                  select_merge: %{transport_type: map(c, ^select_atoms)}
                )

              "provider_companies" ->
                from(
                  [q, ..., c] in queryable,
                  select_merge: %{provider_companies: map(c, ^select_atoms)}
                )

              _whatever ->
                from([q, ..., c] in queryable, select_merge: map(c, ^select_atoms))
            end

          # from([q, ..., c] in queryable, select_merge: %{ ^join_table => map(c, ^Enum.map(select, &String.to_atom/1))})
          # from([q, ..., c] in queryable, select_merge: map(c, ^Enum.map(select, &String.to_atom/1)))
        end
      end

      defp order(queryable, opts_order_by) do
        if opts_order_by == nil do
          queryable
        else
          Enum.reduce(opts_order_by, queryable, fn {field, format}, queryable ->
            if format == "$desc" do
              from(
                [q, ..., c] in queryable,
                order_by: [
                  desc: field(c, ^String.to_existing_atom(field))
                ]
              )
            else
              from(
                [q, ..., c] in queryable,
                order_by: [
                  asc: field(c, ^String.to_existing_atom(field))
                ]
              )
            end
          end)
        end
      end
      defp _get_model(model, table_name) do
        name_without_model = Inflex.singularize(table_name)
                             |> String.split("_")
                             |> Enum.reduce("", fn l, acc ->
          acc <> Inflex.camelize(l)
        end)

        list = Module.split(model)
               |> Enum.drop(-1)
        model = Module.safe_concat(list ++ [name_without_model <> "Model"])
        #         model.__schema__(:fields) |> Enum.map(&Atom.to_string/1)
      end

#$on: [{adf: 'id', select_best_fit_name_for_keys: 'current_zone_id'}, {'id', 'current_zone_id'}, {'id', 'current_zone_id'}]
    def join_on(on_join_opts) do
        Enum.reduce(on_join_opts, true, fn join_on, dynamics ->
        case join_on do
          %{"$or" => value} ->
          Enum.reduce(value, false, fn join_on, dynamics ->
            case join_on["$on_type"] do
              "$not_eq" ->
                dynamic(
                  [q, ...,jt],
                  field(q, ^String.to_existing_atom(join_on["$to_be_join_field"])) !=
                    field(jt, ^String.to_existing_atom(join_on["$join_table_field"])) or
                  ^dynamics
                )

              "$in_x" ->
                dynamic(
                  [q, ...,jt],
                  field(q, ^String.to_existing_atom(join_on["$to_be_join_field"])) in
                    field(jt, ^String.to_existing_atom(join_on["$join_table_field"])) or
                  ^dynamics
                )
              "$in" ->
                dynamic(
                  [q, ...,jt],
                  field(jt, ^String.to_existing_atom(join_on["$join_table_field"])) in
                    field(q, ^String.to_existing_atom(join_on["$to_be_join_field"])) or
                  ^dynamics
                )
              _whatever ->
                dynamic(
                  [q, ...,jt],
                  field(q, ^String.to_existing_atom(join_on["$to_be_join_field"])) ==
                    field(jt, ^String.to_existing_atom(join_on["$join_table_field"])) or
                  ^dynamics
                )

            end
          end)

          _ ->
            case join_on["$on_type"] do
              "$not_eq" ->
                dynamic(
                  [q, ...,jt],
                  field(q, ^String.to_existing_atom(join_on["$to_be_join_field"])) !=
                    field(jt, ^String.to_existing_atom(join_on["$join_table_field"])) and
                  ^dynamics
                )

              "$in_x" ->
                dynamic(
                  [q, ...,jt],
                  field(q, ^String.to_existing_atom(join_on["$to_be_join_field"])) in
                    field(jt, ^String.to_existing_atom(join_on["$join_table_field"])) and
                  ^dynamics
                )
              "$in" ->
                dynamic(
                  [q, ...,jt],
                      field(jt, ^String.to_existing_atom(join_on["$join_table_field"])) in
                  field(q, ^String.to_existing_atom(join_on["$to_be_join_field"])) and
                  ^dynamics
                )
              _whatever ->
                dynamic(
                  [q, ...,jt],
                  field(q, ^String.to_existing_atom(join_on["$to_be_join_field"])) ==
                    field(jt, ^String.to_existing_atom(join_on["$join_table_field"])) and
                  ^dynamics
                )

            end

        end
      end)
    end

      def s_join_on(on_join_opts) do
        Enum.reduce(on_join_opts, true, fn join_on, dynamics ->
          case join_on do
            %{"$or" => value} ->
              Enum.reduce(value, false, fn join_on, dynamics ->
                case join_on["$on_type"] do
                  "$not_eq" ->
                    dynamic(
                      [..., q, st],
                      field(q, ^String.to_existing_atom(join_on["$to_be_join_field"])) !=
                        field(st, ^String.to_existing_atom(join_on["$join_table_field"])) or
                      ^dynamics
                    )

                  "$in_x" ->
                    dynamic(
                      [..., q, st],
                      field(q, ^String.to_existing_atom(join_on["$to_be_join_field"])) in
                        field(st, ^String.to_existing_atom(join_on["$join_table_field"])) or
                      ^dynamics
                    )
                  "$in" ->
                    dynamic(
                      [..., q, st],
                      field(st, ^String.to_existing_atom(join_on["$join_table_field"])) in
                        field(q, ^String.to_existing_atom(join_on["$to_be_join_field"])) or
                      ^dynamics
                    )
                  _whatever ->
                    dynamic(
                      [..., q, st],
                      field(q, ^String.to_existing_atom(join_on["$to_be_join_field"])) ==
                        field(st, ^String.to_existing_atom(join_on["$join_table_field"])) or
                      ^dynamics
                    )

                end
              end)

            _ ->
              case join_on["$on_type"] do
                "$not_eq" ->
                  dynamic(
                    [..., q, st],
                    field(q, ^String.to_existing_atom(join_on["$to_be_join_field"])) !=
                      field(st, ^String.to_existing_atom(join_on["$join_table_field"])) and
                    ^dynamics
                  )

                "$in_x" ->
                  dynamic(
                    [..., q, st],
                    field(q, ^String.to_existing_atom(join_on["$to_be_join_field"])) in
                      field(st, ^String.to_existing_atom(join_on["$join_table_field"])) and
                    ^dynamics
                  )
                "$in" ->
                  dynamic(
                    [..., q, st],
                    field(st, ^String.to_existing_atom(join_on["$join_table_field"])) in
                      field(q, ^String.to_existing_atom(join_on["$to_be_join_field"])) and
                    ^dynamics
                  )
                _whatever ->
                  dynamic(
                    [..., q, st],
                    field(q, ^String.to_existing_atom(join_on["$to_be_join_field"])) ==
                      field(st, ^String.to_existing_atom(join_on["$join_table_field"])) and
                    ^dynamics
                  )

              end

          end
        end)
      end

    end
  end
end
