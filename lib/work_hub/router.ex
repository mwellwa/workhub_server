defmodule WorkHub.Router do
  alias WorkHub.Conn
  alias WorkHub.ProjectController
  alias WorkHub.ClientController

  def route(%Conn{method: "GET", path: "/clients"} = conn) do
    ClientController.index(conn)
  end

  def route(%Conn{method: "GET", path: "/projects"} = conn) do
    ProjectController.index(conn)
  end

  def route(%Conn{method: "GET", path: "/projects/project_1/documents"} = conn) do
    %{
      conn
      | status: 200,
        resp_body:
          "Project Charter 1, Project Business Case 1, Project Communications Plan 1, Project Budget 1"
    }
  end

  def route(%Conn{method: "GET", path: "/projects/project_2/documents"} = conn) do
    %{
      conn
      | status: 200,
        resp_body:
          "Project Charter 2, Project Business Case 2, Project Communications Plan 2, Project Budget 2"
    }
  end

  def route(%Conn{path: path} = conn) do
    %{conn | status: 404, resp_body: "404! File not found at path \"#{path}\"."}
  end
end
