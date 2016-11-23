defmodule CongressNinja.ZipDistrict do
  use CongressNinja.Web, :model

  schema "zip_districts" do
    belongs_to :rep, CongressNinja.Rep
    field :zip, :integer
    field :district, :integer
    field :state

    timestamps
  end
end
