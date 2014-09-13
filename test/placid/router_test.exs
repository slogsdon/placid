defmodule Placid.RouterTest do
  use ExUnit.Case, async: true
  use Plug.Test
  use Placid.Router

  test "get/3" do
    conn = conn(:get, "/1/get")
      |> Placid.RouterTest.Router.call([])

    assert conn.state === :sent
    assert conn.status === 200
  end

  test "post/3" do
    conn = conn(:post, "/1/post")
      |> Placid.RouterTest.Router.call([])

    assert conn.state === :sent
    assert conn.status === 200
  end

  test "put/3" do
    conn = conn(:put, "/1/put")
      |> Placid.RouterTest.Router.call([])

    assert conn.state === :sent
    assert conn.status === 200
  end

  test "patch/3" do
    conn = conn(:patch, "/1/patch")
      |> Placid.RouterTest.Router.call([])

    assert conn.state === :sent
    assert conn.status === 200
  end

  test "delete/3" do
    conn = conn(:delete, "/1/delete")
      |> Placid.RouterTest.Router.call([])

    assert conn.state === :sent
    assert conn.status === 200
  end

  test "options/3" do
    conn = conn(:options, "/1/options")
      |> Placid.RouterTest.Router.call([])

    assert conn.state === :sent
    assert conn.status === 200
  end

  test "any/3 any" do
    conn = conn(:any, "/1/any")
      |> Placid.RouterTest.Router.call([])

    assert conn.state === :sent
    assert conn.status === 200
  end

  test "any/3 get" do
    conn = conn(:get, "/1/any")
      |> Placid.RouterTest.Router.call([])

    assert conn.state === :sent
    assert conn.status === 200
  end

  test "raw/4 trace" do
    conn = conn(:trace, "/1/trace")
      |> Placid.RouterTest.Router.call([])

    assert conn.state === :sent
    assert conn.status === 200
  end

  test "resource/2" do
    assert true === true
  end

  test "resource/2 index" do
    conn = conn(:get, "/1/users")
      |> Placid.RouterTest.Router.call([])

    assert conn.state === :sent
    assert conn.status === 200
  end

  test "resource/2 create" do
    conn = conn(:post, "/1/users")
      |> Placid.RouterTest.Router.call([])

    assert conn.state === :sent
    assert conn.status === 200
  end

  test "resource/2 show" do
    conn = conn(:get, "/1/users/1")
      |> Placid.RouterTest.Router.call([])

    assert conn.state === :sent
    assert conn.status === 200
  end

  test "resource/2 update" do
    conn = conn(:put, "/1/users/1")
      |> Placid.RouterTest.Router.call([])

    assert conn.state === :sent
    assert conn.status === 200
  end

  test "resource/2 patch" do
    conn = conn(:patch, "/1/users/1")
      |> Placid.RouterTest.Router.call([])

    assert conn.state === :sent
    assert conn.status === 200
  end

  test "resource/2 delete" do
    conn = conn(:delete, "/1/users/1")
      |> Placid.RouterTest.Router.call([])

    assert conn.state === :sent
    assert conn.status === 200
  end

  test "filter plug is run" do
    conn = conn(:get, "/1/get")
      |> Placid.RouterTest.Router.call([])

    assert conn.state === :sent
    assert conn.status === 200
    assert get_resp_header(conn, "content-type") === ["application/json; charset=utf-8"]
  end

  test "resource/2 index with prepended path" do
    conn = conn(:get, "/1/users/1/comments")
      |> Placid.RouterTest.Router.call([])

    assert conn.state === :sent
    assert conn.status === 200
  end

  test "get/3 with translate ext to accepts header" do
    conn = conn(:get, "/1/get.json")
      |> Placid.RouterTest.Router.call([])

    assert conn.state === :sent
    assert conn.status === 200
    assert get_req_header(conn, "accepts") === ["application/json"]
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
    def trace(conn, _args) do
      conn
        |> Map.put(:resp_body, "")
        |> Map.put(:status, 200)
        |> Map.put(:state, :set)
        |> raw
    end
  end

  defmodule Bar do
    use Placid.Handler

    def index(conn, _args) do
      conn
        |> Map.put(:resp_body, "")
        |> Map.put(:status, 200)
        |> Map.put(:state, :set)
        |> raw
    end
    def create(conn, _args) do
      conn
        |> Map.put(:resp_body, "")
        |> Map.put(:status, 200)
        |> Map.put(:state, :set)
        |> raw
    end
    def show(conn, _args) do
      conn
        |> Map.put(:resp_body, "")
        |> Map.put(:status, 200)
        |> Map.put(:state, :set)
        |> raw
    end
    def update(conn, _args) do
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
  end

  defmodule Baz do
    use Placid.Handler

    def index(conn, _args) do
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

    version "1" do
      get         "/get",     Foo, :get
      get         "/get/:id", Foo, :get
      post        "/post",    Foo, :post
      put         "/put",     Foo, :put
      patch       "/patch",   Foo, :patch
      delete      "/delete",  Foo, :delete
      options     "/options", "HEAD,GET"
      any         "/any",     Foo, :any
      raw :trace, "/trace",   Foo, :trace

      resource :users,    Bar
      resource :comments, Baz, prepend_path: "/users/:user_id", 
                               only: [:index]
    end

    def set_utf8_json(%Plug.Conn{state: state} = conn, _) when state in [:unset, :set] do
      conn |> put_resp_header("content-type", "application/json; charset=utf-8")
    end
    def set_utf8_json(conn, _), do: conn
  end
end
