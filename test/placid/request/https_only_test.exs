defmodule Placid.Request.HttpsOnlyTest do
  use ExUnit.Case, async: true
  import Plug.Test

  test "translates json extension" do
    opts = Placid.Request.HttpsOnly.init([])
    conn = conn(:get, "/get.json")
            |> Placid.Request.HttpsOnly.call(opts)

    assert conn.status === 403
    assert conn.resp_body === "Forbidden"
  end
end