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
    IO.puts("""
    +-------------------------------------------------------------------+
    |                                                                   |
    |               ------ Image Manipulation CLI ------                |
    |                              WELCOME!                             |
    |                                                                   |
    +-------------------------------------------------------------------+
    """)

    input = userinput("Enter the \"Image/File or Folder Path\" (OR) Enter \"0\" to Exit:\n")

    case FileHandler.source_type(input) do
      :file ->
        IO.puts("Single file detected.")
        ImageProcessor.run([input], false)

      :folder ->
        IO.puts("\nFolder detected.")
        images = FileHandler.find_images(input)

        if Enum.empty?(images) do
          IO.puts("No images found in the folder!\n")
          run()
        else
          IO.puts("Total images found: #{Enum.count(images)}")
          ImageProcessor.run(images, true)
        end

      :not_found ->
        IO.puts("File or folder not found!")
        run()

      :exit ->
        ImageProcessor.exit_output()
    end
  end

  def closing_function do
    endInput =
      userinput("\nWould you like to Continue(\"1\") or Exit(\"0\"). Press Any Key:")
      |> Integer.parse()

    if endInput == {1, ""},
      do: ImageCli.run(),
      else: ImageProcessor.exit_output()
  end

  def userinput(output \\ "") do
    IO.gets(output)
    |> String.trim()
  end
end
