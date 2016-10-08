defmodule Placid.Response.RenderingTest do
  use ExUnit.Case, async: true
  use Plug.Test
  import Plug.Conn
  alias Placid.Response.Rendering.UnsupportedResponseTypeError

  test "raises UnsupportedResponseTypeError when invalid content-type" do
    type = "json"
    message = "unsupported media type #{type}"
    assert_raise(UnsupportedResponseTypeError, message, fn ->
        conn(:get, "/json_list")
          |> put_req_header("accept", type)
          |> Placid.Response.RenderingTest.Router.call([])
      end)
  end

  test "raises UnsupportedResponseTypeError when no available engine" do
    type = "text/html"
    message = "unsupported media type #{type}"
    assert_raise(UnsupportedResponseTypeError, message, fn ->
        conn(:get, "/json_list")
          |> put_req_header("accept", type)
          |> Placid.Response.RenderingTest.Router.call([])
      end)
  end

  test "takes media type lists" do
    conn = conn(:get, "/json_list")
      |> put_req_header("accept", "application/xml; q=0.05, application/json, */*; q=0.01")
      |> Placid.Response.RenderingTest.Router.call([])

    assert get_resp_header(conn, "content-type") === ["application/json; charset=utf-8"]
  end

  test "encodes a json response with list" do
    conn = conn(:get, "/json_list")
      |> put_req_header("accept", "application/json")
      |> Placid.Response.RenderingTest.Router.call([])

    assert get_resp_header(conn, "content-type") === ["application/json; charset=utf-8"]
    assert conn.resp_body === "[{\"name\":\"bob\",\"id\":1}," <>
                               "{\"name\":\"john\",\"id\":2}]"
  end

  test "encodes a json response with map" do
    conn = conn(:get, "/json_map")
      |> put_req_header("accept", "application/json")
      |> Placid.Response.RenderingTest.Router.call([])

    assert get_resp_header(conn, "content-type") === ["application/json; charset=utf-8"]
    assert conn.resp_body === "{\"name\":\"bob\",\"id\":1}"
  end

  test "encodes a json response with struct" do
    conn = conn(:get, "/json_struct")
      |> put_req_header("accept", "application/json")
      |> Placid.Response.RenderingTest.Router.call([])

    assert get_resp_header(conn, "content-type") === ["application/json; charset=utf-8"]
    assert conn.resp_body === "{\"name\":\"bob\",\"id\":1}"
  end

  test "encodes a xml response with list" do
    conn = conn(:get, "/xml_list")
      |> put_req_header("accept", "application/xml")
      |> Placid.Response.RenderingTest.Router.call([])

    assert get_resp_header(conn, "content-type") === ["application/xml; charset=utf-8"]
    assert conn.resp_body === "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n<items>\n\t<item>\n\t\t<id>1</id>\n\t\t<name>bob</name>\n\t</item>\n\t<item>\n\t\t<id>2</id>\n\t\t<name>john</name>\n\t</item>\n</items>"
  end

  test "encodes a xml response with map" do
    conn = conn(:get, "/xml_map")
      |> put_req_header("accept", "application/xml")
      |> Placid.Response.RenderingTest.Router.call([])

    assert get_resp_header(conn, "content-type") === ["application/xml; charset=utf-8"]
    assert conn.resp_body === "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n<item>\n\t<id>1</id>\n\t<name>bob</name>\n</item>"
  end

  test "encodes a xml response with map and attrs" do
    conn = conn(:get, "/xml_map_with_attrs")
      |> put_req_header("accept", "application/xml")
      |> Placid.Response.RenderingTest.Router.call([])

    assert get_resp_header(conn, "content-type") === ["application/xml; charset=utf-8"]
    assert conn.resp_body === "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n<item status=\"new\">\n\t<id>1</id>\n\t<name>bob</name>\n</item>"
  end

  test "encodes a xml response with struct" do
    conn = conn(:get, "/xml_struct")
      |> put_req_header("accept", "application/xml")
      |> Placid.Response.RenderingTest.Router.call([])

    assert get_resp_header(conn, "content-type") === ["application/xml; charset=utf-8"]
    assert conn.resp_body === "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n<DataNoAttr>\n\t<id>1</id>\n\t<name>bob</name>\n</DataNoAttr>"
  end

  test "encodes a xml response with struct and attrs" do
    conn = conn(:get, "/xml_struct_with_attrs")
      |> put_req_header("accept", "application/xml")
      |> Placid.Response.RenderingTest.Router.call([])

    assert get_resp_header(conn, "content-type") === ["application/xml; charset=utf-8"]
    assert conn.resp_body === "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n<Data status=\"new\">\n\t<id>1</id>\n\t<name>bob</name>\n</Data>"
  end

  defmodule Router do
    use Placid.Router
    alias Placid.Response.RenderingTest.Handler

    get "/json_list",   Handler, :json_list
    get "/json_map",    Handler, :json_map
    get "/json_struct", Handler, :json_struct
    get "/xml_list",    Handler, :xml_list
    get "/xml_map",     Handler, :xml_map
    get "/xml_map_with_attrs",
                        Handler, :xml_map_with_attrs
    get "/xml_struct",  Handler, :xml_struct
    get "/xml_struct_with_attrs",
                        Handler, :xml_struct_with_attrs
  end

  defmodule Handler do
    use Placid.Handler

    defmodule Data do
      defstruct id: nil, name: nil, __attr__: nil
    end
    defmodule DataNoAttr do
      defstruct id: nil, name: nil
    end

    def json_list(conn, _args) do
      render conn, [
        %{id: 1, name: "bob"},
        %{id: 2, name: "john"}
      ]
    end

    def json_map(conn, _args) do
      render conn, %{id: 1, name: "bob"}
    end

    def json_struct(conn, _args) do
      render conn, %Data{id: 1, name: "bob"}
    end

    def xml_list(conn, _args) do
      render conn, [
        %{id: 1, name: "bob"},
        %{id: 2, name: "john"}
      ]
    end

    def xml_map(conn, _args) do
      render conn, %{id: 1, name: "bob"}
    end

    def xml_map_with_attrs(conn, _args) do
      render conn, %{id: 1, name: "bob", __attr__: %{"status" => "new"}}
    end

    def xml_struct(conn, _args) do
      render conn, %DataNoAttr{id: 1, name: "bob"}
    end

    def xml_struct_with_attrs(conn, _args) do
      render conn, %Data{id: 1, name: "bob", __attr__: %{"status" => "new"}}
    end
  end
end
