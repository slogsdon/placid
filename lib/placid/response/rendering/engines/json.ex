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

  def normalize_content_type("*", "json"), do:        {"application","json"}
  def normalize_content_type("application", "*"), do: {"application","json"}
  def normalize_content_type("text", "*"), do:        {"text","json"}
  def normalize_content_type("*", "*"), do:           {"application","json"}
  def normalize_content_type(type, subtype), do:      {type, subtype}
  
end
