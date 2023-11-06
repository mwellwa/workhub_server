defmodule WorkHub.Clients do
  alias WorkHub.Client

  def list_clients do
    [
      %Client{
        id: 1,
        name: "Client 1",
        contact: "1234567891",
        rel_manager: ["Mwelwa Chipimo"],
        projects: ["Project 1"]
      },
      %Client{
        id: 2,
        name: "Client 2",
        contact: "1234567892",
        rel_manager: ["Mwelwa Chipimo"],
        projects: ["Project 2"]
      },
      %Client{
        id: 3,
        name: "Client 3",
        contact: "1234567893",
        rel_manager: ["Mwelwa Chipimo"],
        projects: ["Project 3"]
      },
      %Client{
        id: 4,
        name: "Client 4",
        contact: "1234567894",
        rel_manager: ["Mwelwa Chipimo"],
        projects: ["Project 4"]
      }
    ]
  end

  def get_client(id) when is_integer(id) do
    Enum.find(list_clients(), fn c -> c.id == id end)
  end

  def get_client(id) when is_binary(id) do
    id |> String.to_integer() |> get_client
  end
end
