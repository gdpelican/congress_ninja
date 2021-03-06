defmodule CongressNinja.RepRequest do
  use CongressNinja.Web, :model
  alias CongressNinja.Rep
  alias CongressNinja.Repo
  alias CongressNinja.RepRequest
  alias CongressNinja.SlugService

  schema "rep_requests" do
    many_to_many :reps, Rep, join_through: "rep_rep_requests", on_replace: :delete
    field :slug

    timestamps
  end

  def changeset(rep_request, %{ "slug" => slug, "address" => address }) do
    changeset(rep_request, %{
      "reps" => Rep.fetch_reps_by_address([], address),
      "slug" => slug
    })
  end

  def changeset(rep_request, %{ "zip" => zip }) do
    changeset(rep_request, %{
      "reps" => Rep.fetch_reps_by_zip(Integer.parse(zip)),
      "slug" => SlugService.generate
    })
  end

  def changeset(rep_request, %{ "reps" => reps, "slug" => slug }) do
    rep_request
    |> Repo.preload(:reps)
    |> changeset(%{"slug" => slug})
    |> put_assoc(:reps, reps)
    |> validate_rep_association(reps)
  end

  def changeset(rep_request, params) do
    rep_request
    |> cast(params, [:slug])
    |> validate_required([:slug])
    |> unique_constraint(:slug)
  end

  def validate_rep_association(changeset, reps) do
    cond do
      length(reps) == 0 ->
        add_error changeset, :reps, "At least one rep is needed"
      true ->
        changeset
    end
  end

  def find_by_slug(slug) do
    Repo.get_by(RepRequest, %{ slug: slug })
  end
end
