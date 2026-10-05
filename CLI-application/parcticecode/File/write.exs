# #To write a file use the "File.write(path,content)" path is the file location and content is the data
# # of the file.

# # IO.puts(File.write("hello.txt", "the file is writen using the Elixir Programming language..."))

# # To show or know how many or what are the file avaliable in the path use the File.ls(path). give the path
# # the file will show. "." mean the current directory... its return the success msg and the list of file as
# # tagged tuple.

# # IO.puts(File.ls("."))

# # using the case we only fetch the list of the file without the success msg, it is a another way
# case File.ls(".") do
#   {:ok, files} ->
#     IO.inspect(files)

#   {:error, reason} ->
#     IO.inspect(reason)
# end
