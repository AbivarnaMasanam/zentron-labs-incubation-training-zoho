defmodule Getinput do
  def run do
    "How many numbers do you want to insert? "
    |> IO.gets()
    |> String.trim()
    |> String.to_integer()
  end
end
