defmodule Placid.ConfigTest do
  use ExUnit.Case, async: true
  import Placid.Config

  test "get/1" do
    assert get(:router) === nil
  end

  test "get/2" do
    assert get(Router, :https_only) === nil
  end

  test "get/3" do
    assert get(:placid, :router, Router) === Router
    assert get(Router, :https_only, false) === false
  end
end