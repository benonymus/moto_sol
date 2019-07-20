defmodule MotoSol.DevicesTest do
  use MotoSol.DataCase

  alias MotoSol.Devices

  describe "devices" do
    alias MotoSol.Devices.Device

    @valid_attrs %{
      allowed_locations: ["cph-1"],
      alias: "some radio_alias",
      radio_id: 42
    }
    @update_attrs %{
      allowed_locations: ["cph-1", "cph-2"],
      location: "cph-2",
      alias: "some updated radio_alias",
      radio_id: 43
    }
    @invalid_attrs %{allowed_locations: nil, location: nil, alias: nil, radio_id: nil}

    def device_fixture(attrs \\ %{}) do
      {:ok, device} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Devices.create_device()

      device
    end

    test "get_device!/1 returns the device with given id" do
      device = device_fixture()
      assert Devices.get_device!(device.id) == device
    end

    test "get_device_by_radio_id/1 returns the device with given radio_id" do
      device = device_fixture()
      assert Devices.get_device_by_radio_id(device.radio_id) == device
    end

    test "get_device_by_radio_id_with_location/1 returns the device with given radio_id if it has a location" do
      device = device_fixture(%{location: "cph-1"})
      assert Devices.get_device_by_radio_id_with_location(device.radio_id) == device
    end

    test "create_device/1 with valid data creates a device" do
      assert {:ok, %Device{} = device} = Devices.create_device(@valid_attrs)
      assert device.allowed_locations == ["cph-1"]
      assert device.alias == "some radio_alias"
      assert device.radio_id == 42
    end

    test "create_device/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Devices.create_device(@invalid_attrs)
    end

    test "update_device/2 with valid data updates the device" do
      device = device_fixture()
      assert {:ok, %Device{} = device} = Devices.update_device(device, @update_attrs)
      assert device.allowed_locations == ["cph-1", "cph-2"]
      assert device.location == "cph-2"
      assert device.alias == "some updated radio_alias"
      assert device.radio_id == 43
    end

    test "update_device/2 with invalid data returns error changeset" do
      device = device_fixture()
      assert {:error, %Ecto.Changeset{}} = Devices.update_device(device, @invalid_attrs)
      assert device == Devices.get_device!(device.id)
    end
  end
end
