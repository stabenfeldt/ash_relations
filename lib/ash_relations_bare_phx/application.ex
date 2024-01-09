defmodule AshRelationsBarePhx.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    if Application.get_env(:testcontainers, :enabled, false) do
      {:ok, _container} =
        case Application.get_env(:testcontainers, :database) do
          nil ->
            Testcontainers.Ecto.postgres_container(app: :ash_relations_bare_phx)

          database ->
            Testcontainers.Ecto.postgres_container(
              app: :ash_relations_bare_phx,
              persistent_volume_name: "#{database}_data"
            )
        end
    end

    children = [
      AshRelationsBarePhxWeb.Telemetry,
      AshRelationsBarePhx.Repo,
      {DNSCluster, query: Application.get_env(:ash_relations_bare_phx, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: AshRelationsBarePhx.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: AshRelationsBarePhx.Finch},
      # Start a worker by calling: AshRelationsBarePhx.Worker.start_link(arg)
      # {AshRelationsBarePhx.Worker, arg},
      # Start to serve requests, typically the last entry
      AshRelationsBarePhxWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AshRelationsBarePhx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AshRelationsBarePhxWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
