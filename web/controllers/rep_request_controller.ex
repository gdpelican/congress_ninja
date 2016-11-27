defmodule CongressNinja.RepRequestController do
  use CongressNinja.Web, :controller
  alias CongressNinja.RepRequest
  alias CongressNinja.Repo

  def index(conn, _params) do
    case conn.cookies["cn-slug"] do
      nil ->
        render conn, "index.html"
      slug ->
        redirect conn, to: "/#{slug}"
    end
  end

  def show(conn, %{ "id" => slug }) do
    case RepRequest.find_by_slug(slug) do
      nil ->
        conn
        |> set_slug_cookie("") # clear the existing cookie if we miss the slug
        |> put_flash(:info, "We couldn't find that page! Try putting in your zip code again?")
        |> redirect(to: "/")
      rep_request ->
        conn
        |> render :show, changeset: RepRequest.changeset(rep_request, %{}), rep_request: rep_request |> Repo.preload(:reps)
    end
  end

  def create(conn, %{ "rep_request" => rep_request_params }) do
    case Repo.insert(RepRequest.changeset(%RepRequest{}, rep_request_params)) do
      {:ok, rep_request} ->
        conn
        |> set_slug_cookie(rep_request.slug, 31536000) # one year expiration
        |> redirect to: "/#{rep_request.slug}"
      {:error, changeset} ->
        conn
        |> put_flash(:info, "We couldn't find that zip code! Try again?")
        |> render(:index, errors: changeset.errors)
    end
  end

  def update(conn, %{ "id" => id, "rep_request" => rep_request_params }) do
    case Repo.update(RepRequest.changeset(Repo.get(RepRequest, id), rep_request_params)) do
      {:ok, rep_request} ->
        conn
        |> redirect to: "/#{rep_request.slug}"
      {:error, changeset} ->
        conn
        |> put_flash(:info, changeset.errors)
        |> render(:index, errors: changeset.errors)
    end
  end

  def clear(conn, _params) do
    conn
    |> set_slug_cookie("")
    |> redirect(to: "/")
  end

  # set the cookie to remember the last search by the user
  # this clears by default; age must be specified to save the cookie.
  defp set_slug_cookie(conn, slug, age \\ 0) do
    Plug.Conn.put_resp_cookie(conn, "cn-slug", slug, max_age: age)
  end
end
