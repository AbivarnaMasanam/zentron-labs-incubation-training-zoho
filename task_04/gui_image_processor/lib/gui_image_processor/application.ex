defmodule GuiImageProcessor.Application do
  # See https://elixir.hexdocs.pm/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      GuiImageProcessorWeb.Telemetry,
      GuiImageProcessor.Repo,
      {DNSCluster, query: Application.get_env(:gui_image_processor, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: GuiImageProcessor.PubSub},
      # Start a worker by calling: GuiImageProcessor.Worker.start_link(arg)
      # {GuiImageProcessor.Worker, arg},
      # Start to serve requests, typically the last entry
      GuiImageProcessorWeb.Endpoint
    ]

    # See https://elixir.hexdocs.pm/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GuiImageProcessor.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GuiImageProcessorWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
