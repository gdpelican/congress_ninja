# Create the factory in test/support/factory.ex
defmodule CongressNinja.Factory do
  use ExMachina.Ecto, repo: CongressNinja.Repo

  def rep_factory do
    %CongressNinja.Rep{
      name: "Hank Honkhack",
      state: "FL",
      state_name: "Florida",
      district: 10,
      phone: "555-555-5555",
      inserted_at: Ecto.DateTime.utc,
      updated_at: Ecto.DateTime.utc
    }
  end

  def zip_district_factory do
    %CongressNinja.ZipDistrict{
      zip: 99999,
      district: 0,
      state: "AZ",
      inserted_at: Ecto.DateTime.utc,
      updated_at: Ecto.DateTime.utc
    }
  end
end
