defmodule OpenCVImpl do
  alias Evision, as: Cv

  def read_image() do
    path = IO.gets("Enter the image path: ") |> String.trim()

    if CvFileHandling.isfolder?(path) do
      IO.puts("The provided path is a folder. Finding images!.")

      case CvFileHandling.find_images_in_folder(path) do
        image_files when is_list(image_files) ->
          image_read_data =
            Enum.map(image_files, fn file ->
              full_path = Path.join(path, file)
              mat_data = read_imageImpl(full_path)
              %{file_name: file, image_data: mat_data}
            end)

          {:ok, image_read_data}

        _ ->
          {:error, :no_images_found}
      end
    else
      case read_imageImpl(path) do
        %Cv.Mat{} = mat ->
          IO.puts("Image read successfully: #{Path.basename(path) |> String.downcase()}")
          # Wrapping in a list keeps the return format identical for single files and folders
          {:ok, [%{file_name: Path.basename(path), image_data: mat}]}

        {:error, reason} ->
          {:error, reason}
      end
    end
  end

  defp read_imageImpl(path, flag \\ Cv.Constant.cv_IMREAD_COLOR()) do
    case Cv.imread(path, flags: flag) do
      %Cv.Mat{} = mat -> mat
      {:error, reason} -> {:error, reason}
    end
  end

  def show_image(_window_name, %Cv.Mat{} = mat) do
    preview_path = "lib/output_preview.jpg"
    Cv.imwrite(preview_path, mat)
    System.cmd("xdg-open", [preview_path])
  end

  # ... keep write_image, flip_image, resize_image, convert_color as they are
end
