defmodule Placid.Response.StatusCode do
  defstruct code: 0, reason: ""

  @type t :: %Placid.Response.StatusCode{
    code:   100..999,
    reason: binary
  }
end