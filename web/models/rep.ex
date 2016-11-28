defmodule CongressNinja.Rep do
  use CongressNinja.Web, :model
  alias CongressNinja.Repo
  alias CongressNinja.Rep
  alias CongressNinja.ZipDistrict
  alias CongressNinja.GeocodioService

  schema "reps" do
    many_to_many :rep_requests, Rep, join_through: "rep_rep_requests"
    has_many :zip_districts, ZipDistrict
    field :state
    field :state_name
    field :district, :integer
    field :website
    field :phone
    field :name
    field :avatar
    field :party
    field :email
    field :twitter

    timestamps
  end

  def fetch_reps_by_zip({ zip, _ }) do
    reps = Repo.all from r in Rep,
      join:     zd in ZipDistrict, where: r.id == zd.rep_id,
      where:    zd.zip == ^zip,
      order_by: [:name]
    fetch_reps_by_address(reps, Integer.to_string(zip))
  end

  def fetch_reps_by_zip(_error) do
    []
  end

  def fetch_reps_by_address(reps, address) do
    case length(reps) do
      0 -> # no reps were found by zip code, check by passing the zip code as an address
        GeocodioService.fetch_state_and_district_by(address)
        |> find_by_state_and_district
        |> List.wrap
      _ ->
        reps
    end
  end

  defp find_by_state_and_district(response) do
    case response do
      nil ->
        []
      {nil, _district} ->
        []
      {_state, nil} ->
        []
      {state, district} ->
        Repo.all(from r in Rep,
          join:     zd in ZipDistrict, where: r.id == zd.rep_id,
          where:    zd.state == ^state and zd.district == ^district,
          order_by: [:name]) |> List.first
    end
  end
end
