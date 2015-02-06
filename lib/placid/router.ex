defmodule Placid.Router do
  @doc false
  defmacro __using__(_) do
    quote do
      use HttpRouter,
        default_content_type: "application/json; charset=utf-8"
    end
  end
end
