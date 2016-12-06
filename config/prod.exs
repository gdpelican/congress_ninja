use Mix.Config

config :congress_ninja, CongressNinja.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [host: "congress.ninja", port: 80],
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  cache_static_manifest: "priv/static/manifest.json",
  secret_key_base: System.get_env("SECRET_KEY_BASE")

# Do not print debug messages in production
config :logger, level: :info

# Configure your database
config :congress_ninja, CongressNinja.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "20"),
  ssl: true

config :congress_ninja, CongressNinja.GeocodioService,
  geocodio_api_key: System.get_env("GEOCODIO_API_KEY")
