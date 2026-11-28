defmodule Opencv do
  def run(image_data \\ []) do
    input =
      Integer.parse(
        IO.gets("""
        Select the Operations:
        1. Image read
        2. Image Show
        3. Image write
        4. Image flip
        5. Image resize
        6. Image colour
        0. Exit

        Enter the number of the operation you want to perform:
        """)
      )

    case input do
      {1, _} ->
        case OpenCVImpl.read_image() do
          {:ok, images} ->
            IO.inspect(images, label: "Loaded images")
            run(images)

          {:error, reason} ->
            IO.puts("Failed to read image: #{inspect(reason)}")
            run(image_data)
        end

      {2, _} ->
        if image_data == [] do
          IO.puts("No image loaded. Please select option 1 first.")
        else
          Enum.each(image_data, fn %{file_name: name, image_data: mat} ->
            OpenCVImpl.show_image(name, mat)
          end)
        end

      # run(image_data)

      {0, _} ->
        IO.puts("Exiting the program.")
        :ok

      _ ->
        IO.puts("Invalid option.")
        run(image_data)
    end
  end
end
