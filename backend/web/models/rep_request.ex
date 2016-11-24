defmodule CongressNinja.RepRequest do
  use CongressNinja.Web, :model
  alias CongressNinja.Rep
  alias CongressNinja.RepRequest

  schema "rep_requests" do
    many_to_many :reps, Rep, join_through: "rep_rep_requests"
    field :slug

    timestamps
  end

  def createset(%{ "zip" => zip }) do
    %RepRequest{
      reps: Rep.fetch_reps_by(String.to_integer(zip)),
      slug: RepRequest.generate_slug
    }
  end

  def changeset(rep_request, params) do
    rep_request
    |> cast(params, [:slug])
    |> validate_required([:slug])
    |> unique_constraint(:slug)
  end

  def generate_slug do
    "'random'"
  end
end
