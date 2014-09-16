defmodule Placid.Request.TranslateExtensionsTest do
  use ExUnit.Case, async: true
  import Plug.Test

  test "translates json extension" do
    opts = Placid.Request.TranslateExtensions.init([])
    conn = conn(:get, "/get.json")
            |> Placid.Request.TranslateExtensions.call(opts)

    assert Plug.Conn.get_req_header(conn, "accept") === ["application/json"]
  end

  test "translates xml extension" do
    opts = Placid.Request.TranslateExtensions.init([])
    conn = conn(:get, "/get.xml")
            |> Placid.Request.TranslateExtensions.call(opts)

    assert Plug.Conn.get_req_header(conn, "accept") === ["application/xml"]
  end

  test "translates long path" do
    opts = Placid.Request.TranslateExtensions.init([])
    conn = conn(:get, "/users/get.json")
            |> Placid.Request.TranslateExtensions.call(opts)

    assert Plug.Conn.get_req_header(conn, "accept") === ["application/json"]
  end
end