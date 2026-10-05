# if the file is Exited are not....
IO.puts(File.exists?("hello.txt"))
[filename] = System.argv()

# if Yes, Read the file, its return the {:ok, content} or {:error,ennot}
# :ok or :error is the Respond message of the operation, content the file data or ennot error message.
if File.exists?(filename) do
  case File.read(filename) do
    {:ok, content} when content == "" ->
      IO.puts("File is Empty")

    {:ok, content} ->
      IO.puts(content)

    _ ->
      IO.puts("file is Empty")
  end
else
  IO.puts("File Not Found 404!")
end

# read using the ! only return the Content or error.
IO.puts(File.read!("hello.txt"))
IO.inspect(File.read!("hello.txt"))
