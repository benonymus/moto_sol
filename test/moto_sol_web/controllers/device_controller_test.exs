defmodule MotoSolWeb.DeviceControllerTest do
  use MotoSolWeb.ConnCase

  alias MotoSol.Devices

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  @update_attrs %{
    allowed_locations: ["cph-1", "cph-2"],
    location: "cph-2",
    alias: "some updated radio_alias",
    radio_id: 43
  }

  def device_fixture(attrs \\ %{}) do
    {:ok, device} =
      attrs
      |> Enum.into(@update_attrs)
      |> Devices.create_device()

    device
  end

  describe "create device" do
    test "successful device creation", %{conn: conn} do
      radio_id = 102

      device = %{
        "alias" => "Radio102",
        "allowed_locations" => ["CPH-1", "CPH-3"]
      }

      conn =
        conn
        |> post("/radios/#{radio_id}", device)

      device_resp = json_response(conn, 200)["device"]
      assert device_resp["radio_id"] == radio_id
      assert device_resp["alias"] == device["alias"]
      assert device_resp["allowed_locations"] == device["allowed_locations"]
    end
  end

  describe "get device location" do
    test "successful get device location", %{conn: conn} do
      device = device_fixture()

      conn =
        conn
        |> get("/radios/#{device.radio_id}/location")

      location = json_response(conn, 200)["location"]
      assert location == device.location
    end
  end

  describe "set device location" do
    test "successful get device location", %{conn: conn} do
      device = device_fixture()

      location = %{
        "location" => "cph-1"
      }

      conn =
        conn
        |> post("/radios/#{device.radio_id}/location", location)

      device_resp = json_response(conn, 200)["device"]

      assert device_resp["radio_id"] == device.radio_id
      assert device_resp["alias"] == device.alias
      assert device_resp["allowed_locations"] == device.allowed_locations
      assert device_resp["location"] != device.location
      assert device_resp["location"] == location["location"]
    end
  end
end
