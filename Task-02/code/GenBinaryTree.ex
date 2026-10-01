defmodule SearchTree do
  defstruct value: nil, left: nil, right: nil

  # --------------------
  # INSERT
  # --------------------

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

  # --------------------
  # SEARCH
  # --------------------

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

  # --------------------
  # INPUT
  # --------------------

  def input(prompt) do
    inputvalue =
      IO.gets(prompt)
      |> String.trim()

    case Integer.parse(inputvalue) do
      {number, ""} ->
        number

      _ ->
        IO.puts("Invalid Input! Please enter a number.")
        input(prompt)
    end
  end

  # --------------------
  # GET VALUES
  # --------------------

  def get_input_values(count) do
    Enum.map(1..count, fn i ->
      input("Enter number #{i}: ")
    end)
  end

  # --------------------
  # BUILD TREE
  # --------------------

  def build_tree(values) do
    Enum.reduce(values, nil, fn value, tree ->
      insert(tree, value)
    end)
  end

  # --------------------
  # MAIN
  # --------------------

  def start do
    count = input("Enter how many numbers you want: ")

    values = get_input_values(count)

    tree = build_tree(values)

    target = input("Enter the target value: ")

    case search(tree, target) do
      true ->
        IO.puts("#{target} is present in the tree.")

      false ->
        IO.puts("#{target} is not present in the tree.")
    end
  end
end

SearchTree.start()
