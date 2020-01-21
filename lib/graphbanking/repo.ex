defmodule Graphbanking.Repo do
  use Ecto.Repo,
    otp_app: :graphbanking,
    adapter: Ecto.Adapters.Postgres
end
