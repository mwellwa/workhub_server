defmodule WorkHub.Project do
  defstruct id: nil,
            name: "",
            client: "",
            documents: %{},
            team: %{},
            status: nil

  def is_complete?(project) do
    project.status == "complete"
  end
end
