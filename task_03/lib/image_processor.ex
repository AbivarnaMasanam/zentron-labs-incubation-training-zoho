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

defmodule ImageProcessor do
  alias Vix.Vips.{Image, Operation}

  def list_function do
    IO.puts("\nSelect Option to Process the Image")
    IO.puts("1. Rotate Image")
    IO.puts("2. Invert Color of the Image")
    IO.puts("3. Convert to JPG with Quality")
    IO.puts("0. Exit")
  end

  def image_process(images) do
    list_function()

    process_input =
      ImageCli.userinput()
      |> String.trim()

    case Integer.parse(process_input) do
      {1, ""} ->
        rotate_images(images)

      {2, ""} ->
        invert_images(images)

      {3, ""} ->
        convert_images(images)

      {0, ""} ->
        IO.puts("Exiting Program...\nExited.")

      _ ->
        IO.puts(
          "Invalid Input! Try again. To exit enter 0.\n-------------------------------------------------"
        )

        image_process(images)
    end
  end

  def rotate_images(images) do
    IO.puts("\nImages received for rotation:")

    case Integer.parse(option_input()) do
      {1, ""} ->
        Enum.each(images, fn image ->
          degree_input =
            ImageCli.userinput(
              "Enter the Rotate Degree (90, 180, 270, 360) or Enter \"0\" to Skip : "
            )

          {:ok, image_data} = Image.new_from_file(image)

          case Integer.parse(degree_input) do
            {degree, ""} when degree in [90, 180, 270, 360] ->
              {:ok, rotated} = Operation.rotate(image_data, degree)
              img_name = Path.rootname(image)
              :ok = Image.write_to_file(rotated, "rotated_#{img_name}.jpg")

              IO.puts("Image rotated successfully!")

            {0, ""} ->
              IO.puts("Skiped...!")
          end
        end)

      {2, ""} ->
        degree_input =
          ImageCli.userinput("Enter the Rotate Degree (90, 180, 270, 360) or Enter 0 to Skip : ")

        case Integer.parse(degree_input) do
          {degree, ""} when degree in [90, 180, 270, 360] ->
            Enum.each(images, fn image ->
              {:ok, image_data} = Image.new_from_file(image)

              {:ok, rotated} = Operation.rotate(image_data, degree)
              img_name = Path.rootname(image)
              :ok = Image.write_to_file(rotated, "rotated_#{img_name}.jpg")

              IO.puts("Image rotated successfully!")
            end)

          {0, ""} ->
            IO.puts("Skiped...!")
        end

      {0, ""} ->
        IO.puts("Exiting...\n Done")

      _ ->
        IO.puts("Invalid Input... Try angain!")
        rotate_images(images)
    end
  end

  def invert_images(images) do
    IO.puts("\nImages received for inversion:")

    case Integer.parse(option_input()) do
      {1, ""} ->
        Enum.each(images, fn image ->
          processInput =
            ImageCli.userinput("""
            Enter \"Y\" to Continue \"N\" to Skip:
            File Name: \"#{Path.basename(image)}\"}
            """)
            |> String.upcase()

          case processInput do
            "Y" ->
              {:ok, image_data} = Image.new_from_file(image)

              {:ok, invert} = Operation.invert(image_data)
              img_name = Path.rootname(image)
              :ok = Image.write_to_file(invert, "inverted_#{img_name}.jpg")

              IO.puts("Image Inverted successfully!")

            "N" ->
              IO.puts("Image Skiped...")
          end
        end)

      {2, ""} ->
        Enum.each(images, fn image ->
          {:ok, image_data} = Image.new_from_file(image)

          {:ok, invert} = Operation.invert(image_data)
          img_name = Path.rootname(image)
          :ok = Image.write_to_file(invert, "inverted_#{img_name}.jpg")

          IO.puts("Image Inverted successfully!")
        end)

      {0, ""} ->
        IO.puts("Exiting...\n Done")
    end
  end

  def convert_images(images) do
    IO.puts("Images received for conversion:")

    case Integer.parse(option_input()) do
      {1, ""} ->
        Enum.each(images, fn image ->
          {:ok, image_data} = Image.new_from_file(input)

          degree_input =
            ImageCli.userinput("Enter the Compress Quality 0 to 100: ")
            |> String.to_integer()

          :ok = Image.write_to_file(image_data, "quality_#{degree_input}.jpg", Q: degree_input)

          IO.puts("JPEG files created!")
        end)

      {2, ""} ->
        degree_input =
          ImageCli.userinput("Enter the Compress Quality 0 to 100: ")
          |> String.to_integer()

        Enum.each(images, fn image ->
          {:ok, image_data} = Image.new_from_file(image)
          img_name = Path.rootname(image)

          :ok =
            Image.write_to_file(image_data, "#{img_name}_#{degree_input}.jpg", Q: degree_input)

          IO.puts("JPEG files created!")
        end)
    end
  end

  def option_input do
    ImageCli.userinput("""

    Select the Process Option
    1.One by One
    2.Apply to all
    0.Exit
    """)
  end
end
