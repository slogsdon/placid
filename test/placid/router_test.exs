defmodule Placid.RouterTest do
  use ExUnit.Case, async: true
  use Plug.Test
  use Placid.Router

  test "get/3" do
    conn = conn(:get, "/get")
      |> Placid.RouterTest.Router.call([])

    assert conn.state === :sent
    assert conn.status === 200
  end

  test "post/3" do
    conn = conn(:post, "/post")
      |> Placid.RouterTest.Router.call([])

    assert conn.state === :sent
    assert conn.status === 200
  end

  test "put/3" do
    conn = conn(:put, "/put")
      |> Placid.RouterTest.Router.call([])

    assert conn.state === :sent
    assert conn.status === 200
  end

  test "patch/3" do
    conn = conn(:patch, "/patch")
      |> Placid.RouterTest.Router.call([])

    assert conn.state === :sent
    assert conn.status === 200
  end

  test "delete/3" do
    conn = conn(:delete, "/delete")
      |> Placid.RouterTest.Router.call([])

    assert conn.state === :sent
    assert conn.status === 200
  end

  test "options/3" do
    conn = conn(:options, "/options")
      |> Placid.RouterTest.Router.call([])

    assert conn.state === :sent
    assert conn.status === 200
  end

  test "any/3 any" do
    conn = conn(:any, "/any")
      |> Placid.RouterTest.Router.call([])

    assert conn.state === :sent
    assert conn.status === 200
  end

  test "any/3 get" do
    conn = conn(:get, "/any")
      |> Placid.RouterTest.Router.call([])

    assert conn.state === :sent
    assert conn.status === 200
  end

  test "resource/2" do
    assert true === true
  end

  test "parses json encoded bodies" do
    headers = [{"content-type", "application/json"}]
    conn = conn(:post, "/post", "{\"foo\": \"baz\"}", headers: headers)
      |> Placid.RouterTest.Router.call([])
    assert conn.state === :sent
    assert conn.status === 200
    assert conn.params["foo"] == "baz"
  end

  test "filter plug is run" do
    conn = conn(:get, "/get")
      |> Placid.RouterTest.Router.call([])

    assert conn.state === :sent
    assert conn.status === 200
    assert get_resp_header(conn, "content-type") === ["application/json; charset=utf-8"]
  end

  defmodule Foo do
    use Placid.Handler

    def get(conn, _args) do
      conn
        |> Map.put(:resp_body, "")
        |> Map.put(:status, 200)
        |> Map.put(:state, :set)
        |> raw
    end
    def post(conn, _args) do
      conn
        |> Map.put(:resp_body, "")
        |> Map.put(:status, 200)
        |> Map.put(:state, :set)
        |> raw
    end
    def put(conn, _args) do
      conn
        |> Map.put(:resp_body, "")
        |> Map.put(:status, 200)
        |> Map.put(:state, :set)
        |> raw
    end
    def patch(conn, _args) do
      conn
        |> Map.put(:resp_body, "")
        |> Map.put(:status, 200)
        |> Map.put(:state, :set)
        |> raw
    end
    def delete(conn, _args) do
      conn
        |> Map.put(:resp_body, "")
        |> Map.put(:status, 200)
        |> Map.put(:state, :set)
        |> raw
    end
    def options(conn, _args) do
      conn
        |> Map.put(:resp_body, "")
        |> Map.put(:status, 200)
        |> Map.put(:state, :set)
        |> raw
    end
    def any(conn, _args) do
      conn
        |> Map.put(:resp_body, "")
        |> Map.put(:status, 200)
        |> Map.put(:state, :set)
        |> raw
    end
  end

  defmodule Router do
    use Placid.Router

    plug :set_utf8_json

    get      "/get",     Foo, :get
    post     "/post",    Foo, :post
    put      "/put",     Foo, :put
    patch    "/patch",   Foo, :patch
    delete   "/delete",  Foo, :delete
    options  "/options", "HEAD,GET"
    any      "/any",     Foo, :any

    def set_utf8_json(%Plug.Conn{state: state} = conn, _) when state in [:unset, :set] do
      conn |> put_resp_header("content-type", "application/json; charset=utf-8")
    end
    def set_utf8_json(conn, _), do: conn
  end
end
