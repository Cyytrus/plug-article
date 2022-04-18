defmodule PlugExampleTest do
  use ExUnit.Case
  doctest PlugExample

  test "greets the world" do
    assert PlugExample.hello() == :world
  end
end
