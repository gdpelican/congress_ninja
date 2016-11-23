require IEx
defmodule CongressNinja.RepRequestController do
  use CongressNinja.Web, :controller
  alias CongressNinja.Rep
  alias CongressNinja.RepRequest
  alias CongressNinja.ZipDistrict
  alias CongressNinja.Repo

  def create(conn, params) do
    zip = String.to_integer(params["zip"])
    rep_request = %RepRequest{reps: fetch_reps_by(zip), slug: generate_slug }

    case Repo.insert(rep_request) do
      {:ok, rep_request} ->
        render conn, "show.json", rep_request: rep_request
      {:error, changeset} ->
        render conn, "error.json", errors: changeset.errors
    end
  end

  def update(conn, %{ "id" => id, "rep_request" => rep_request_params }) do
    rep_request = Repo.get(RepRequest, id)
    changeset = RepRequest.changeset(rep_request, rep_request_params)
    case Repo.update(changeset) do
      {:ok, rep_request} ->
        render conn, "show.json", rep_request: rep_request |> Repo.preload(:reps)
      {:error, changeset} ->
        render conn, "error.json", errors: changeset.errors
    end
  end

  def fetch_reps_by(zip) do
    Repo.all from r in Rep,
      join:     zd in ZipDistrict, where: zd.state == r.state and zd.district == r.district,
      where:    zd.zip == ^zip,
      order_by: [:name]
  end

  def generate_slug do
    "'random'"
  end
end
