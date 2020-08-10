defmodule Reproduce.Repo do
  use Ecto.Repo,
    otp_app: :reproduce,
    adapter: Ecto.Adapters.Postgres
end
