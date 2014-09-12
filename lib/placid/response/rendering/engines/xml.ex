defmodule Placid.Response.Rendering.Engines.XML do
  @moduledoc false
  @behaviour Placid.Response.Rendering.Engine

  @types [ "application", "text" ]

  def serialize(data, type, "xml") when type in @types do
    xml = [ :_doc_type | [data |> xmlify] ]
    { :ok, xml |> XmlBuilder.generate }
  end
  def serialize(_, _, _), do: :next

  defp xmlify(list) when is_list(list) do
    { "items", nil, list |> Enum.map(&xmlify(&1)) }
  end
  defp xmlify(%{__struct__: name, __attr__: attrs} = data) do
    { get_name(name), attrs, normalize(data) }
  end
  defp xmlify(%{__struct__: name} = data) do
    { get_name(name), nil, normalize(data) }
  end
  defp xmlify(data) when is_map(data) do
    { "item", Map.get(data, :__attr__), normalize(data) }
  end
  defp xmlify({ name, data }) do
    { name, nil, xmlify(data) }
  end
  defp xmlify(data) do
    data
  end

  defp get_name(module) do
    module 
      |> Module.split 
      |> Enum.reverse 
      |> hd
  end

  defp normalize(data) when is_map(data) do
    data 
      |> Map.delete(:__attr__) 
      |> Map.delete(:__struct__)
      |> Enum.map(fn pair ->
        xmlify pair
      end)
  end
end