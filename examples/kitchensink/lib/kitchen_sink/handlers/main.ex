defmodule KitchenSink.Handlers.Main do
  use Placid.Handler

  plug :set_json, run: :before
  plug :set_assign, run: :before, only: [:show]

  plug :send_response, run: :after, only: [:show]
  plug :set_private, run: :after

  def index(conn, _args) do
    conn |> resp(200, "[]")
  end

  def show(conn, _args) do
    conn |> resp(200, "[]")
  end

  ## Hooks

  def set_json(conn, _) do
    conn |> put_resp_header("content-type", "application/json; charset=utf-8")
  end

  def set_assign(conn, _) do
    conn |> assign(:id, 1)
  end

  def send_response(conn, _) do
    conn |> send_resp
  end

  def set_private(conn, _) do
    conn |> assign_private(:id, 2)
  end
end
