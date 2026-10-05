[filename] = System.argv()

case File.read(filename) do
  {:ok, ""} ->
    IO.puts("File read successfully!")
    IO.puts("File is Empty!")

  {:ok, content} ->
    IO.puts("File read successfully!")

    IO.puts("Content: " <> content)

  _ ->
    IO.puts("Error!")
end
