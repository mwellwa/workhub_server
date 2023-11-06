defmodule WorkHub.Endpoint do
  @moduledoc "This module contains the common and initial path that all requests go through."
  alias WorkHub.Conn
  alias WorkHub.ProjectController
  alias WorkHub.ClientController

  import WorkHub.Parser, only: [parse: 1]
  import WorkHub.Plugs, only: [log: 1, rewrite_path: 1, track: 1]

  def handle(request) do
    request
    |> parse
    |> log
    |> rewrite_path
    |> route
    |> track
    |> format_response
  end

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

  def format_response(conn) do
    """
    HTTP/1.1 #{Conn.full_status(conn)}
    Content-Type: text/html
    Content-Length: #{String.length(conn.resp_body)}

    #{conn.resp_body}
    """
  end
end

request = """
GET /clients HTTP/1.1
Host: workhubup.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = WorkHub.Endpoint.handle(request)

IO.puts(response)

request = """
GET /projects HTTP/1.1
Host: workhubup.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = WorkHub.Endpoint.handle(request)

IO.puts(response)

request = """
GET /projects/project_1/documents HTTP/1.1
Host: workhubup.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = WorkHub.Endpoint.handle(request)

IO.puts(response)

request = """
GET /projects/project_1 HTTP/1.1
Host: workhubup.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = WorkHub.Endpoint.handle(request)

IO.puts(response)

request = """
GET /projects/project_2/documents HTTP/1.1
Host: workhubup.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = WorkHub.Endpoint.handle(request)

IO.puts(response)

request = """
GET /projects/project_2 HTTP/1.1
Host: workhubup.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = WorkHub.Endpoint.handle(request)

IO.puts(response)

request = """
GET /projects/project_2/ HTTP/1.1
Host: workhubup.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = WorkHub.Endpoint.handle(request)

IO.puts(response)

request = """
GET /projects/documents HTTP/1.1
Host: workhubup.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = WorkHub.Endpoint.handle(request)

IO.puts(response)
