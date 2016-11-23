defmodule CongressNinja.Repo.Migrations.CreateRepresentatives do
  use Ecto.Migration

  def change do
    create table(:representatives) do
      add :state, :string
      add :district, :string
      add :website, :string
      add :phone, :string
      add :name, :string
      add :avatar, :string
      add :party, :string
      add :email, :string
      add :twitter, :string

      timestamps
    end
  end
end
