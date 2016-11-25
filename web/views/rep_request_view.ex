defmodule CongressNinja.RepRequestView do
  use CongressNinja.Web, :view
  alias CongressNinja.Rep
  alias CongressNinja.Repo

  def render("show.html", assigns) do
    render CongressNinja.RootView, "show.html", assigns
  end

  def render("show.json", %{rep_request: rep_request}) do
    %{
      rep_request: %{
        id:   rep_request.id,
        reps: Enum.map(Repo.all(Ecto.assoc(rep_request, :reps)), fn(rep) ->
          %{
            "id"       => rep.id,
            "state"    => rep.state,
            "district" => rep.district,
            "website"  => rep.website,
            "phone"    => rep.phone,
            "name"     => rep.name,
            "avatar"   => rep.avatar,
            "party"    => rep.party,
            "email"    => rep.email,
            "twitter"  => rep.twitter
          }
        end),
        slug: rep_request.slug
      }
    }
  end

  def render("error.json", errors) do
    errors
  end
end
