defmodule Mix.Tasks.Placid.Serve do
  use Mix.Task
  alias Mix.Tasks.Placid.ServeTest

  @shortdoc "Runs Placid and children"
  @recursive true

  @moduledoc """
  Runs Placid and all registered children in their servers.
  """
  def run(args) do
    Mix.Task.run "app.start", args
    router = Placid.Config.get(:placid, :router)
    
    unless router do
      raise ArgumentError, message: "a valid router must be configured"
    end
    
    router.run

    unless (Code.ensure_loaded?(IEx) && IEx.started?) || Code.ensure_loaded?(ServeTest) do 
      :timer.sleep(:infinity)
    end
  end
end