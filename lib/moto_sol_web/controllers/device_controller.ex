defmodule MotoSolWeb.DeviceController do
  use MotoSolWeb, :controller

  alias MotoSolWeb.DeviceView
  alias MotoSol.Devices
  alias MotoSol.Devices.Device

  action_fallback MotoSolWeb.FallbackController

  def create(conn, %{"radio_id" => radio_id}) do
    with {:ok, %Device{} = device} <- Devices.create_device(conn.params) do
      conn
      |> put_status(200)
      |> put_view(DeviceView)
      |> render("show.json", device: device)
    end
  end

  def get_location(conn, %{"radio_id" => radio_id}) do
    with(device = %Device{} <- Devices.get_device_by_radio_id_with_location(radio_id)) do
      conn
      |> put_status(200)
      |> put_view(DeviceView)
      |> render("show_location.json", device: device)
    end
  end

  def set_location(conn, %{"radio_id" => radio_id, "location" => location}) do
    with(
      device = %Device{} <- Devices.get_device_by_radio_id(radio_id),
      {:ok, %Device{} = device} <- Devices.update_device(device, %{location: location})
    ) do
      conn
      |> put_status(200)
      |> put_view(DeviceView)
      |> render("show.json", device: device)
    else
      {:error, changeset} ->
        conn
        |> put_status(403)
        |> put_view(DeviceView)
        |> render("403.json", changeset: changeset)

      error ->
        error
    end
  end
end
