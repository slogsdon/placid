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
    use Behaviour

    @type data    :: Keyword | Map | List
    @type type    :: binary
    @type subtype :: binary

    defcallback serialize(data, type, subtype) :: { :ok, binary } | :next
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
        use Behaviour

        @type data    :: Keyword | Map | List
        @type type    :: binary
        @type subtype :: binary

        defcallback serialize(data, type, subtype) :: { :ok, binary } | :next
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
  def serialize_to_body(%Plug.Conn{ state: state } = conn, data, content_type) when state in @unsent do
    case Plug.Conn.Utils.media_type content_type do
      { :ok, type, subtype, _params } ->
        engines = Application.get_env(:placid, :rendering_engines, @engines)
        body = reduce engines, data, type, subtype
        %Plug.Conn{ conn | resp_body: body, state: :set }
      :error ->
        raise UnsupportedResponseTypeError, message: "unsupported media type #{content_type}"
    end
  end
  def serialize_to_body(conn, _data, _ct), do: conn

  defp reduce([engine|engines], data, type, subtype) do
    case engine.serialize(data, type, subtype) do
      { :ok, body } -> body
      :next -> reduce engines, data, type, subtype
    end
  end
  defp reduce([], _, type, subtype) do
    raise UnsupportedResponseTypeError, message: "unsupported media type #{type}/#{subtype}"
  end
end