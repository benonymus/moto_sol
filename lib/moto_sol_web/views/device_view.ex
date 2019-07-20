defmodule MotoSolWeb.DeviceView do
  use MotoSolWeb, :view
  alias MotoSolWeb.DeviceView

  def render("403.json", %{changeset: changeset}) do
    message =
      Ecto.Changeset.traverse_errors(changeset, fn
        {msg, opts} -> msg
      end)

    %{
      errors: message
    }
  end

  def render("show.json", %{device: device}) do
    %{
      device: render_one(device, DeviceView, "device.json")
    }
  end

  def render("show_location.json", %{device: device}) do
    %{
      location: device.location
    }
  end

  def render("device.json", %{device: device}) do
    %{
      radio_id: device.radio_id,
      alias: device.alias,
      allowed_locations: device.allowed_locations,
      location: device.location
    }
  end
end
