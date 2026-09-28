defmodule CodeleTest do
  use ExUnit.Case
  doctest Codele

  test "greets the world" do
    assert Codele.hello() == :world
  end
end
