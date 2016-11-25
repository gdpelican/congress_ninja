defmodule CongressNinja.RepRequestView do
  use CongressNinja.Web, :view
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
            "name" => rep.name
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
