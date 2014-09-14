defmodule KitchenSink.Router do
  use Placid.Router
  alias KitchenSink.Handlers

  get "/",     Handlers.Main, :index
  get "/show", Handlers.Main, :show
end
