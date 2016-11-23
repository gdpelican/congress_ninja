# Create the factory in test/support/factory.ex
defmodule CongressNinja.Factory do
  use ExMachina.Ecto, repo: CongressNinja.Repo

  def representative_factory do
    %CongressNinja.Representative{
      name: "Hank Honkhack",
      state: "Florida",
      district: "10",
      phone: "555-555-5555"
    }
  end
end
