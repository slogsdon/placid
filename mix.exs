defmodule Placid.Mixfile do
  use Mix.Project

  def project do
    [ app: :placid,
      version: "0.0.1",
      elixir: "~> 1.0.0-rc1",
      deps: deps,
      name: "Placid",
      package: package,
      description: description,
      docs: [ readme: true, main: "README" ],
      test_coverage: [ tool: ExCoveralls ] ]
  end

  def application do
    [ applications: [ :logger ],
      mod: { Placid, [] } ]
  end

  defp deps(:prod) do
    [ { :cowboy, "~> 1.0.0" },
      { :plug, "~> 0.7.0" },
      { :jsex, "~> 2.0.0" },
      { :ex_doc, github: "elixir-lang/ex_doc" },
      { :excoveralls, github: "parroty/excoveralls" } ]
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
