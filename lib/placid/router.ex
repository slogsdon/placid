defmodule Placid.Router do
  @doc false
  defmacro __using__(_) do
    quote do
      use HttpRouter,
        default_content_type: "application/json; charset=utf-8"

      def run(opts \\ nil) do
        adapter = Placid.Config.get(:placid, :plug_adapter, Plug.Adapters.Cowboy)
        opts = opts || Placid.Config.get(__MODULE__)

        adapter.https __MODULE__, [], opts[:https]
        if opts[:https_only] do
          # Sends `403 Forbidden` to all HTTP requests
          adapter.http Placid.Request.HttpsOnly, [], opts[:http]
        else
          adapter.http __MODULE__, [], opts[:http]
        end
      end
    end
  end
end
