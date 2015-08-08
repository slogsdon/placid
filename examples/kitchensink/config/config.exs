# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :logger, :console,
  level: :info,
  format: "$date $time [$level] $metadata$message\n",
  metadata: [:user_id]

# Placid doesn't make any assumptions regarding naming
# conventions, so we need to tell it which module is our
# router.
config :placid, router: KitchenSink.Router

config :placid, KitchenSink.Router,
  # Should this application only send proper responses
  # to HTTPS requests? Defaults to `true`.
  https_only: false,
  # General HTTP settings to pass to our Plug adapter.
  # Include HTTP options (at least a port number) even
  # if you're planning on forcing the use of HTTPS. Placid
  # will respond to all HTTP responses with `403 Forbidden`.
  http: [ port: 4000 ],
  # General HTTPS settings to pass to our Plug adapter.
  https: [ certfile: Path.expand("ssl/cert.pem", __DIR__),
           keyfile:  Path.expand("ssl/key.pem", __DIR__),
           port: 4443 ]
