defmodule Vutuv.Repo.Migrations.CreateSearchQueryResult do
  use Ecto.Migration

  def change do
    create table(:search_query_results) do
    	add :user_id, references(:users, on_delete: :delete_all)
    	add :search_query_id, references(:search_queries, on_delete: :delete_all)
      timestamps
    end
  end
end
