[filename] = System.argv()
IO.puts(File.exists?(filename))

if File.exists?(filename) do
  IO.puts("File Exited!")
else
  IO.puts("File does not exist!")
end
