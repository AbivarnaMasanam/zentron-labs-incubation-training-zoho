# alias Vix.Vips.{Image, Operation}

# defmodule ImageProcessor do
#   def list_function do
#     IO.puts("\nSelect Option to Process the Image")
#     IO.puts("1. Rotate Image")
#     IO.puts("2. Invert Color of the Image")
#     IO.puts("3. Convert to JPG with Quality")
#     IO.puts("0. Exit")
#   end

#   def image_process(input) do
#     list_function()

#     process_input =
#       ImageCli.userinput()

#     case Integer.parse(process_input) do
#       {1, ""} ->
#         rotate_image(input)

#       {2, ""} ->
#         invert_color(input)

#       {3, ""} ->
#         convert(input)

#       {0, ""} ->
#         IO.puts("Exiting Program...\nExited.")

#       _ ->
#         IO.puts("Invalid Input! Try again. To exit enter 0.\n-------------------------------------------------")
#         image_process(input)
#     end
#   end

#   def rotate_image(input) do

#     {:ok, image_data} = Image.new_from_file(input)

#     degree_input =
#       ImageCli.userinput("Enter the Rotate Degree (90, 180, 270, 360): ")

#     case Integer.parse(degree_input) do
#       {degree, ""} when degree in [90, 180, 270, 360] ->
#         {:ok, rotated} = Operation.rotate(image_data, degree)

#         :ok = Image.write_to_file(rotated, "rotated.jpg")

#         IO.puts("Image rotated successfully!")

#       _ ->
#         IO.puts("Invalid input! Please enter 90, 180, 270, or 360.")
#         rotate_image(input)
#     end
#   end

#   def invert_color(input) do
#    {:ok, image_data} = Image.new_from_file(input)

#    {:ok, invert}= Operation.invert(image_data)

#    :ok = Image.write_to_file(invert,"inverted.jpg")

#     IO.puts("Image Inverted successfully!")

#   end

#   def convert(input) do

#     {:ok, image_data} = Image.new_from_file(input)

#     degree_input =
#         ImageCli.userinput("Enter the Quality 0 to 100: ")
#         |> String.to_integer()

#       :ok = Image.write_to_file(image_data, "quality_#{degree_input}.jpg", Q: degree_input)

#     IO.puts("JPEG files created!")

#   end
# end
# ------------
#

