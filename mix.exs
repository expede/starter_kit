defmodule StarterKit.Mixfile do
  use Mix.Project

  def project do
    [
      app: :starter_kit,
      name: "Starter Kit",

      version: "0.1.0",
      elixir: "~> 1.4",

      build_embedded:  Mix.env == :prod,
      start_permanent: Mix.env == :prod,

      aliases: aliases(),
      deps: deps(),

      docs: [
        extras: ~w(README.md),
        main:   "readme"
      ]
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      # Error Handling
      {:exceptional, "~> 2.1"},

      # Convenience
      {:pipe_here, "~> 1.0"},
      {:quark,     "~> 2.0"},
      {:timex,     "~> 3.1"},

      # Code Quality
      ## Completeness
      {:credo,    "~> 0.4", only: [:dev, :test]},
      {:dialyxir, "~> 0.5", only: [:dev, :test]},
      {:ex_spec,  "~> 2.0", only: [:test]},

      ## Docs
      {:ex_doc, "~> 0.12", only: :dev},
    ]
  end

  defp aliases do
    [
      "quality": [
        "dialyzer",
        "test",
        "credo --strict"
      ]
    ]
  end
end
