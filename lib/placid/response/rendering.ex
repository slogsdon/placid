defmodule Placid.Response.Rendering do
  defmodule UnsupportedResponseTypeError do
    @moduledoc """
    Error raised when a rendering engine cannot be found
    for a specified response content type.
    """

    defexception [ :message ]
  end

  @moduledoc """
  Rendering

  ## Engines

  behaviour

  implementations
  """

  alias Placid.Response.Rendering.Engines
  
  @unsent  [ :unset, :set ]
  @engines [ Engines.JSON,
             Engines.XML ]

  def serialize_to_body(%Plug.Conn{ state: state } = conn, data, content_type) when state in @unsent do
    engines = Application.get_env(:placid, :rendering_engines, @engines)
    case Plug.Conn.Utils.content_type content_type do
      { :ok, type, subtype, _params } ->
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