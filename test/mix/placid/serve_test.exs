defmodule Mix.Tasks.Placid.ServeTest do
  use ExUnit.Case

  test "raises ArgumentError when no router configured" do
    assert_raise ArgumentError, "a valid router must be configured", fn ->
      Mix.Tasks.Placid.Serve.run []
    end
  end
end