defmodule CongressNinja.Repo.Migrations.BurnItUp do
  use Ecto.Migration

  def change do
    create table(:reps) do
      add :state, :string
      add :state_name, :string
      add :district, :integer
      add :website, :string
      add :phone, :string
      add :name, :string
      add :avatar, :string
      add :party, :string
      add :email, :string
      add :twitter, :string

      timestamps
    end

    create table(:rep_requests) do
      add :slug, :string

      timestamps
    end

    create table(:rep_rep_requests) do
      add :rep_request_id, :integer
      add :rep_id,         :integer
    end

    create table(:zip_districts) do
      add :rep_id,   :integer
      add :zip,      :integer
      add :district, :integer
      add :state,    :string
    end
  end
end
