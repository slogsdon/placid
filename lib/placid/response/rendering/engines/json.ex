defmodule Placid.Response.Rendering.Engines.JSON do
  @moduledoc false
  @behaviour Placid.Response.Rendering.Engine

  @types [ "application", "text" ]

  def serialize(data, type, "json") when type in @types do
    { :ok, data |> normalize |> Poison.encode!(string: true) }
  end
  def serialize(_, _, _), do: :next

  defp normalize(data) when is_map(data) do
    data 
      |> Map.delete(:__attr__)
  end
  defp normalize(data), do: data
end