defmodule CongressNinja.RepRequest do
  use CongressNinja.Web, :model
  alias CongressNinja.Rep
  alias CongressNinja.Repo
  alias CongressNinja.RepRequest
  alias CongressNinja.GeocodioService
  alias CongressNinja.SlugService

  schema "rep_requests" do
    many_to_many :reps, Rep, join_through: "rep_rep_requests", on_replace: :delete
    field :slug

    timestamps
  end

  def createset(%{ "zip" => zip }) do
    %RepRequest{
      reps: Rep.fetch_reps_by_zip(String.to_integer(zip)),
      slug: SlugService.generate
    }
  end

  def changeset(rep_request, %{ "address" => address }) do
    changeset(rep_request |> Repo.preload(:reps), %{})
    |> put_assoc(:reps, [GeocodioService.fetch_rep_by_address(address)])
    |> validate_required([:reps])
  end

  def changeset(rep_request, params) do
    rep_request
    |> cast(params, [:slug])
    |> validate_required([:slug])
    |> unique_constraint(:slug)
  end
end
