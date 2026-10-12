# defmodule ImageCli do
#   def run do
#     IO.puts("------ Image Manipulation CLI ------\n")

#     input = userinput("Enter the Image Source:\n")

#     case FileHandler.is_present(input) do
#       true ->
#         ImageProcessor.image_process(input)

#       false ->
#         IO.puts("File or folder not found!")
#     end
#   end

#   def userinput(output \\ "") do
#     IO.gets(output)
#     |> String.trim()
#   end
# end

defmodule ImageCli do
  def run do
    IO.puts("------ Image Manipulation CLI ------\n")

    input = userinput("Enter the \"Image/File or Folder Path\" (OR) Enter \"0\" to Exit:\n")

    case FileHandler.source_type(input) do
      :file ->
        IO.puts("Single file detected.")
        ImageProcessor.image_process([input])

      :folder ->
        IO.puts("Folder detected.")
        images = FileHandler.find_images(input)

        if Enum.empty?(images) do
          IO.puts("No images found in the folder!")
        else
          IO.puts("Total images found: #{Enum.count(images)}")
          ImageProcessor.image_process(images)
        end

      :not_found ->
        IO.puts("File or folder not found!")
        run()

      :exit ->
        IO.puts("Exited...")
    end
  end

  def userinput(output \\ "") do
    IO.gets(output)
    |> String.trim()
  end
end
