defmodule Placid.Router do
  @moduledoc """
  `Placid.Router` defines an alternate format for `Plug.Router`
  routing. Supports all HTTP methods that `Plug.Router` supports.

  Routes are defined with the form:

      method route [guard], handler, action

  `method` is `get`, `post`, `put`, `patch`, `delete`, or `options`,
  each responsible for a single HTTP method. `method` can also be
  `any`, which will match on all HTTP methods. `handler` is any
  valid Elixir module name, and `action` is any valid function
  defined in the `handler` module.

  ## Example

      defmodule Router do
        use Placid.Router, plugs: [
          { Plugs.HotCodeReload, [] }
        ]

        # Define your routes here
        get "/", Hello, :index
        get "/pages/:id", Hello, :show
        post "/pages", Hello, :create
        put "/pages/:id" when id == 1, Hello, :show
      end
  """

  ## Macros

  @doc """
  Macro used to add necessary items to a router.
  """
  defmacro __using__(opts) do
    quote do
      import unquote(__MODULE__)
      import Plug.Conn
      use Plug.Router
      @before_compile unquote(__MODULE__)

      plug Plug.Parsers, parsers: [ Placid.Request.Parsers.JSON, 
                                    :urlencoded, 
                                    :multipart ]

      opts = unquote(opts)
      if opts[:plugs] do
        Enum.map opts[:plugs], fn({plug_module, plug_opts}) ->
          plug plug_module, plug_opts
        end
      end

      plug :match
      plug :dispatch
    end
  end

  @doc """
  Defines a default route to catch all unmatched routes.
  """
  defmacro __before_compile__(env) do
    module = env.module
    # From Placid.Router.Filters
    filters = Module.get_attribute(module, :filters)

    quote do
      # Our default match so Plug doesn't fall on its face
      # when accessing an undefined route
      Plug.Router.match _ do
        conn = var!(conn)
        Placid.Response.not_found conn
      end

      defp call_handler_action(%Plug.Conn{ state: :unset } = conn, handler, action, binding) do
        conn = call_before_filters(unquote(filters), action, conn)
        conn = apply handler, :call_action, [ action, 
                                              conn, 
                                              Keyword.delete(binding, :conn) ]
        call_after_filters(unquote(filters), action, conn)
      end
      defp call_handler_action(conn, _, _, _) do
        conn
      end
    end
  end

  @doc """
  Macro for defining `GET` routes.

  ## Arguments

  * `route` - `String|List`
  * `handler` - `Atom`
  * `action` - `Atom`
  """
  defmacro get(route, handler, action) do
    quote do
      get unquote(route), do: unquote(
        build_match handler, action
      )
    end
  end

  @doc """
  Macro for defining `POST` routes.

  ## Arguments

  * `route` - `String|List`
  * `handler` - `Atom`
  * `action` - `Atom`
  """
  defmacro post(route, handler, action) do
    quote do
      post unquote(route), do: unquote(
        build_match handler, action
      )
    end
  end

  @doc """
  Macro for defining `PUT` routes.

  ## Arguments

  * `route` - `String|List`
  * `handler` - `Atom`
  * `action` - `Atom`
  """
  defmacro put(route, handler, action) do
    quote do
      put unquote(route), do: unquote(
        build_match handler, action
      )
    end
  end

  @doc """
  Macro for defining `PATCH` routes.

  ## Arguments

  * `route` - `String|List`
  * `handler` - `Atom`
  * `action` - `Atom`
  """
  defmacro patch(route, handler, action) do
    quote do
      patch unquote(route), do: unquote(
        build_match handler, action
      )
    end
  end

  @doc """
  Macro for defining `DELETE` routes.

  ## Arguments

  * `route` - `String|List`
  * `handler` - `Atom`
  * `action` - `Atom`
  """
  defmacro delete(route, handler, action) do
    quote do
      delete unquote(route), do: unquote(
        build_match handler, action
      )
    end
  end

  @doc """
  Macro for defining `OPTIONS` routes.

  ## Arguments

  * `route` - `String|List`
  * `handler` - `Atom`
  * `action` - `Atom`
  """
  defmacro options(route, handler, action) do
    quote do
      options unquote(route), do: unquote(
        build_match handler, action
      )
    end
  end

  @doc """
  Macro for defining routes that match on all HTTP methods.

  ## Arguments

  * `route` - `String|List`
  * `handler` - `Atom`
  * `action` - `Atom`
  """
  defmacro any(route, handler, action) do
    quote do
      match unquote(route), do: unquote(
        build_match handler, action
      )
    end
  end

  @doc """
  Creates RESTful resource endpoints for a route/handler
  combination.

  ## Example

      resource "/path", Controller

  expands to

      get     "/path",                Controller, :index
      get     "/path" <> "/new",      Controller, :new
      post    "/path",                Controller, :create
      get     "/path" <> "/:id",      Controller, :show
      get     "/path" <> "/:id/edit", Controller, :edit
      put     "/path" <> "/:id",      Controller, :update
      patch   "/path" <> "/:id",      Controller, :patch
      delete  "/path" <> "/:id",      Controller, :delete

      options "/path" do
        var!(conn)
          |> resp(200, "") 
          |> put_resp_header("Allow", "HEAD,GET,POST") 
          |> send_resp
      end
      options "/path" <> "/new" do
        var!(conn)
          |> resp(200, "") 
          |> put_resp_header("Allow", "HEAD,GET") 
          |> send_resp
      end
      options "/path" <> "/:_id" do
        var!(conn)
          |> resp(200, "") 
          |> put_resp_header("Allow", "HEAD,GET,PUT,PATCH,DELETE") 
          |> send_resp
      end
      options "/path" <> "/:_id/edit" do
        var!(conn)
          |> resp(200, "") 
          |> put_resp_header("Allow", "HEAD,GET") 
          |> send_resp
      end
  """
  defmacro resource(route, handler) do
    quote do
      get     unquote(route),                unquote(handler), :index
      get     unquote(route) <> "/new",      unquote(handler), :new
      post    unquote(route),                unquote(handler), :create
      get     unquote(route) <> "/:id",      unquote(handler), :show
      get     unquote(route) <> "/:id/edit", unquote(handler), :edit
      put     unquote(route) <> "/:id",      unquote(handler), :update
      patch   unquote(route) <> "/:id",      unquote(handler), :patch
      delete  unquote(route) <> "/:id",      unquote(handler), :delete

      options unquote(route) do
        var!(conn)
          |> resp(200, "")
          |> put_resp_header("Allow", "HEAD,GET,POST")
          |> send_resp
      end
      options unquote(route <> "/new") do
        var!(conn)
          |> resp(200, "")
          |> put_resp_header("Allow", "HEAD,GET")
          |> send_resp
      end
      options unquote(route <> "/:_id") do
        var!(conn)
          |> resp(200, "")
          |> put_resp_header("Allow", "HEAD,GET,PUT,PATCH,DELETE")
          |> send_resp
      end
      options unquote(route <> "/:_id/edit") do
        var!(conn)
          |> resp(200, "")
          |> put_resp_header("Allow", "HEAD,GET")
          |> send_resp
      end
    end
  end

  defp build_match(handler, action) do
    quote do
      binding = binding()
      conn = var!(conn)

      # pass off to handler action
      call_handler_action conn, unquote(handler), unquote(action), binding
    end
  end
end
