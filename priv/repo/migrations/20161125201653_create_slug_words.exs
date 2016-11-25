defmodule CongressNinja.Repo.Migrations.CreateSlugWords do
  use Ecto.Migration

  def change do
    create table(:slug_nouns) do
      add :noun, :string
    end

    create table(:slug_adjectives) do
      add :adjective, :string
    end
  end

end
