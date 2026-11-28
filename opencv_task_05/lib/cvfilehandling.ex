defmodule CvFileHandling do
  @support_image [".jpg", ".jpeg", ".png", ".bmp", ".tiff", ".tif", ".gif"]

  def isfolder?(path) do
    File.dir?(path)
  end

  def find_images_in_folder(path) do
    case File.ls(path) do
      {:ok, files} ->
        image_files =
          Enum.filter(files, fn file ->
            ext = Path.extname(file) |> String.downcase()
            ext in @support_image
          end)

        if image_files == [] do
          IO.puts("No image files found in the folder.")
        else
          IO.puts("Found image files: #{Enum.count(image_files)}")
          # IO.inspect(image_files, label: "Image files")
          image_files
        end

      {:error, reason} ->
        IO.puts("Error reading folder: #{reason}")
    end
  end
end
