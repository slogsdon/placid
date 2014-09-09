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
    before_plugs = Module.get_attribute(env.module, :plugs)
                   |> Enum.filter(fn { _, opts } ->
                      opts[:run] === nil || opts[:run] === :before
                   end)
                   |> remove_run_option
    after_plugs = Module.get_attribute(env.module, :plugs)
                  |> Enum.filter(fn { _, opts } ->
                    opts[:run] === :after
                  end)
                  |> remove_run_option

    quote do
      def init(opts) do
        opts
      end

      def call(conn, opts) do
        conn = do_call :before, conn, opts
        conn = apply __MODULE__, opts[:action], [ conn, opts[:args] ]
        do_call :after, conn, opts
      end

      defp do_call(:before, conn, opts) do
        plugs = only_match_action before_plugs, opts
        call_plug_stack conn, plugs
      end

      defp do_call(:after, conn, opts) do
        plugs = only_match_action after_plugs, opts
        call_plug_stack conn, plugs
      end

      defp call_plug_stack(conn, []), do: conn
      defp call_plug_stack(conn, stack) do
        Enum.reduce stack, conn, &call_plug(&2, &1)
      end

      defp call_plug(conn, { plug, opts }) do
        { conn, caller } = case Atom.to_char_list(plug) do
            'Elixir.' ++ _ ->
              conn = plug.call conn, plug.init(opts)
              { conn, "#{inspect plug}" }
            _ ->
              conn = apply __MODULE__, plug, [ conn, opts ]
              { conn, "#{plug}" }
          end 
        ensure_conn_returned conn, caller
      end

      defp only_match_action(stack, opts) do
        Enum.filter stack, fn { _, plug_opts } ->
          plug_opts[:only] === nil || 
          opts[:action] === plug_opts[:only] ||
          opts[:action] in plug_opts[:only]
        end
      end

      defp ensure_conn_returned(conn, caller) do
        case conn do
          %Plug.Conn{halted: true} = c ->
            c
          %Plug.Conn{} = c ->
            c
          _ ->
            raise "expected #{caller}/2 to return a Plug.Conn"
        end
      end

      defp before_plugs do
        unquote(before_plugs)
      end

      defp after_plugs do
        unquote(after_plugs)
      end
    end
  end

  defp remove_run_option(plugs) do
    Enum.map plugs, fn { plug, opts } ->
      { plug, opts |> Keyword.delete(:run) }
    end
  end
end