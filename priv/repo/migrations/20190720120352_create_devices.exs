defmodule MotoSol.Repo.Migrations.CreateDevices do
  use Ecto.Migration

  def change do
    create table(:devices) do
      add(:radio_id, :integer)
      add(:alias, :string)
      add(:allowed_locations, {:array, :string})
      add(:location, :string)

      timestamps()
    end

    create(unique_index(:devices, [:radio_id], name: "radio_id"))
  end
end
