[filename] = System.argv()

IO.puts("File: " <> filename)

if File.exists?(filename) do
  IO.puts("Exists: True")
  IO.puts("Extension :" <> Path.extname(filename))
else
  IO.puts("Exists: False")
end
