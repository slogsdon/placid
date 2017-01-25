defmodule Placid.Response.Rendering do
  defmodule UnsupportedResponseTypeError do
    @moduledoc """
    Error raised when a rendering engine cannot be found
    for a specified response content type.
    """

    defexception [ :message ]
  end

  defmodule Engine do
    @moduledoc false

    @type data    :: Keyword | Map | List
    @type type    :: binary
    @type subtype :: binary

    @callback serialize(data, type, subtype) :: { :ok, binary } | :next
  end

  @moduledoc """
  `Placid.Response.Rendering` provides the ability for a response to be
  automatically serialized based on its content-type.

  ## Engines

  Rendering engines translate Elixir terms into a serialized format. Each engine
  is responsible for a single type of content and is capable of rendering for
  multiple mime types.

  Rendering engines should implement callbacks for the following behaviour:

      defmodule Placid.Response.Rendering.Engine do
        @type data    :: Keyword | Map | List
        @type type    :: binary
        @type subtype :: binary

        @callback serialize(data, type, subtype) :: { :ok, binary } | :next
      end

  Current, built-in implementations include:

  * `Placid.Response.Rendering.Engines.JSON`
  * `Placid.Response.Rendering.Engines.XML`
  """

  alias Placid.Response.Rendering.Engines

  @unsent  [ :unset, :set ]
  @engines [ Engines.JSON,
             Engines.XML ]

  @doc """
  Serializes `data` when an available rendering engine exists for the given
  `content_type`.

  ## Arguments

  * `conn` - `Plug.Conn` - the current connection
  * `data` - `List` | `Map` | `Struct` - Elixir terms to be serialized
  * `content_type` - `String` - response content-type

  ## Returns

  `Plug.Conn`
  """
  def serialize_to_body(%Plug.Conn{ state: state } = conn, data, accept) when state in @unsent do
    engines = Application.get_env(:placid, :rendering_engines, @engines)
    # Extract media types
    resp = Plug.Conn.Utils.list(accept) |> Enum.map(&Plug.Conn.Utils.media_type/1) |>
    # Remove errors
    Enum.filter(fn :error -> false
                    _ -> true end) |>
    # Sort by quality
    Enum.sort_by(fn {:ok, _type, _subtype, %{"q" => q}} -> String.to_float(q)
                    {:ok, _type, _subtype, %{}} -> 1
                    :error -> 0
    end) |>
    # Descending order
    Enum.reverse |>
    # Attempt rendering with a matching engine
    reduce_types(data, engines)
    if is_nil(resp) do
      raise UnsupportedResponseTypeError, message: "unsupported media type #{accept}"
    else
      {type, subtype, body} = resp
      %Plug.Conn{ conn | resp_body: body, state: :set } |> Plug.Conn.put_resp_content_type("#{type}/#{subtype}")
    end
  end
  def serialize_to_body(conn, _data, _ct), do: conn

  defp reduce_types([{:ok, type, subtype, _params}|types], data, engines) do
    case reduce(engines, data, type, subtype) do
      nil ->
        reduce_types(types, data, engines)
      {_type, _subtype_, _body} = resp ->
        resp
    end
  end
  defp reduce_types([], _data, _engines) do
    nil
  end

  defp reduce([engine|engines], data, type, subtype) do
    case engine.serialize(data, type, subtype) do
      { :ok, body } ->
        {type, subtype} = engine.normalize_content_type(type, subtype)
        {type, subtype, body}
      :next -> reduce engines, data, type, subtype
    end
  end
  defp reduce([], _, _type, _subtype) do
    nil
  end
end
