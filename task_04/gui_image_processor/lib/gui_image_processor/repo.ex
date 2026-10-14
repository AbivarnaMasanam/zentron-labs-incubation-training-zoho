defmodule GuiImageProcessor.Repo do
  use Ecto.Repo,
    otp_app: :gui_image_processor,
    adapter: Ecto.Adapters.Postgres
end
