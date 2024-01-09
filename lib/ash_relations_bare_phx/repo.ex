defmodule AshRelationsBarePhx.Repo do
  use AshPostgres.Repo,
    otp_app: :ash_relations_bare_phx

  def installed_extensions do
    ["uuid-ossp", "citext"]
  end
end
