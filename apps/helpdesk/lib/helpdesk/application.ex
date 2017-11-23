defmodule Helpdesk.Application do
  @moduledoc """
  The Helpdesk Application Service.

  The helpdesk system business domain lives in this application.

  Exposes API to clients such as the `HelpdeskWeb` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      supervisor(Helpdesk.Repo, []),
    ], strategy: :one_for_one, name: Helpdesk.Supervisor)
  end
end
