defmodule CongressNinja.Rep do
  use CongressNinja.Web, :model

  schema "reps" do
    many_to_many :rep_requests, CongressNinja.Rep, join_through: "rep_rep_requests"
    has_many :zip_districts, CongressNinja.ZipDistrict
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
end
