defmodule MotoSol.Devices do
  @moduledoc """
  The Devices context.
  """

  import Ecto.Query, warn: false
  alias MotoSol.Repo

  alias MotoSol.Devices.Device

  @doc """
  Gets a single device.

  Raises `Ecto.NoResultsError` if the Device does not exist.

  ## Examples

      iex> get_device!(123)
      %Device{}

      iex> get_device!(456)
      ** (Ecto.NoResultsError)

  """
  def get_device!(id), do: Repo.get!(Device, id)
  def get_device_by_radio_id(radio_id), do: Device |> Repo.get_by(radio_id: radio_id)

  def get_device_by_radio_id_with_location(radio_id),
    do: Device |> Device.has_location() |> Repo.get_by(radio_id: radio_id)

  @doc """
  Creates a device.

  ## Examples

      iex> create_device(%{field: value})
      {:ok, %Device{}}

      iex> create_device(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_device(attrs \\ %{}) do
    %Device{}
    |> Device.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a device.

  ## Examples

      iex> update_device(device, %{field: new_value})
      {:ok, %Device{}}

      iex> update_device(device, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_device(%Device{} = device, attrs) do
    device
    |> Device.changeset(attrs)
    |> Repo.update()
  end
end
