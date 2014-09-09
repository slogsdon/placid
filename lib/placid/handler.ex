defmodule Placid.Handler do
  @moduledoc """
  All handler actions should have an arrity of 2, with the
  first argument being a `Plug.Conn` representing the current
  connection and the second argument being a `Keyword` list
  of any parameters captured in the route path.
  """

  @doc """
  Macro used to add necessary items to a handler.
  """
  defmacro __using__(_) do
    quote do
      import Plug.Conn
      import Plug.Builder, only: [plug: 1, plug: 2]
      import Placid.Handler
      import Placid.Response.Helpers
      @before_compile Placid.Handler
      @behaviour Plug
      Module.register_attribute(__MODULE__, :plugs, accumulate: true)
    end
  end

  @doc false
  defmacro __before_compile__(env) do
    plugs = Module.get_attribute(env.module, :plugs)
            |> Enum.map(fn { plug, opts } ->
              { plug, Keyword.put_new(opts, :run, :before) }
            end)

    plug_stacks = build_plug_stacks plugs

    quote do
      def init(opts) do
        opts
      end

      def call(conn, opts) do
        conn = do_call conn, :before, opts[:action]
        conn = apply __MODULE__, opts[:action], [ conn, opts[:args] ]
        do_call conn, :after, opts[:action]
      end

      unquote(plug_stacks)
    end
  end

  defp build_plug_stacks(plugs) do
    only_actions = get_only_actions plugs

    for action <- only_actions ++ [nil] do
      build_plug_stacks_for action, plugs
    end
  end

  defp build_plug_stacks_for(action, plugs) do
    before_body = build_calls_for(:before, action, plugs)
    after_body = build_calls_for(:after, action, plugs)

    quote do
      unquote(before_body)
      unquote(after_body)
    end
  end

  defp build_calls_for(before_or_after, nil, plugs) do
    { conn, body } = plugs
                  |> Enum.filter(fn { _, opts } ->
                    opts[:only] === nil
                  end)
                  |> Enum.filter(fn { _, opts } ->
                    opts[:run] === before_or_after
                  end)
                  |> Plug.Builder.compile

    quote do
      defp do_call(unquote(conn), unquote(before_or_after), _) do
        unquote(body)
      end
    end
  end
  defp build_calls_for(before_or_after, action, plugs) do
    { conn, body } = plugs
                  |> Enum.filter(fn { _, opts } ->
                    opts[:only] === nil || 
                    action === opts[:only] ||
                    action in opts[:only]
                  end)
                  |> Enum.filter(fn { _, opts } ->
                    opts[:run] === before_or_after
                  end)
                  |> Plug.Builder.compile

    quote do
      defp do_call(unquote(conn), unquote(before_or_after), unquote(action)) do
        unquote(body)
      end
    end
  end

  defp get_only_actions(plugs) do
    plugs
      |> Enum.filter(fn { _, opts } ->
        opts[:only] != nil
      end)
      |> Enum.flat_map(fn { _, opts } ->
        opts[:only]
      end)
      |> Enum.uniq
  end
end