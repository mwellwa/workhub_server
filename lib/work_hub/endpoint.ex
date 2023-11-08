defmodule WorkHub.Endpoint do
  @moduledoc "This module contains the common and initial path that all requests go through."
  alias WorkHub.Conn

  import WorkHub.Parser, only: [parse: 1]
  import WorkHub.Plugins, only: [log: 1, rewrite_path: 1, track: 1]
  import WorkHub.Router, only: [route: 1]

  def handle(request) do
    request
    |> parse
    |> log
    |> rewrite_path
    |> route
    |> track
    |> format_response
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
