defmodule DApp.MixProject do
  use Mix.Project

  def project do
    [
      app: :d_app,
      version: "0.1.0",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers ++ [:phoenix_swagger],
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {DApp.Application, []},
      extra_applications: [:logger, :runtime_tools, :absinthe_plug]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.5.3"},
      {:phoenix_ecto, "~> 4.1"},
      {:ecto_sql, "~> 3.4"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_live_view, "~> 0.15.0"},
      {:floki, ">= 0.0.0", only: :test},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_dashboard, "~> 0.4.0"},
      {:telemetry_metrics, "~> 0.4"},
      {:telemetry_poller, "~> 0.4"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"},
      {:guardian, "~> 2.2"},
      {:argon2_elixir, "~> 2.4"},
      {:phoenix_swagger, "~> 0.8.3"},
      {:ex_json_schema, "~> 0.5"},
      {:cors_plug, "~> 2.0"},
      {:poison, "~> 3.0"},
      {:absinthe, "~> 1.4"},
      {:absinthe_plug, "~> 1.4.7"},
      {:absinthe_ecto, "~> 0.1.3"},
      {:sage, "~> 0.6.1"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "ecto.migrate": ["ecto.migrate", "ecto.dump"],
      "db.rollback": ["ecto.rollback", "ecto.dump"],
      deploy: [
        "deps.get",
        "compile",
        "ecto.reset"
      ]
    ]
  end
end
