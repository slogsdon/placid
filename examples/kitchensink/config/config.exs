# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :placid, router: KitchenSink.Router

config :placid, KitchenSink.Router,
  http: [ port: 4000 ],
  https: [ certfile: Path.expand("ssl/cert.pem", __DIR__),
           keyfile:  Path.expand("ssl/key.pem", __DIR__),
           port: 4443 ],
  https_only: false