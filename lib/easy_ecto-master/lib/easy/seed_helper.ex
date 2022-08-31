defmodule EASY.SeedHelper do
  @moduledoc false

  @doc false
  defmacro __using__(_) do
    quote do
      use Ecto.Migration

      def import_from_csv(
            csv_path,
            callback,
            should_coonvert_empty_to_nil \\ false,
            base_path \\ nil
          ) do
        base_path =
          if base_path == nil,
#            do: Application.get_env(:easy_ecto, :repo)[:seed_base_path],
            do: Application.get_env(:core, :repo)[:seed_base_path],
            else: base_path

        (csv_path <> ".csv")
        |> Path.expand(base_path)
        |> File.stream!()
        |> CSV.decode!(headers: true)
        |> Stream.each(fn row ->
          row
          |> map_escap_sql(should_coonvert_empty_to_nil)
          |> callback.()
        end)
        |> Stream.run()
      end

      def map_escap_sql(map, should_coonvert_empty_to_nil) do
        for {key, value} <- map, into: %{} do
          case value do
            "null" ->
              {key, value}

            "" ->
              if should_coonvert_empty_to_nil do
                {key, "null"}
              else
                value =
                  value
                  |> String.replace("'", "''")

                {key, ~s('#{value}')}
              end

            _ ->
              value =
                value
                |> String.replace("'", "''")

              {key, ~s('#{value}')}
          end
        end
      end

      def map_to_table(map, table) do
        keys =
          map
          |> Map.keys()
          |> Enum.join(~s(", "))

        values =
          map
          |> Map.values()
          |> Enum.join(", ")

        Ecto.Migration.execute("INSERT INTO #{table} (\"#{keys}\") values (#{values})")
      end

      def reset_id_seq(table, id \\ "id") do
        Ecto.Migration.execute("SELECT setval('#{table}_#{id}_seq', (SELECT MAX(#{id}) from \"#{table}\"));")
      end
    end
  end
end
