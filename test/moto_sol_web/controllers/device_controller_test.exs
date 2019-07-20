defmodule MotoSolWeb.DeviceControllerTest do
  use MotoSolWeb.ConnCase

  alias MotoSol.Devices
  alias MotoSol.Devices.Device

  @create_attrs %{
    allowed_locations: [],
    location: "some location",
    radio_alias: "some radio_alias",
    radio_id: 42
  }
  @update_attrs %{
    allowed_locations: [],
    location: "some updated location",
    radio_alias: "some updated radio_alias",
    radio_id: 43
  }
  @invalid_attrs %{allowed_locations: nil, location: nil, radio_alias: nil, radio_id: nil}

  def fixture(:device) do
    {:ok, device} = Devices.create_device(@create_attrs)
    device
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all devices", %{conn: conn} do
      conn = get(conn, Routes.device_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create device" do
    test "renders device when data is valid", %{conn: conn} do
      conn = post(conn, Routes.device_path(conn, :create), device: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.device_path(conn, :show, id))

      assert %{
               "id" => id,
               "allowed_locations" => [],
               "location" => "some location",
               "radio_alias" => "some radio_alias",
               "radio_id" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.device_path(conn, :create), device: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update device" do
    setup [:create_device]

    test "renders device when data is valid", %{conn: conn, device: %Device{id: id} = device} do
      conn = put(conn, Routes.device_path(conn, :update, device), device: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.device_path(conn, :show, id))

      assert %{
               "id" => id,
               "allowed_locations" => [],
               "location" => "some updated location",
               "radio_alias" => "some updated radio_alias",
               "radio_id" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, device: device} do
      conn = put(conn, Routes.device_path(conn, :update, device), device: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete device" do
    setup [:create_device]

    test "deletes chosen device", %{conn: conn, device: device} do
      conn = delete(conn, Routes.device_path(conn, :delete, device))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.device_path(conn, :show, device))
      end
    end
  end

  defp create_device(_) do
    device = fixture(:device)
    {:ok, device: device}
  end
end
