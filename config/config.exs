# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :team_budget,
  ecto_repos: [TeamBudget.Repo],
  generators: [binary_id: true]

# Auth
config :team_budget, TeamBudgetWeb.Auth.Guardian,
  issuer: "team_budget",
  secret_key: System.get_env("SECRET_KEY_GUARDIAN")

# Mailer Bamboo.SMTPAdapter
config :team_budget, TeamBudget.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: System.get_env("SMTP_HOST"),
  hostname: System.get_env("SMTP_HOST"),
  port: System.get_env("SMTP_PORT"),
  username: System.get_env("SMTP_USERNAME"),
  password: System.get_env("SMTP_PASSWORD"),
  tls: :if_available,
  allowed_tls_versions: [:tlsv1, :"tlsv1.1", :"tlsv1.2"],
  tls_log_level: :error,
  tls_verify: :verify_peer,
  tls_cacertfile: "/somewhere/on/disk",
  tls_cacerts: "…",
  tls_depth: 3,
  tls_verify_fun: {&:ssl_verify_hostname.verify_fun/3, check_hostname: "example.com"},
  ssl: false,
  retries: 1,
  no_mx_lookups: false,
  auth: :cram_md5

# Configures the endpoint
config :team_budget, TeamBudgetWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: TeamBudgetWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: TeamBudget.PubSub,
  live_view: [signing_salt: "w4q8mbh8"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
# config :team_budget, TeamBudget.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
# config :swoosh, :api_client, false

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
