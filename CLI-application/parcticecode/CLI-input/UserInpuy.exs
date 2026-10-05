defmodule UserInput do
  def input(promt) do
    IO.gets(promt)
    |> String.trim()
  end

  def calling do
    name = input("Enter your Name: ")

    age =
      input("Enter your Age: ")
      |> String.to_integer()

    city = input("Enter you City: ")

    IO.puts("Name: #{name}")
    IO.puts("Age: #{age}")
    IO.puts("City: #{city}")
  end
end

UserInput.calling()
