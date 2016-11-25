defmodule CongressNinja.RepRequestController do
  use CongressNinja.Web, :controller
  alias CongressNinja.RepRequest
  alias CongressNinja.ErrorView
  alias CongressNinja.Repo

  def index(conn, _params) do
    render conn, "index.html"
  end

  def show(conn, %{ "id" => slug }) do
    case Repo.get_by(RepRequest, %{ slug: slug }) do
      rep_request -> if rep_request do
        render conn, :show, rep_request: rep_request |> Repo.preload(:reps)
      else
        redirect conn, to: "/"
      end
    end
  end

  def create(conn, %{ "rep_request" => rep_request_params }) do
    case Repo.insert(RepRequest.changeset(%RepRequest{}, rep_request_params)) do
      {:ok, rep_request} ->
        redirect conn, to: "/#{rep_request.slug}"
      {:error, changeset} ->
        conn
        |> put_flash(:error, "We couldn't find that zip code! Try again?")
        |> render(:index, errors: changeset.errors)
    end
  end

  def update(conn, %{ "id" => id, "rep_request" => rep_request_params }) do
    case Repo.update(RepRequest.changeset(Repo.get(RepRequest, id), rep_request_params)) do
      {:ok, rep_request} ->
        redirect conn, to: "/#{rep_request.slug}"
      {:error, changeset} ->
        conn
        |> put_flash(:error, IO.inspect(changeset.errors))
        |> render(:index, errors: changeset.errors)
      end
  end
end
