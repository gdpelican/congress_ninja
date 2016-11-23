require IEx
defmodule CongressNinja.RepRequestController do
  use CongressNinja.Web, :controller
  alias CongressNinja.Rep
  alias CongressNinja.RepRequest
  alias CongressNinja.ZipDistrict
  alias CongressNinja.Repo

  def create(conn, %{ "rep_request" => rep_request_params }) do
    case Repo.insert(RepRequest.createset(rep_request_params)) do
      {:ok, rep_request} ->
        render conn, "show.json", rep_request: rep_request |> Repo.preload(:reps)
      {:error, changeset} ->
        render conn, "error.json", errors: changeset.errors
    end
  end

  def update(conn, %{ "id" => id, "rep_request" => rep_request_params }) do
    case Repo.update(RepRequest.changeset(Repo.get(RepRequest, id), rep_request_params)) do
      {:ok, rep_request} ->
        render conn, "show.json", rep_request: rep_request |> Repo.preload(:reps)
      {:error, changeset} ->
        render conn, "error.json", errors: changeset.errors
    end
  end
end
