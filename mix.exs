defmodule Placid.Mixfile do
  use Mix.Project

  def project do
    [ app: :placid,
      version: "0.1.4-beta.1",
      elixir: ">= 1.0.0-rc1",
      deps: deps,
      name: "Placid",
      package: package,
      description: description,
      docs: [ readme: "README.md", main: "README" ],
      test_coverage: [ tool: ExCoveralls ] ]
  end

  def application do
    [ applications: [ :logger, :poison, :cowboy, :plug,
                      :xml_builder, :linguist ],
      mod: { Placid, [] } ]
  end

  defp deps do
    [ { :cowboy, "~> 1.0.0" },
      { :plug, "~> 0.9.0" },
      { :http_router, "~> 0.0.4" },
      { :linguist, "~> 0.1.2" },
      { :poison, "~> 1.3.0" },
      { :xml_builder, "~> 0.0.5" },
      { :earmark, "~> 0.1.10", only: :docs },
      { :ex_doc, "~> 0.6.1", only: :docs },
      { :excoveralls, "~> 0.3.4", only: :test },
      { :dialyze, "~> 0.1.3", only: :test } ]
  end

  defp description do
    """
    A REST toolkit for building highly-scalable and fault-tolerant HTTP APIs with Elixir
    """
  end

  defp package do
    %{ contributors: [ "Shane Logsdon" ],
       licenses: [ "MIT" ],
       links: %{ "GitHub" => "https://github.com/slogsdon/placid" } }
  end
end
