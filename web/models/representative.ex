defmodule CongressNinja.Representative do
  use CongressNinja.Web, :model

  schema "representatives" do
    field :state
    field :district
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
