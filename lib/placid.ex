defmodule Placid do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # worker(Placid.Worker, [arg1, arg2, arg3])
    ]

    opts = [strategy: :one_for_one, name: Placid.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
