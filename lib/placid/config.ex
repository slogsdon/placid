defmodule Placid.Config do
  @moduledoc false

  @default_options [
    http: [ port: 4000 ],
    https: [ certfile: "",
             keyfile:  "",
             port: 4443 ],
    https_only: true
  ]

  def get(module) when module != :placid do
    get(:placid, module)
  end
  def get(:placid, key) do
    _get(key)
  end
  def get(module, key) do
    _get(module)[key]
  end
  def get(:placid, key, default) do
    get(:placid, key) || default
  end
  def get(module, key, default) do
    get(module, module)[key] || default
  end

  defp _get(key) do
    env = Application.get_env(:placid, key)
    if is_list(env) do
      @default_options |> Keyword.merge(env)
    else
      env
    end
  end
end