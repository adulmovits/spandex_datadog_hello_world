defmodule Hello.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec


# Example configuration
datadog_opts =
  [
    host: System.get_env("DATADOG_HOST") || "localhost",
    port: System.get_env("DATADOG_PORT") || 8126,
    batch_size: System.get_env("SPANDEX_BATCH_SIZE") || 1,
    sync_threshold: System.get_env("SPANDEX_SYNC_THRESHOLD") || 10,
    http: HTTPoison,
    verbose?: true
  ]





    # Define workers and child supervisors to be supervised
    children = [
      worker(SpandexDatadog.ApiServer, [datadog_opts]), 
      # Start the Ecto repository
      supervisor(Hello.Repo, []),
      # Start the endpoint when the application starts
      supervisor(HelloWeb.Endpoint, []),
      # Start your own worker by calling: Hello.Worker.start_link(arg1, arg2, arg3)
      # worker(Hello.Worker, [arg1, arg2, arg3]),
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Hello.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    HelloWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
