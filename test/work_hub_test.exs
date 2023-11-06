defmodule WorkHubTest do
  use ExUnit.Case
  doctest WorkHub

  test "greets the world" do
    assert WorkHub.hello() == :world
  end
end
