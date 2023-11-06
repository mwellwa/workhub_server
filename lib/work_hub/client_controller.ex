defmodule WorkHub.ClientController do
  alias WorkHub.Clients

  defp client_item(client) do
    "<li>#{client.name}</li>"
  end

  def index(conn) do
    items =
      Clients.list_clients()
      |> Enum.map(&client_item/1)
      |> Enum.join()

    %{conn | status: 200, resp_body: "<ul>#{items}</ul>"}
  end
end
