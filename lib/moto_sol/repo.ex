defmodule MotoSol.Repo do
  use Ecto.Repo,
    otp_app: :moto_sol,
    adapter: Ecto.Adapters.Postgres
end
