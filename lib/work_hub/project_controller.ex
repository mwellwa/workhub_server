defmodule WorkHub.ProjectController do
  alias WorkHub.Portfolio
  # alias WorkHub.Project

  defp project_item(project) do
    "<li>#{project.name} - #{project.client} - #{project.status}</li>"
  end

  def index(conn) do
    items =
      Portfolio.list_projects()
      |> Enum.map(&project_item/1)
      |> Enum.join()

    %{conn | status: 200, resp_body: "<ul>#{items}</ul>"}
  end

  def show(conn, %{"id" => id}) do
    project = Portfolio.get_project(id)

    %{conn | status: 200, resp_body: "<h1>#{project.name}</h1>"}
  end

  def create(conn, %{"name" => name, "client" => client}) do
    %{conn | status: 201, resp_body: "Created the project: #{name} for #{client}!"}
  end
end
