defmodule MotoSolWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use MotoSolWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(MotoSolWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  # Not found
  def call(conn, nil) do
    conn
    |> put_status(404)
    |> put_view(MotoSolWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(MotoSolWeb.ErrorView)
    |> render(:"404")
  end
end
