defmodule MotoSol.Devices.Device do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "devices" do
    field :radio_id, :integer
    field :alias, :string
    field :allowed_locations, {:array, :string}
    field :location, :string, default: "undefined"

    timestamps()
  end

  @doc false
  def changeset(device, attrs) do
    device
    |> cast(attrs, [:radio_id, :alias, :allowed_locations, :location])
    |> validate_required([:radio_id, :alias, :allowed_locations])
    |> check_location_in_allowed()
    |> unique_constraint(
      :devices,
      name: :radio_id,
      message: "Radio_id: #{attrs["radio_id"]} is taken!"
    )
  end

  defp check_location_in_allowed(changeset) do
    allowed_locations = get_field(changeset, :allowed_locations)
    location = get_field(changeset, :location)

    if location in allowed_locations or location == "undefined" do
      changeset
    else
      changeset
      |> add_error(:device, "#{location} is not in allowed_locations!")
    end
  end

  def has_location(query) do
    from(d in query,
      where: d.location != "undefined" or nil
    )
  end
end
