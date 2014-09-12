defmodule Placid.Response.Rendering.Engine do
  @moduledoc false
  use Behaviour

  @type data :: Map | List

  defcallback serialize(data, binary, binary) :: { :ok, binary } | :next
end