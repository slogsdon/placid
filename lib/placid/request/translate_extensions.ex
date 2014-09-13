defmodule Placid.Request.TranslateExtensions do
  @module false
  def init(opts), do: opts

  def call(conn, _opts) do
    Enum.reduce(extensions, conn, &reduce(&2, &1))
  end

  defp extensions do
    %{ "json" => "application/json",
       "xml"  => "application/xml" }
  end

  defp reduce(conn, {ext, content_type}) do
    last = get_last(conn)
    if String.ends_with?(last, ext) do
      [_|reversed] = conn.path_info |> Enum.reverse
      path_info = [String.replace(last,".#{ext}","")|reversed] |> Enum.reverse
      %{ conn | req_headers: [{"accepts", content_type}] ++ conn.req_headers,
                path_info: path_info }
    else
      conn
    end
  end

  defp get_last(conn) do
    case conn.path_info |> Enum.reverse do
      [] -> ""
      [i] -> i
      [i|_] -> i
    end
  end
end