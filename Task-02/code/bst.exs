# Binary Search Tree in Elixir
# Run with: elixir bst.exs

defmodule BST do
  @moduledoc """
  A simple Binary Search Tree implementation.
  Each node is stored as {value, left, right} or nil for empty.
  """

  @doc "Insert a value into the BST."
  def insert(nil, value), do: {value, nil, nil}
  def insert({value, left, right}, value), do: {value, left, right}  # duplicate, ignore
  def insert({node_val, left, right}, value) when value < node_val do
    {node_val, insert(left, value), right}
  end
  def insert({node_val, left, right}, value) when value > node_val do
    {node_val, left, insert(right, value)}
  end

  @doc "Search for a value in the BST. Returns true if found, false otherwise."
  def search(nil, _value), do: false
  def search({value, _left, _right}, value), do: true
  def search({node_val, left, _right}, value) when value < node_val do
    search(left, value)
  end
  def search({node_val, _left, right}, value) when value > node_val do
    search(right, value)
  end

  @doc "In-order traversal returning a sorted list."
  def inorder(nil), do: []
  def inorder({value, left, right}) do
    inorder(left) ++ [value] ++ inorder(right)
  end
end

defmodule BSTApp do
  @moduledoc """
  Interactive CLI: reads 5 numbers, builds a BST, then lets the user search.
  """

  @numbers_to_read 5

  def main do
    IO.puts("========================================")
    IO.puts("   Binary Search Tree - Elixir")
    IO.puts("========================================\n")

    # --- Step 1: Read 5 numbers ---
    numbers = read_numbers(@numbers_to_read, [])

    # --- Step 2: Build the BST ---
    tree = Enum.reduce(numbers, nil, &BST.insert(&2, &1))

    IO.puts("\n--- BST built successfully! ---")
    IO.puts("Numbers inserted (in-order): #{inspect(BST.inorder(tree))}\n")

    # --- Step 3: Search loop ---
    search_loop(tree)
  end

  # Recursively read N integers from the user
  defp read_numbers(0, acc), do: Enum.reverse(acc)
  defp read_numbers(n, acc) do
    prompt = "Enter number #{@numbers_to_read - n + 1} of #{@numbers_to_read}: "
    input = IO.gets(prompt) |> String.trim()

    case Integer.parse(input) do
      {value, ""} ->
        read_numbers(n - 1, [value | acc])

      _ ->
        IO.puts("  Invalid input. Please enter a valid integer.")
        read_numbers(n, acc)
    end
  end

  # Search loop — keeps asking until user types 'quit'
  defp search_loop(tree) do
    input = IO.gets("\nEnter a number to search (or 'quit' to exit): ") |> String.trim()

    case String.downcase(input) do
      "quit" ->
        IO.puts("\nGoodbye!")

      "" ->
        IO.puts("  Please enter a number or 'quit'.")
        search_loop(tree)

      input ->
        case Integer.parse(input) do
          {value, ""} ->
            result = BST.search(tree, value)
            if result do
              IO.puts("  #{value} was FOUND in the tree.")
            else
              IO.puts("  #{value} was NOT found in the tree.")
            end
            search_loop(tree)

          _ ->
            IO.puts("  Invalid input. Please enter a valid integer or 'quit'.")
            search_loop(tree)
        end
    end
  end
end

# --- Entry point ---
BSTApp.main()
