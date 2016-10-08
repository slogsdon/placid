defmodule Placid.Mixfile do
  use Mix.Project

  def project do
    [ app: :placid,
      version: "0.2.0",
      elixir: ">= 1.0.0",
      deps: deps,
      name: "Placid",
      package: package,
      description: description,
      docs: [ extras: [ "README.md" ],
	      main: "readme" ],
      test_coverage: [ tool: ExCoveralls ] ]
  end

  def application do
    [ applications: [ :logger, :poison, :cowboy, :plug,
                      :xml_builder, :linguist ],
      mod: { Placid, [] } ]
  end

  defp deps do
    [ { :cowboy, "~> 1.0" },
      { :plug, "~> 1.0" },
      { :http_router, "~> 0.0" },
      { :linguist, "~> 0.1" },
      { :poison, "~> 3.0" },
      { :xml_builder, "~> 0.0" },
      { :earmark, "~> 1.0", only: :dev },
      { :ex_doc, "~> 0.14", only: :dev },
      { :excoveralls, "~> 0.5", only: :test },
      { :dialyze, "~> 0.2", only: :test } ]
  end

  defp description do
    """
    A REST toolkit for building highly-scalable and fault-tolerant HTTP APIs with Elixir
    """
  end

  defp package do
    %{ maintainers: [ "Shane Logsdon" ],
       licenses: [ "MIT" ],
       links: %{ "GitHub" => "https://github.com/slogsdon/placid" } }
  end
end
