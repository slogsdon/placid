defmodule Placid.Mixfile do
  use Mix.Project

  def project do
    [ app: :placid,
      version: "0.1.5-dev",
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
    [ { :cowboy, "~> 1.0.2" },
      { :plug, "~> 0.14.0" },
      { :http_router, "~> 0.0.7" },
      { :linguist, "~> 0.1.5" },
      { :poison, "~> 1.4.0" },
      { :xml_builder, "~> 0.0.5" },
      { :earmark, "~> 0.1.17", only: :docs },
      { :ex_doc, "~> 0.7.3", only: :docs },
      { :excoveralls, "~> 0.3.11", only: :test },
      { :dialyze, "~> 0.2.0", only: :test } ]
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
