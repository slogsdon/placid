defmodule Placid.Response.Helpers do
  @moduledoc """
  Placid bundles these response helpers with handlers to 
  assist in sending a response:

  * `render/4` - `conn`, `data`, `opts` - sends a normal response.
  * `halt!/2` - `conn`, `opts` - ends the response.
  * `not_found/1` - `conn`, `message` - sends a 404 (Not found) response.
  * `raw/1` - `conn` - sends response as-is. It is expected
    that status codes, headers, body, etc have been set by
    the handler action.

  #### Example

      defmodule Hello do
        use Placid.Handler

        def index(conn, []) do
          render conn, "showing index handler"
        end

        def show(conn, args) do
          render conn, "showing page \#{args[:id]}"
        end

        def create(conn, []) do
          render conn, "page created"
        end
      end
  """

  import Plug.Conn
  alias Placid.Response.Rendering
  alias Placid.Response.StatusCode

  @type status_code :: atom | 100..999
  @type enumerable  :: Map | List

  @doc """
  sets connection status

  ## Arguments

  * `conn` - `Plug.Conn`
  * `status_code` - `Integer`

  ## Returns

  `Plug.Conn`
  """
  @spec status(Plug.Conn.t, status_code) :: Plug.Conn.t
  def status(conn, status_code) when is_integer(status_code)
                                when is_atom(status_code) do
    %StatusCode{ code: code } = status_code |> StatusCode.find
    %Plug.Conn{ conn | status: code, 
                       state: :set }
  end

  @doc """
  sets response headers

  ## Arguments

  * `conn` - `Plug.Conn`
  * `headers` - `Map`

  ## Returns

  `Plug.Conn`
  """
  @spec headers(Plug.Conn.t, Plug.Conn.headers) :: Plug.Conn.t
  def headers(conn, headers) do
    %Plug.Conn{ conn | resp_headers: headers, 
                       state: :set }
  end

  @doc """
  Sends response as-is. It is expected that status codes,
  headers, body, etc have been set by the handler
  action.

  ## Arguments

  * `conn` - `Plug.Conn`

  ## Returns

  `Plug.Conn`
  """
  @spec raw(Plug.Conn.t) :: Plug.Conn.t
  def raw(conn) do
    conn |> send_resp
  end

  @doc """
  Sends a normal response.

  ## Arguments

  * `conn` - `Plug.Conn`
  * `data` - `Enumerable`
  * `opts` - `Keyword`

  ## Returns

  `Plug.Conn`
  """
  @spec render(Plug.Conn.t, enumerable, Keyword.t) :: Plug.Conn.t
  def render(conn, data, opts \\ []) do
    req_ct = case Plug.Conn.get_req_header(conn, "content-type") do
      [ct] -> ct
      _ -> Application.get_env(:placid, :default_content_type, "application/json")
    end
    content_type = Keyword.get(opts, :content_type, req_ct)
    %StatusCode{ code: code } = Keyword.get(opts, :status, :ok)
                                |> StatusCode.find
    conn = Rendering.serialize_to_body(conn, data, content_type)

    conn
      |> put_resp_content_type_if_not_sent(content_type)
      |> put_status(code)
      |> send_resp_if_not_sent
  end

  @doc """
  Ends the response.

  ## Arguments

  * `conn` - `Plug.Conn`
  * `opts` - `Keyword`

  ## Returns

  `Plug.Conn`
  """
  @spec halt!(Plug.Conn.t, Keyword.t) :: Plug.Conn.t
  def halt!(conn, opts \\ []) do
    opts = [ status: 401] |> Keyword.merge opts
    %StatusCode{ code: code, reason: reason } = opts[:status] |> StatusCode.find
    conn
      |> send_resp_if_not_sent(code, reason)
  end

  @doc """
  Sends a 404 (Not found) response.

  ## Arguments

  * `conn` - `Plug.Conn`

  ## Returns

  `Plug.Conn`
  """
  @spec not_found(Plug.Conn.t, binary) :: Plug.Conn.t
  def not_found(conn, message \\ "Not Found") do
    conn
      |> send_resp_if_not_sent(404, message)
  end

  @doc """
  Forwards the response to another handler action.

  ## Arguments

  * `conn` - `Plug.Conn`
  * `handler` - `Atom`
  * `action` - `Atom`
  * `args` - `Keyword`

  ## Returns

  `Plug.Conn`
  """
  @spec forward(Plug.Conn.t, atom, atom, Keyword.t) :: Plug.Conn.t
  def forward(conn, handler, action, args \\ []) do
    handler.call conn, [ action: action, args: args ++ conn.params ]
  end

  @doc """
  Redirects the response.

  ## Arguments

  * `conn` - `Plug.Conn`
  * `location` - `String`
  * `opts` - `Keyword`

  ## Returns

  `Plug.Conn`
  """
  @spec redirect(Plug.Conn.t, binary, Keyword.t) :: Plug.Conn.t
  def redirect(conn, location, opts \\ []) do
    opts = [ status: 302 ] |> Keyword.merge opts
    %StatusCode{code: code, reason: reason} = opts[:status] |> StatusCode.find   
    conn
      |> put_resp_header_if_not_sent("Location", location)
      |> send_resp_if_not_sent(code, reason)
  end

  defp put_status(conn, status), do: %Plug.Conn{ conn | status: status }

  defp put_resp_header_if_not_sent(%Plug.Conn{ state: :sent } = conn, _, _) do
    conn
  end
  defp put_resp_header_if_not_sent(conn, key, value) do
    conn |> put_resp_header(key, value)
  end

  defp put_resp_content_type_if_not_sent(%Plug.Conn{ state: :sent } = conn, _) do
    conn
  end
  defp put_resp_content_type_if_not_sent(conn, resp_content_type) do
    conn |> put_resp_content_type(resp_content_type)
  end

  defp send_resp_if_not_sent(%Plug.Conn{ state: :sent } = conn) do
    conn
  end
  defp send_resp_if_not_sent(%Plug.Conn{} = conn) do
    conn |> send_resp
  end
  defp send_resp_if_not_sent(%Plug.Conn{ state: :sent } = conn, _, _) do
    conn
  end
  defp send_resp_if_not_sent(conn, status, body) do
    conn |> send_resp(status, body)
  end
end