defmodule ImageProcessor do
  alias Vix.Vips.{Image, Operation}

  @output_dir "output"

  def print_menu do
    IO.puts("\nSelect Option to Process the Image")
    IO.puts("1. Rotate Image")
    IO.puts("2. Invert Color of the Image")
    IO.puts("3. Convert to JPG with Quality")
    IO.puts("0. Exit")
  end

  def prompt_processing_mode do
    ImageCli.userinput("""

    Select the Process Option
    1. One by One
    2. Apply to all
    0. Exit
    """)
  end

  def run(images, isfolder) do
    print_menu()

    process_input =
      ImageCli.userinput()
      |> String.trim()

    case Integer.parse(process_input) do
      {1, ""} ->
        if isfolder, do: folder_rotation(images), else: perform_rotation([images])

      {2, ""} ->
        if isfolder, do: folder_inversion(images), else: perform_inversion(images)

      {3, ""} ->
        if isfolder, do: folder_conversion(images), else: perform_conversion(images)

      {0, ""} ->
        IO.puts("Exiting Program...\nExited.")

      _ ->
        IO.puts(
          "Invalid Input! Try again. To exit enter 0.\n-------------------------------------------------"
        )

        run(images, isfolder)
    end
  end

  def perform_rotation(images) do
    images = if is_list(images), do: images, else: [images]

    degree_input = ImageCli.userinput("Enter the Rotate Degree (1 to 360) or Enter 0 to Skip : ")

    case Integer.parse(degree_input) do
      {degree, ""} when degree > 0 and degree <= 360 ->
        File.mkdir_p!(@output_dir)

        Enum.each(images, fn image ->
          with {:ok, image_data} <- Image.new_from_file(image),
               {:ok, rotated} <- Operation.rotate(image_data, degree * 1.0) do
            image_name = Path.basename(image)
            output_path = Path.join(@output_dir, "rotated_#{image_name}")

            :ok = Image.write_to_file(rotated, output_path)
            IO.puts("#{image_name} rotated and saved to #{@output_dir}/!")
          else
            _ -> IO.puts("Failed to process #{image}")
          end
        end)

      {0, ""} ->
        IO.puts("Skipped...!")

      _ ->
        IO.puts("Invalid degree entered. Must be between 1 and 360. Skipping rotation.")
    end
  end

  def perform_inversion(images) do
    images = if is_list(images), do: images, else: [images]

    File.mkdir_p!(@output_dir)

    Enum.each(images, fn image ->
      with {:ok, image_data} <- Image.new_from_file(image),
           {:ok, invert} <- Operation.invert(image_data) do
        image_name = Path.basename(image)
        output_path = Path.join(@output_dir, "inverted_#{image_name}")

        :ok = Image.write_to_file(invert, output_path)
        IO.puts("#{image_name} inverted and saved to #{@output_dir}/!")
      else
        _ -> IO.puts("Failed to process #{image}")
      end
    end)
  end

  def perform_conversion(images) do
    images = if is_list(images), do: images, else: [images]

    quality_input =
      ImageCli.userinput("Enter the Compress Quality (0 to 100) or Enter 0 to Skip : ")

    case Integer.parse(quality_input) do
      {quality, ""} when quality >= 0 and quality <= 100 ->
        if quality == 0 do
          IO.puts("Skipped compression.")
        else
          File.mkdir_p!(@output_dir)

          Enum.each(images, fn image ->
            with {:ok, image_data} <- Image.new_from_file(image) do
              image_name = Path.basename(image)
              output_path = Path.join(@output_dir, "compressed_#{image_name}")

              :ok = Image.write_to_file(image_data, output_path, Q: quality)
              IO.puts("#{image_name} is compressed and saved to #{@output_dir}/!")
            else
              _ -> IO.puts("Failed to process #{image}")
            end
          end)
        end

      _ ->
        IO.puts("Invalid quality value entered. Skipping conversion.")
    end
  end

  def folder_rotation(images) do
    IO.puts("\nImages received for rotation:")

    case Integer.parse(prompt_processing_mode()) do
      {1, ""} ->
        Enum.each(images, fn image ->
          process_input =
            ImageCli.userinput("""
            Enter \"Y\" to Continue, \"N\" to Skip:
            File Name: \"#{Path.basename(image)}\"
            """)
            |> String.upcase()
            |> String.trim()

          if process_input == "Y", do: perform_rotation(image), else: IO.puts("Image skipped...")
        end)

      {2, ""} ->
        perform_rotation(images)

      {0, ""} ->
        IO.puts("Exiting...\nDone")

      _ ->
        IO.puts("Invalid Input... Try again!")
        folder_rotation(images)
    end
  end

  def folder_inversion(images) do
    IO.puts("\nImages received for inversion:")

    case Integer.parse(prompt_processing_mode()) do
      {1, ""} ->
        Enum.each(images, fn image ->
          process_input =
            ImageCli.userinput("""
            Enter \"Y\" to Continue, \"N\" to Skip:
            File Name: \"#{Path.basename(image)}\"
            """)
            |> String.upcase()
            |> String.trim()

          if process_input == "Y", do: perform_inversion(image), else: IO.puts("Image skipped...")
        end)

      {2, ""} ->
        perform_inversion(images)

      {0, ""} ->
        IO.puts("Exiting...\nDone")

      _ ->
        IO.puts("Invalid Input... Try again!")
        folder_inversion(images)
    end
  end

  def folder_conversion(images) do
    IO.puts("\nImages received for conversion:")

    case Integer.parse(prompt_processing_mode()) do
      {1, ""} ->
        Enum.each(images, fn image ->
          process_input =
            ImageCli.userinput("""
            Enter \"Y\" to Continue, \"N\" to Skip:
            File Name: \"#{Path.basename(image)}\"
            """)
            |> String.upcase()
            |> String.trim()

          if process_input == "Y",
            do: perform_conversion(image),
            else: IO.puts("Image skipped...")
        end)

      {2, ""} ->
        perform_conversion(images)

      {0, ""} ->
        IO.puts("Exiting...\nDone")

      _ ->
        IO.puts("Invalid Input... Try again!")
        folder_conversion(images)
    end
  end
end
