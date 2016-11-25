defmodule CongressNinja.Rep do
  use CongressNinja.Web, :model
  alias CongressNinja.Repo
  alias CongressNinja.Rep
  alias CongressNinja.ZipDistrict

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

  def fetch_reps_by_zip(zip) do
    Repo.all from r in Rep,
      join:     zd in ZipDistrict, where: r.district == zd.district and r.state == zd.state,
      where:    zd.zip == ^zip,
      order_by: [:name]
  end
end
