defmodule MotoSol.DevicesTest do
  use MotoSol.DataCase

  alias MotoSol.Devices

  describe "devices" do
    alias MotoSol.Devices.Device

    @valid_attrs %{
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

    test "create_device/1 with valid data creates a device" do
      assert {:ok, %Device{} = device} = Devices.create_device(@valid_attrs)
      assert device.allowed_locations == []
      assert device.location == "some location"
      assert device.radio_alias == "some radio_alias"
      assert device.radio_id == 42
    end

    test "create_device/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Devices.create_device(@invalid_attrs)
    end

    test "update_device/2 with valid data updates the device" do
      device = device_fixture()
      assert {:ok, %Device{} = device} = Devices.update_device(device, @update_attrs)
      assert device.allowed_locations == []
      assert device.location == "some updated location"
      assert device.radio_alias == "some updated radio_alias"
      assert device.radio_id == 43
    end

    test "update_device/2 with invalid data returns error changeset" do
      device = device_fixture()
      assert {:error, %Ecto.Changeset{}} = Devices.update_device(device, @invalid_attrs)
      assert device == Devices.get_device!(device.id)
    end
  end
end
