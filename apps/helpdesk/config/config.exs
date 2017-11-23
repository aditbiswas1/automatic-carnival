use Mix.Config

config :helpdesk, ecto_repos: [Helpdesk.Repo]

import_config "#{Mix.env}.exs"
