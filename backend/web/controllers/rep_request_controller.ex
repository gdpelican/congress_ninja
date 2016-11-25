defmodule CongressNinja.RepRequestController do
  use CongressNinja.Web, :controller
  alias CongressNinja.RepRequest
  alias CongressNinja.ErrorView
  alias CongressNinja.Repo

  def show(conn, %{ "id" => slug }) do
    case Repo.get_by(RepRequest, %{ slug: slug }) do
      rep_request -> if rep_request do
        render conn, "show.json", rep_request: rep_request
      else
        put_status(conn, 404) |> render(ErrorView, "404.json", %{ message: "#{slug} not found" })
      end
    end
  end

  def create(conn, %{ "rep_request" => rep_request_params }) do
    case Repo.insert(RepRequest.createset(rep_request_params)) do
      {:ok, rep_request} ->
        render conn, "show.json", rep_request: rep_request
      {:error, changeset} ->
        render conn, "error.json", errors: changeset.errors
    end
  end

  def update(conn, %{ "id" => id, "rep_request" => rep_request_params }) do
    case Repo.update(RepRequest.changeset(Repo.get(RepRequest, id), rep_request_params)) do
      {:ok, rep_request} ->
        render conn, "show.json", rep_request: rep_request
      {:error, changeset} ->
        render conn, "error.json", errors: changeset.errors
    end
  end
end
