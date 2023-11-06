defmodule WorkHub.Plugs do
  alias WorkHub.Conn

  def log(conn), do: IO.inspect(conn)

  def rewrite_path(%Conn{path: "/projects/" <> subpath} = conn) do
    [segment_hd | _] = String.split(subpath, "/")

    case segment_hd do
      "project_" <> id -> rewrite_spath(id, conn)
      _segment -> conn
    end
  end

  def rewrite_path(%Conn{} = conn), do: conn

  def rewrite_spath(id, conn) do
    %{conn | path: "/projects/project_#{id}/documents"}
  end

  def track(%Conn{status: 404, path: path} = conn) do
    IO.puts("Warning! #{path} not found!")
    conn
  end

  def track(%Conn{} = conn), do: conn
end
