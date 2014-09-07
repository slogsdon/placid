defmodule Placid.Handler do
  @doc """
  Macro used to add necessary items to a handler.
  """
  defmacro __using__(_) do
    quote do
      import unquote(__MODULE__)
      import unquote(Plug.Conn)
      use unquote(Placid.Response.Helpers)
    end
  end
end