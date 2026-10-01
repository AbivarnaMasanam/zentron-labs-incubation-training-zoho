defmodule SearchTree do
  defstruct value: nil, left: nil, right: nil

  def insert(nil, value) do
    %SearchTree{value: value}
  end

  def insert(%SearchTree{value: root, left: left, right: right}, value) do
    if value < root do
      %SearchTree{
        value: root,
        left: insert(left, value),
        right: right
      }
    else
      %SearchTree{
        value: root,
        left: left,
        right: insert(right, value)
      }
    end
  end

  def search(nil, _value) do
    false
  end

  def search(%SearchTree{value: root, left: left, right: right}, value) do
    cond do
      value == root ->
        true

      value < root ->
        search(left, value)

      true ->
        search(right, value)
    end
  end

  def input(promt) do
    inputvalue =
      IO.gets(promt)
      |> String.trim()

    case Integer.parse(inputvalue) do
      {number, ""} ->
        number

      _ ->
        IO.puts("Invalid Input")
    end

    inputvalue
  end
end

SearchTree.input("Enter the how many number you want")
