defmodule MotoSolWeb.Router do
  use MotoSolWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MotoSolWeb do
    pipe_through :api
    post("/radios/:radio_id", DeviceController, :create)
    get("/radios/:radio_id/location", DeviceController, :get_location)
    post("/radios/:radio_id/location", DeviceController, :set_location)
  end
end
