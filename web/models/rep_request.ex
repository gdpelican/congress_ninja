defmodule CongressNinja.RepRequest do
  use CongressNinja.Web, :model

  schema "rep_requests" do
    many_to_many :reps, CongressNinja.Rep, join_through: "rep_rep_requests"
    field :slug

    timestamps
  end
end
