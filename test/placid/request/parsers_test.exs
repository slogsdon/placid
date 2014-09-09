defmodule Placid.Request.ParsersTest do
  use ExUnit.Case, async: true
  import Plug.Test

  def parse(conn, opts \\ []) do
    opts = Keyword.put_new(opts, :parsers, [Placid.Request.Parsers.JSON])
    Plug.Parsers.call(conn, Plug.Parsers.init(opts))
  end

  test "parses json encoded bodies" do
    headers = [{"content-type", "application/json"}]
    conn = parse(conn(:post, "/post", "{\"foo\": \"baz\"}", headers: headers))
    assert conn.params["foo"] === "baz"
  end

  test "json parser errors when body too large" do
    exception = assert_raise Plug.Parsers.RequestTooLargeError, fn ->
      headers = [{"content-type", "application/json"}]
      parse(conn(:post, "/post", "{\"foo\": \"baz\"}", headers: headers), length: 5)
    end
    assert Plug.Exception.status(exception) === 413
  end
end