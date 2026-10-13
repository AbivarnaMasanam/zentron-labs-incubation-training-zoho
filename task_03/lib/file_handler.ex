# defmodule FileHandler do
#   def is_present(source) do
#    if File.exists?(source) do
#    if File.dir?(source) do
#     {:ok, list}=File.ls(source)
#    end
#    else

#   end
# end
# end

defmodule FileHandler do
  def source_type(source) do
    cond do
      File.dir?(source) ->
        :folder

      File.exists?(source) ->
        :file

      source == "0" ->
        :exit

      true ->
        :not_found
    end
  end

  def find_images(folder_path) do
    image_extensions = [".jpg", ".jpeg", ".png", ".webp"]

    case File.ls(folder_path) do
      {:ok, files} ->
        Enum.filter(files, fn file ->
          (Path.extname(file) |> String.downcase()) in image_extensions
        end)
        |> Enum.map(fn file ->
          Path.join(folder_path, file)
        end)

      {:error, reason} ->
        IO.puts("Unable to read folder: #{reason}")
        []
    end
  end
end
