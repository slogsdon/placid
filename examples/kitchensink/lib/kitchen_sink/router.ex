defmodule KitchenSink.Router do
  use Placid.Router
  alias KitchenSink.Handlers.V1

  version "v1" do
    get "/",     V1.Main, :index
    get "/show", V1.Main, :show

    resource :users, V1.Users, arg: :user_id
    get "/users/:user_id/permissions", V1.UserPermissions, :index
  end
end
