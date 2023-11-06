defmodule WorkHub.Portfolio do
  alias WorkHub.Project

  def list_projects do
    [
      %Project{id: 1, name: "Project 1", client: "Client 1", status: "In Progress"},
      %Project{id: 2, name: "Project 2", client: "Client 2", status: "Completed"},
      %Project{id: 3, name: "Project 3", client: "Client 3", status: "Completed"},
      %Project{id: 4, name: "Project 4", client: "Client 4", status: "Not Started"},
      %Project{id: 5, name: "Project 5", client: "Client 5", status: "In Progress"}
    ]
  end

  def get_project(id) when is_integer(id) do
    Enum.find(list_projects(), fn p -> p.id == id end)
  end

  def get_project(id) when is_binary(id) do
    id |> String.to_integer() |> get_project
  end
end
