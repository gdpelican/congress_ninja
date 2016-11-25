defmodule CongressNinja.GeocodioService do
  alias CongressNinja.Repo
  alias CongressNinja.Rep

  def fetch_rep_by_address(address) do
    case HTTPotion.get "https://api.geocod.io/v1/geocode?q=#{URI.encode(address)}&fields=cd&api_key=#{api_key}" do
      {:ok, body} ->
        body |> Poison.decode! |> locate_rep
      _error_response ->
        []
    end
  end

  defp locate_rep(json) do
    Repo.get_by(Rep, %{
      state:    get_in(json, ["results", "address_components", "state"]),
      district: get_in(json, ["results", "fields", "congressional_district", "district_number"])
    })
  end

  defp api_key do
    Application.get_env(:congress_ninja, GeocodioService)["geocodio_api_key"]
  end
end
