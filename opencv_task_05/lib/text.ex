defmodule OpenCVBasics do
  alias Evision, as: Cv

  @doc """
  1. Image Read
  Loads an image from disk into an Evision.Mat struct.
  Flags: :IMREAD_COLOR (default), :IMREAD_GRAYSCALE, :IMREAD_UNCHANGED
  """
  def read_image(path, flag \\ Cv.Constant.cv_IMREAD_COLOR()) do
    case Cv.imread(path, flags: flag) do
      %Cv.Mat{} = mat -> {:ok, mat}
      {:error, reason} -> {:error, reason}
    end
  end

  @doc """
  2. Image Show
  Opens a native GUI window to display the image and waits for a keypress.
  Note: Requires a desktop environment (won't work on headless servers).
  """
  def show_image(window_name, %Cv.Mat{} = mat) do
    Cv.imshow(window_name, mat)
    # 0 means wait indefinitely until a key is pressed
    Cv.waitKey(0)
    Cv.destroyWindow(window_name)
  end

  @doc """
  3. Image Write
  Saves an Evision.Mat matrix to a file (format inferred from extension, e.g., .jpg, .png).
  """
  def write_image(output_path, %Cv.Mat{} = mat) do
    Cv.imwrite(output_path, mat)
  end

  @doc """
  4. Image Flip
  Flips the matrix around axes:
    0  -> Vertical flip (around X-axis)
    1  -> Horizontal flip (around Y-axis / mirror)
   -1  -> Both vertical and horizontal
  """
  def flip_image(%Cv.Mat{} = mat, flip_code \\ 1) do
    Cv.flip(mat, flip_code)
  end

  @doc """
  5. Image Resize
  Scales the image to {width, height} using interpolation.
  INTER_AREA is best for shrinking; INTER_LINEAR or INTER_CUBIC for enlarging.
  """
  def resize_image(%Cv.Mat{} = mat, width, height) do
    Cv.resize(mat, {width, height}, interpolation: Cv.Constant.cv_INTER_LINEAR())
  end

  @doc """
  6. Image Colour Conversion
  Converts color spaces (e.g., BGR to Grayscale, RGB, or HSV).
  """
  def convert_color(%Cv.Mat{} = mat, target_space) do
    code =
      case target_space do
        :gray -> Cv.Constant.cv_COLOR_BGR2GRAY()
        :rgb  -> Cv.Constant.cv_COLOR_BGR2RGB()
        :hsv  -> Cv.Constant.cv_COLOR_BGR2HSV()
      end

    Cv.cvtColor(mat, code)
  end
end
