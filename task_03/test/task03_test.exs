defmodule Task03Test do
  use ExUnit.Case
  doctest Task03

  test "greets the world" do
    assert Task03.hello() == :world
  end
end
