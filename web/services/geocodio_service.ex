defmodule CongressNinja.GeocodioService do
  alias CongressNinja.GeocodioService

  def fetch_state_and_district_by(address) do
    response = address |> url |> HTTPotion.get
    case response.status_code do
      200 ->
        response.body |> Poison.decode! |> extract
      _ ->
        nil
    end
  end

  defp url(address) do
    "https://api.geocod.io/v1/geocode?q=#{URI.encode(address)}&fields=cd&api_key=#{api_key}"
  end

  defp extract(json) do
    results  = json["results"] |> List.first
    {
      get_in(results, ["address_components", "state"]),
      get_in(results, ["fields", "congressional_district", "district_number"])
    }
  end

  defp api_key do
    Application.get_env(:congress_ninja, GeocodioService)[:geocodio_api_key]
  end
end
