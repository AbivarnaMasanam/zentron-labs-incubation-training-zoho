# defmodule ImageTest do
#   alias Vix.Vips.{Image, Operation}

#   {:ok, image} = Image.new_from_file("input.jpg")

#   {:ok, rotated} = Operation.rotate(image, 90)

#   :ok = Image.write_to_file(rotated, "rotated.jpg")

#   IO.puts("Image rotated successfully!")
# end

# defmodule ImageTest do
#   alias Vix.Vips.{Image, Operation}

#   {:ok, image} = Image.new_from_file("input.jpg")

#   {:ok, inverted} = Operation.invert(image)

#   :ok = Image.write_to_file(inverted, "inverted.jpg")

#   IO.puts("Image colours inverted successfully!")
# end

defmodule ImageTest do
  alias Vix.Vips.Image

  {:ok, image} = Image.new_from_file("input.jpg")

  :ok = Image.write_to_file(image, "quality_90.jpg", Q: 90)
  :ok = Image.write_to_file(image, "quality_50.jpg", Q: 50)
  :ok = Image.write_to_file(image, "quality_20.jpg", Q: 20)

  IO.puts("JPEG files created!")
end
